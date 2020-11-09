use base58::ToBase58;
use bip39::{Language, Mnemonic};
use codec::{Decode, Encode};
use regex::Regex;
use schnorrkel::{
	derive::{ChainCode, Derivation},
	ExpansionMode, Keypair, MiniSecretKey, PublicKey, SecretKey, Signature,
};
use substrate_bip39::mini_secret_from_entropy;

use lazy_static::lazy_static;

pub struct KeyPair(schnorrkel::Keypair);

const SIGNING_CTX: &[u8] = b"substrate";
const JUNCTION_ID_LEN: usize = 32;
const CHAIN_CODE_LENGTH: usize = 32;

impl KeyPair {
	pub fn from_bip39_phrase(phrase: &str, password: Option<&str>) -> Option<KeyPair> {
		let mnemonic = Mnemonic::from_phrase(phrase, Language::English).ok()?;
		let mini_secret_key =
			mini_secret_from_entropy(mnemonic.entropy(), password.unwrap_or("")).ok()?;

		Some(KeyPair(
			mini_secret_key.expand_to_keypair(ExpansionMode::Ed25519),
		))
	}

	pub fn from_seed(seed: &[u8]) -> Option<KeyPair> {
		let mini_secret_key = MiniSecretKey::from_bytes(seed).ok()?;
		Some(KeyPair(
			mini_secret_key.expand_to_keypair(ExpansionMode::Ed25519),
		))
	}

	pub fn get_public(&self) -> PublicKey {
		self.0.public
	}

	// Should match implementation at https://github.com/paritytech/substrate/blob/master/core/primitives/src/crypto.rs#L653-L682
	pub fn from_suri(suri: &str) -> Option<KeyPair> {
		lazy_static! {
			static ref RE_SURI: Regex = {
				Regex::new(r"^(?P<phrase>\w+( \w+)*)?(?P<path>(//?[^/]+)*)(///(?P<password>.*))?$")
					.expect("constructed from known-good static value; qed")
			};
			static ref RE_JUNCTION: Regex =
				Regex::new(r"/(/?[^/]+)").expect("constructed from known-good static value; qed");
		}

		let cap = RE_SURI.captures(suri)?;
		let path = RE_JUNCTION
			.captures_iter(&cap["path"])
			.map(|j| DeriveJunction::from(&j[1]));

		let pair = Self::from_bip39_phrase(
			cap.name("phrase").map(|p| p.as_str())?,
			cap.name("password").map(|p| p.as_str()),
		)?;

		Some(pair.derive(path))
	}

	fn derive(&self, path: impl Iterator<Item = DeriveJunction>) -> Self {
		let init = self.0.secret.clone();
		let result = path.fold(init, |acc, j| match j {
			DeriveJunction::Soft(cc) => acc.derived_key_simple(ChainCode(cc), &[]).0,
			DeriveJunction::Hard(cc) => derive_hard_junction(&acc, cc),
		});

		KeyPair(result.to_keypair())
	}

	pub fn ss58_address(&self, prefix: u8) -> String {
		let mut v = vec![prefix];
		v.extend_from_slice(&self.0.public.to_bytes());
		let r = ss58hash(&v);
		v.extend_from_slice(&r.as_bytes()[0..2]);
		v.to_base58()
	}

	pub fn sign(&self, message: &[u8]) -> [u8; 64] {
		let context = schnorrkel::signing_context(SIGNING_CTX);
		self.0.sign(context.bytes(message)).to_bytes()
	}

	pub fn verify_signature(&self, message: &[u8], signature: &[u8]) -> Option<bool> {
		let context = schnorrkel::signing_context(SIGNING_CTX);

		let signature = Signature::from_bytes(signature).ok()?;

		Some(self.0.verify(context.bytes(&message), &signature).is_ok())
	}
}

fn derive_hard_junction(secret: &SecretKey, cc: [u8; CHAIN_CODE_LENGTH]) -> SecretKey {
	secret
		.hard_derive_mini_secret_key(Some(ChainCode(cc)), b"")
		.0
		.expand(ExpansionMode::Ed25519)
}

/// A since derivation junction description. It is the single parameter used when creating
/// a new secret key from an existing secret key and, in the case of `SoftRaw` and `SoftIndex`
/// a new public key from an existing public key.
#[derive(Copy, Clone, Eq, PartialEq, Hash, Debug, Encode, Decode)]
enum DeriveJunction {
	/// Soft (vanilla) derivation. Public keys have a correspondent derivation.
	Soft([u8; JUNCTION_ID_LEN]),
	/// Hard ("hardened") derivation. Public keys do not have a correspondent derivation.
	Hard([u8; JUNCTION_ID_LEN]),
}

impl DeriveJunction {
	/// Consume self to return a hard derive junction with the same chain code.
	fn harden(self) -> Self {
		DeriveJunction::Hard(self.unwrap_inner())
	}

	/// Create a new soft (vanilla) DeriveJunction from a given, encodable, value.
	///
	/// If you need a hard junction, use `hard()`.
	fn soft<T: Encode>(index: T) -> Self {
		let mut cc: [u8; JUNCTION_ID_LEN] = Default::default();
		index.using_encoded(|data| {
			if data.len() > JUNCTION_ID_LEN {
				let hash_result = blake2_rfc::blake2b::blake2b(JUNCTION_ID_LEN, &[], data);
				let hash = hash_result.as_bytes();
				cc.copy_from_slice(hash);
			} else {
				cc[0..data.len()].copy_from_slice(data);
			}
		});
		DeriveJunction::Soft(cc)
	}

	/// Consume self to return the chain code.
	fn unwrap_inner(self) -> [u8; JUNCTION_ID_LEN] {
		match self {
			DeriveJunction::Hard(c) | DeriveJunction::Soft(c) => c,
		}
	}
}

impl<T: AsRef<str>> From<T> for DeriveJunction {
	fn from(j: T) -> DeriveJunction {
		let j = j.as_ref();
		let (code, hard) = if j.starts_with("/") {
			(&j[1..], true)
		} else {
			(j, false)
		};

		let res = if let Ok(n) = str::parse::<u64>(code) {
			// number
			DeriveJunction::soft(n)
		} else {
			// something else
			DeriveJunction::soft(code)
		};

		if hard {
			res.harden()
		} else {
			res
		}
	}
}

fn ss58hash(data: &[u8]) -> blake2_rfc::blake2b::Blake2bResult {
	const PREFIX: &[u8] = b"SS58PRE";

	let mut context = blake2_rfc::blake2b::Blake2b::new(64);
	context.update(PREFIX);
	context.update(data);
	context.finalize()
}

fn create_cc(data: &[u8]) -> ChainCode {
	let mut cc = [0u8; CHAIN_CODE_LENGTH];

	cc.copy_from_slice(&data);

	ChainCode(cc)
}

/// Perform a derivation on a secret
///
/// * secret: UIntArray with 64 bytes
/// * cc: UIntArray with 32 bytes
///
/// returned vector the derived keypair as a array of 96 bytes
#[no_mangle]
pub fn ext_sr_derive_keypair_hard(pair: &[u8], cc: &[u8]) -> Vec<u8> {
	Keypair::from_half_ed25519_bytes(pair)
		.unwrap()
		.secret
		.hard_derive_mini_secret_key(Some(create_cc(cc)), &[])
		.0
		.expand_to_keypair(ExpansionMode::Ed25519)
		.to_half_ed25519_bytes()
		.to_vec()
}

/// Perform a derivation on a secret
///
/// * secret: UIntArray with 64 bytes
/// * cc: UIntArray with 32 bytes
///
/// returned vector the derived keypair as a array of 96 bytes
#[no_mangle]
pub fn ext_sr_derive_keypair_soft(pair: &[u8], cc: &[u8]) -> Vec<u8> {
	Keypair::from_half_ed25519_bytes(pair)
		.unwrap()
		.derived_key_simple(create_cc(cc), &[])
		.0
		.to_half_ed25519_bytes()
		.to_vec()
}

/// Perform a derivation on a publicKey
///
/// * pubkey: UIntArray with 32 bytes
/// * cc: UIntArray with 32 bytes
///
/// returned vector is the derived publicKey as a array of 32 bytes
#[no_mangle]
pub fn ext_sr_derive_public_soft(pubkey: &[u8], cc: &[u8]) -> Vec<u8> {
	PublicKey::from_bytes(pubkey)
		.unwrap()
		.derived_key_simple(create_cc(cc), &[])
		.0
		.to_bytes()
		.to_vec()
}

/// Generate a key pair.
///
/// * seed: UIntArray with 32 element
///
/// returned vector is the concatenation of first the private key (64 bytes)
/// followed by the public key (32) bytes.
#[no_mangle]
pub fn ext_sr_from_seed(seed: &[u8]) -> Vec<u8> {
	MiniSecretKey::from_bytes(seed)
		.unwrap()
		.expand_to_keypair(ExpansionMode::Ed25519)
		.to_half_ed25519_bytes()
		.to_vec()
}

/// Generate a key pair from a known pair. (This is not exposed via WASM)
///
/// * seed: UIntArray with 96 element
///
/// returned vector is the concatenation of first the private key (64 bytes)
/// followed by the public key (32) bytes.
#[no_mangle]
pub fn ext_sr_from_pair(pair: &[u8]) -> Vec<u8> {
	Keypair::from_half_ed25519_bytes(pair)
		.unwrap()
		.to_half_ed25519_bytes()
		.to_vec()
}

/// Sign a message
///
/// The combination of both public and private key must be provided.
/// This is effectively equivalent to a keypair.
///
/// * pubkey: UIntArray with 32 element
/// * private: UIntArray with 64 element
/// * message: Arbitrary length UIntArray
///
/// * returned vector is the signature consisting of 64 bytes.
#[no_mangle]
pub fn ext_sr_sign(pubkey: &[u8], secret: &[u8], message: &[u8]) -> Vec<u8> {
	SecretKey::from_ed25519_bytes(secret)
		.unwrap()
		.sign_simple(
			SIGNING_CTX,
			message,
			&PublicKey::from_bytes(pubkey).unwrap(),
		)
		.to_bytes()
		.to_vec()
}

/// Verify a message and its corresponding against a public key;
///
/// * signature: UIntArray with 64 element
/// * message: Arbitrary length UIntArray
/// * pubkey: UIntArray with 32 element
#[no_mangle]
pub fn ext_sr_verify(signature: &[u8], message: &[u8], pubkey: &[u8]) -> bool {
	match Signature::from_bytes(signature) {
		Ok(signature) => PublicKey::from_bytes(pubkey)
			.unwrap()
			.verify_simple(SIGNING_CTX, message, &signature)
			.is_ok(),
		Err(_) => false,
	}
}

#[cfg(test)]
pub mod tests {
	extern crate rand;
	extern crate schnorrkel;

	use super::*;
	use hex_literal::hex;
	use schnorrkel::{KEYPAIR_LENGTH, SECRET_KEY_LENGTH, SIGNATURE_LENGTH};

	fn generate_random_seed() -> Vec<u8> {
		(0..32).map(|_| rand::random::<u8>()).collect()
	}

	#[test]
	fn can_create_keypair() {
		let seed = generate_random_seed();
		let keypair = ext_sr_from_seed(seed.as_slice());

		assert!(keypair.len() == KEYPAIR_LENGTH);
	}

	#[test]
	fn creates_pair_from_known_seed() {
		let seed = hex!("fac7959dbfe72f052e5a0c3c8d6530f202b02fd8f9f5ca3580ec8deb7797479e");
		let expected = hex!("46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a");
		let keypair = ext_sr_from_seed(&seed);
		let public = &keypair[SECRET_KEY_LENGTH..KEYPAIR_LENGTH];

		assert_eq!(public, expected);
	}

	#[test]
	fn create_pair_from_known_pair() {
		let input = hex!("28b0ae221c6bb06856b287f60d7ea0d98552ea5a16db16956849aa371db3eb51fd190cce74df356432b410bd64682309d6dedb27c76845daf388557cbac3ca3446ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a");
		let keypair = ext_sr_from_pair(&input);
		let expected = hex!("46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a");
		let public = &keypair[SECRET_KEY_LENGTH..KEYPAIR_LENGTH];

		assert_eq!(public, expected);
	}

	#[test]
	fn can_sign_message() {
		let seed = generate_random_seed();
		let keypair = ext_sr_from_seed(seed.as_slice());
		let private = &keypair[0..SECRET_KEY_LENGTH];
		let public = &keypair[SECRET_KEY_LENGTH..KEYPAIR_LENGTH];
		let message = b"this is a message";
		let signature = ext_sr_sign(public, private, message);

		assert!(signature.len() == SIGNATURE_LENGTH);
	}

	#[test]
	fn can_verify_message() {
		let seed = generate_random_seed();
		let keypair = ext_sr_from_seed(seed.as_slice());
		let private = &keypair[0..SECRET_KEY_LENGTH];
		let public = &keypair[SECRET_KEY_LENGTH..KEYPAIR_LENGTH];
		let message = b"this is a message";
		let signature = ext_sr_sign(public, private, message);
		let is_valid = ext_sr_verify(&signature[..], message, public);

		assert!(is_valid);
	}

	#[test]
	fn can_verify_known_message() {
		let message =
			b"I hereby verify that I control 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY";
		let public = hex!("d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d");
		let signature = hex!("1037eb7e51613d0dcf5930ae518819c87d655056605764840d9280984e1b7063c4566b55bf292fcab07b369d01095879b50517beca4d26e6a65866e25fec0d83");
		let is_valid = ext_sr_verify(&signature, message, &public);

		assert!(is_valid);
	}

	#[test]
	fn soft_derives_pair() {
		let cc = hex!("0c666f6f00000000000000000000000000000000000000000000000000000000"); // foo
		let seed = hex!("fac7959dbfe72f052e5a0c3c8d6530f202b02fd8f9f5ca3580ec8deb7797479e");
		let expected = hex!("40b9675df90efa6069ff623b0fdfcf706cd47ca7452a5056c7ad58194d23440a");
		let keypair = ext_sr_from_seed(&seed);
		let derived = ext_sr_derive_keypair_soft(&keypair, &cc);
		let public = &derived[SECRET_KEY_LENGTH..KEYPAIR_LENGTH];

		assert_eq!(public, expected);
	}

	#[test]
	fn soft_derives_public() {
		let cc = hex!("0c666f6f00000000000000000000000000000000000000000000000000000000"); // foo
		let public = hex!("46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a");
		let expected = hex!("40b9675df90efa6069ff623b0fdfcf706cd47ca7452a5056c7ad58194d23440a");
		let derived = ext_sr_derive_public_soft(&public, &cc);

		assert_eq!(derived, expected);
	}

	#[test]
	fn hard_derives_pair() {
		let cc = hex!("14416c6963650000000000000000000000000000000000000000000000000000"); // Alice
		let seed = hex!("fac7959dbfe72f052e5a0c3c8d6530f202b02fd8f9f5ca3580ec8deb7797479e");
		let expected = hex!("d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d");
		let keypair = ext_sr_from_seed(&seed);
		let derived = ext_sr_derive_keypair_hard(&keypair, &cc);
		let public = &derived[SECRET_KEY_LENGTH..KEYPAIR_LENGTH];

		assert_eq!(public, expected);
	}
}
