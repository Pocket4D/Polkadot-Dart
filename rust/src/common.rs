pub use derivation_path::DerivationPath;
use std::ffi::CString;
use std::os::raw::c_char;

use super::bip32;
use super::bip39;
use super::ed25519;
use super::hashing;
use super::sr25519;
use super::util::{get_ptr, get_ptr_from_u8vec, get_str, get_u8vec_from_ptr};

#[no_mangle]
pub extern "C" fn rust_cstr_free(s: *mut c_char) {
    unsafe {
        if s.is_null() {
            return;
        }
        CString::from_raw(s)
    };
}

// Binding bip39 to dart

#[no_mangle]
pub extern "C" fn bip39_generate(words_number: u32) -> *mut c_char {
    let phrase = bip39::ext_bip39_generate(words_number);
    return match bip39::ext_bip39_validate(&phrase) {
        true => get_ptr(&phrase),
        false => get_ptr("Error: Generating phrases failed"),
    };
}

#[no_mangle]
pub extern "C" fn bip39_validate(phrase: *const c_char) -> bool {
    bip39::ext_bip39_validate(&get_str(phrase))
}

#[no_mangle]
pub extern "C" fn bip39_to_entropy(phrase: *const c_char) -> *mut c_char {
    let validated_phrase = match bip39_validate(phrase) {
        true => phrase,
        false => return get_ptr("Error: Phrases are in-valid"),
    };
    let result_vec = bip39::ext_bip39_to_entropy(&get_str(validated_phrase));
    get_ptr_from_u8vec(result_vec)
}

#[no_mangle]
pub extern "C" fn bip39_to_mini_secret(
    phrase: *const c_char,
    password: *const c_char,
) -> *mut c_char {
    let validated_phrase = match bip39_validate(phrase) {
        true => phrase,
        false => return get_ptr("Error: Phrases are in-valid"),
    };
    let result_vec: Vec<u8> =
        bip39::ext_bip39_to_mini_secret(&get_str(validated_phrase), &get_str(password));
    get_ptr_from_u8vec(result_vec)
}

#[no_mangle]
pub extern "C" fn bip39_to_seed(phrase: *const c_char, password: *const c_char) -> *mut c_char {
    let validated_phrase = match bip39_validate(phrase) {
        true => phrase,
        false => return get_ptr("Error: Phrases are in-valid"),
    };
    let result_vec: Vec<u8> =
        bip39::ext_bip39_to_seed(&get_str(validated_phrase), &get_str(password));
    get_ptr_from_u8vec(result_vec)
}

// Binding hashing to dart
#[no_mangle]
pub extern "C" fn blake2b(data: *const c_char, key: *const c_char, size: u32) -> *mut c_char {
    let result_vec = hashing::ext_blake2b(&get_u8vec_from_ptr(data), get_str(key).as_bytes(), size);
    get_ptr_from_u8vec(result_vec)
}

#[no_mangle]
pub extern "C" fn keccak256(data: *const c_char) -> *mut c_char {
    let result_vec = hashing::ext_keccak256(get_str(data).as_bytes());
    get_ptr_from_u8vec(result_vec)
}

#[no_mangle]
pub extern "C" fn pbkdf2(data: *const c_char, salt: *const c_char, rounds: u32) -> *mut c_char {
    let result_vec =
        hashing::ext_pbkdf2(get_str(data).as_bytes(), get_str(salt).as_bytes(), rounds);
    get_ptr_from_u8vec(result_vec)
}

#[no_mangle]
pub extern "C" fn scrypt(
    password: *const c_char,
    salt: *const c_char,
    log2_n: u8,
    r: u32,
    p: u32,
) -> *mut c_char {
    let result_vec = hashing::ext_scrypt(
        get_str(password).as_bytes(),
        get_str(salt).as_bytes(),
        log2_n,
        r,
        p,
    );
    get_ptr_from_u8vec(result_vec)
}

#[no_mangle]
pub extern "C" fn sha512(data: *const c_char) -> *mut c_char {
    let result_vec = hashing::ext_sha512(get_str(data).as_bytes());
    get_ptr_from_u8vec(result_vec)
}

#[no_mangle]
pub extern "C" fn twox(data: *const c_char, rounds: u32) -> *mut c_char {
    let result_vec = hashing::ext_twox(get_str(data).as_bytes(), rounds);
    get_ptr_from_u8vec(result_vec)
}

#[no_mangle]
pub extern "C" fn xxhash64(data: *const c_char, seed: u32) -> *mut c_char {
    let result_vec = hashing::ext_xxhash(get_str(data).as_bytes(), seed);
    get_ptr_from_u8vec(result_vec)
}

// bind bip32 to dart
#[no_mangle]
pub extern "C" fn bip32_get_private_key(seed: *const c_char, path: *const c_char) -> *mut c_char {
    let vector_path: DerivationPath = get_str(path).parse().unwrap();
    let node = bip32::root(get_str(seed).as_str())
        .derive(&vector_path)
        .unwrap();
    let sk: Vec<u8> = node.secret_key.to_bytes()[..].to_vec();
    get_ptr_from_u8vec(sk)
}

// get pub from prv or seed, for supporting multi-coin
#[no_mangle]
pub extern "C" fn ed25519_get_pub_from_prv(private_key: *const c_char) -> *mut c_char {
    let sk_vec = get_u8vec_from_ptr(private_key);
    let sk = ed25519_dalek::SecretKey::from_bytes(&sk_vec[..]).unwrap();
    let pk = ed25519_dalek::PublicKey::from(&sk);
    let pk_vec: Vec<u8> = pk.to_bytes()[..].to_vec();
    get_ptr_from_u8vec(pk_vec)
}

#[no_mangle]
pub extern "C" fn secp256k1_get_pub_from_prv(private_key: *const c_char) -> *mut c_char {
    let sk_vec = get_u8vec_from_ptr(private_key);
    let s = secp256k1::Secp256k1::new();
    let sk = secp256k1::key::SecretKey::from_slice(&sk_vec[..32]).unwrap();
    let pk = secp256k1::key::PublicKey::from_secret_key(&s, &sk);
    let new_box: Box<[u8]> = Box::new(pk.serialize());
    let result = new_box.into_vec();
    get_ptr_from_u8vec(result)
}

#[no_mangle]
pub extern "C" fn sr25519_get_pub_from_seed(seed: *const c_char) -> *mut c_char {
    let seed_vec = get_u8vec_from_ptr(seed);
    let keypair_option = sr25519::KeyPair::from_seed(&seed_vec[..32]);
    let keypair = match keypair_option {
        Some(c) => c,
        _ => panic!("keypair wrong"),
    };
    let result_vec: Vec<u8> = keypair.get_public().to_bytes()[..].to_vec();
    get_ptr_from_u8vec(result_vec)
}

// ed25519KeypairFromSeed
#[no_mangle]
pub extern "C" fn ed25519_keypair_from_seed(seed: *const c_char) -> *mut c_char {
    let seed_vec = get_u8vec_from_ptr(seed);
    // println!("seed_vec:{:?}", seed_vec);
    let result_vec = ed25519::ext_ed_from_seed(&seed_vec);
    get_ptr_from_u8vec(result_vec)
}

// ed25519Sign
#[no_mangle]
pub extern "C" fn ed25519_sign(
    pubkey: *const c_char,
    seckey: *const c_char,
    message: *const c_char,
) -> *mut c_char {
    let pubkey_vec = get_u8vec_from_ptr(pubkey);
    let seckey_vec = get_u8vec_from_ptr(seckey);
    let message_vec = get_u8vec_from_ptr(message);
    let result_vec = ed25519::ext_ed_sign(&pubkey_vec, &seckey_vec, &message_vec);
    get_ptr_from_u8vec(result_vec)
}
// ed25519Verify
#[no_mangle]
pub extern "C" fn ed25519_verify(
    signature: *const c_char,
    message: *const c_char,
    pubkey: *const c_char,
) -> bool {
    let signature_vec = get_u8vec_from_ptr(signature);
    let message_vec = get_u8vec_from_ptr(message);
    let pubkey_vec = get_u8vec_from_ptr(pubkey);
    ed25519::ext_ed_verify(&signature_vec, &message_vec, &pubkey_vec)
}

// sr25519DeriveKeypairHard
#[no_mangle]
pub extern "C" fn sr25519_derive_keypair_hard(
    pair: *const c_char,
    cc: *const c_char,
) -> *mut c_char {
    let pair_vec = get_u8vec_from_ptr(pair);
    let cc_vec = get_u8vec_from_ptr(cc);
    let result_vec: Vec<u8> = sr25519::ext_sr_derive_keypair_hard(&pair_vec, &cc_vec);
    get_ptr_from_u8vec(result_vec)
}
// sr25519DeriveKeypairSoft
#[no_mangle]
pub extern "C" fn sr25519_derive_keypair_soft(
    pair: *const c_char,
    cc: *const c_char,
) -> *mut c_char {
    let pair_vec = get_u8vec_from_ptr(pair);
    let cc_vec = get_u8vec_from_ptr(cc);
    let result_vec: Vec<u8> = sr25519::ext_sr_derive_keypair_soft(&pair_vec, &cc_vec);
    get_ptr_from_u8vec(result_vec)
}
// sr25519DerivePublicSoft
#[no_mangle]
pub extern "C" fn sr25519_derive_public_soft(
    pubkey: *const c_char,
    cc: *const c_char,
) -> *mut c_char {
    let pubkey_vec = get_u8vec_from_ptr(pubkey);
    let cc_vec = get_u8vec_from_ptr(cc);
    let result_vec: Vec<u8> = sr25519::ext_sr_derive_public_soft(&pubkey_vec, &cc_vec);
    get_ptr_from_u8vec(result_vec)
}
// sr25519KeypairFromSeed
#[no_mangle]
pub extern "C" fn sr25519_keypair_from_seed(seed: *const c_char) -> *mut c_char {
    let seed_vec = get_u8vec_from_ptr(seed);
    let result_vec: Vec<u8> = sr25519::ext_sr_from_seed(&seed_vec);
    get_ptr_from_u8vec(result_vec)
}

// sr25519KeypairFromPair
#[no_mangle]
pub extern "C" fn sr25519_keypair_from_pair(pair: *const c_char) -> *mut c_char {
    let pair_vec = get_u8vec_from_ptr(pair);
    let result_vec: Vec<u8> = sr25519::ext_sr_from_pair(&pair_vec);
    get_ptr_from_u8vec(result_vec)
}
// sr25519Sign
#[no_mangle]
pub extern "C" fn sr25519_sign(
    pubkey: *const c_char,
    seckey: *const c_char,
    message: *const c_char,
) -> *mut c_char {
    let pubkey_vec = get_u8vec_from_ptr(pubkey);
    let seckey_vec = get_u8vec_from_ptr(seckey);
    let message_vec = get_u8vec_from_ptr(message);
    let result_vec = sr25519::ext_sr_sign(&pubkey_vec, &seckey_vec, &message_vec);
    get_ptr_from_u8vec(result_vec)
}
// sr25519Verify
#[no_mangle]
pub extern "C" fn sr25519_verify(
    signature: *const c_char,
    message: *const c_char,
    pubkey: *const c_char,
) -> bool {
    let signature_vec = get_u8vec_from_ptr(signature);
    let message_vec = get_u8vec_from_ptr(message);
    let pubkey_vec = get_u8vec_from_ptr(pubkey);
    sr25519::ext_sr_verify(&signature_vec, &message_vec, &pubkey_vec)
}

#[cfg(test)]
pub mod tests {
    use super::*;
    use ed25519_dalek;
    use hex_literal::hex;
    use rustc_hex::ToHex;
    fn generate_random_seed() -> Vec<u8> {
        (0..32).map(|_| rand::random::<u8>()).collect()
    }

    #[test]
    fn can_bip39_to_entropy() {
        let phrase = "legal winner thank year wave sausage worth useful legal winner thank yellow";
        let entropy = hex!("7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f");
        let result = bip39_to_entropy(get_ptr(&phrase));
        let message = get_u8vec_from_ptr(result);
        assert_eq!(message, entropy);
    }

    #[test]
    fn can_bip39_to_mini_secret() {
        let phrase = "legal winner thank year wave sausage worth useful legal winner thank yellow";
        let password = "Substrate";
        let mini = hex!("4313249608fe8ac10fd5886c92c4579007272cb77c21551ee5b8d60b78041685");
        let result = bip39_to_mini_secret(get_ptr(phrase), get_ptr(password));
        let message = get_u8vec_from_ptr(result);
        assert_eq!(message[..], mini[..]);
    }

    #[test]
    fn can_bip39_to_seed() {
        let phrase = "seed sock milk update focus rotate barely fade car face mechanic mercy";
        let seed = hex!("3c121e20de068083b49c2315697fb59a2d9e8643c24e5ea7628132c58969a027");
        let result = bip39_to_seed(get_ptr(phrase), get_ptr(""));
        let message = get_u8vec_from_ptr(result);
        assert_eq!(message[..], seed[..]);
    }

    #[test]
    fn can_bip39_generate() {
        let phrase = bip39_generate(12);
        let is_valid = bip39_validate(phrase);
        assert!(is_valid);
    }

    #[test]
    fn can_bip39_validate() {
        let is_valid = bip39_validate(get_ptr(
            "seed sock milk update focus rotate barely fade car face mechanic mercy",
        ));
        let is_invalid = bip39_validate(get_ptr(
            "wine photo extra cushion basket dwarf humor cloud truck job boat submit",
        ));

        assert_eq!(is_valid, true);
        assert_eq!(is_invalid, false);
    }

    #[test]
    fn can_blake2b() {
        let data = b"abc";
        let key = "";
        let expected_32 = hex!("bddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319");
        let expected_64 = hex!("ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923");
        let hash_32 = blake2b(get_ptr_from_u8vec(data.to_vec()), get_ptr(key), 32);
        let hash_64 = blake2b(get_ptr_from_u8vec(data.to_vec()), get_ptr(key), 64);
        let message_32 = get_u8vec_from_ptr(hash_32);
        let message_64 = get_u8vec_from_ptr(hash_64);
        assert_eq!(message_32[..], expected_32[..]);
        assert_eq!(message_64[..], expected_64[..]);
    }

    #[test]
    fn can_keccak256() {
        let data = "test value";
        let expected = hex!("2d07364b5c231c56ce63d49430e085ea3033c750688ba532b24029124c26ca5e");
        let hash = keccak256(get_ptr(data));
        let message = get_u8vec_from_ptr(hash);
        assert_eq!(message[..], expected[..]);
    }

    #[test]
    fn can_pbkdf2() {
        let salt = "this is a salt";
        let data = "hello world";
        let expected = hex!("5fcbe04f05300a3ecc5c35d18ea0b78f3f6853d2ae5f3fca374f69a7d1f78b5def5c60dae1a568026c7492511e0c53521e8bb6e03a650e1263265fee92722270");
        let hash = pbkdf2(get_ptr(data), get_ptr(salt), 2048);

        let message = get_u8vec_from_ptr(hash);
        assert_eq!(message[..], expected[..]);
    }

    #[test]
    fn can_scrypt() {
        let password = "password";
        let salt = "salt";
        let expected = hex!("745731af4484f323968969eda289aeee005b5903ac561e64a5aca121797bf7734ef9fd58422e2e22183bcacba9ec87ba0c83b7a2e788f03ce0da06463433cda6");
        let hash = scrypt(get_ptr(password), get_ptr(salt), 14, 8, 1);
        let message = get_u8vec_from_ptr(hash);
        assert_eq!(message[..], expected[..]);
    }

    // // #[test]
    // // fn can_secp256k1_real_eth_sig() {
    // // 	let sig = hex!("7505f2880114da51b3f5d535f8687953c0ab9af4ab81e592eaebebf53b728d2b6dfd9b5bcd70fee412b1f31360e7c2774009305cb84fc50c1d0ff8034dfa5fff1c");
    // // 	let pk = hex!("DF67EC7EAe23D2459694685257b6FC59d1BAA1FE");
    // // 	let data = [42, 0, 0, 0, 0, 0, 0, 0];
    // // 	let msg = ext_keccak256(&ethereum_signable_message(&data));
    // // 	let result = ext_keccak256(&ext_secp256k1_recover(&msg[..], &sig[..]));

    // // 	assert_eq!(result[12..], pk[..]);
    // // }

    #[test]
    fn can_sha512() {
        let data = "hello world";
        let expected = hex!("309ecc489c12d6eb4cc40f50c902f2b4d0ed77ee511a7c7a9bcd3ca86d4cd86f989dd35bc5ff499670da34255b45b0cfd830e81f605dcf7dc5542e93ae9cd76f");
        let hash = sha512(get_ptr(data));
        let message = get_u8vec_from_ptr(hash);
        assert_eq!(message[..], expected[..]);
    }

    #[test]
    fn can_twox() {
        let data = "abc";
        let expected_64 = hex!("990977adf52cbc44");
        let expected_256 = hex!("990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b");
        let hash_64 = twox(get_ptr(data), 1);
        let hash_256 = twox(get_ptr(data), 4);
        let message_64 = get_u8vec_from_ptr(hash_64);
        let message_256 = get_u8vec_from_ptr(hash_256);
        assert_eq!(message_64[..], expected_64[..]);
        assert_eq!(message_256[..], expected_256[..]);
    }

    #[test]
    fn can_xxhash64() {
        let data = "abcd";
        let expected_64 = hex!("e29f70f8b8c96df7");
        let hash_64 = xxhash64(get_ptr(data), 0xabcd);
        let message_64 = get_u8vec_from_ptr(hash_64);
        assert_eq!(message_64[..], expected_64[..]);
    }

    #[test]
    fn can_bip32_get_private_key() {
        let path = "m/0'/1'/2'/2'/1000000000'";
        let seed = "000102030405060708090a0b0c0d0e0f";
        let expected = hex!("8f94d394a8e8fd6b1bc2f3f49f5c47e385281d5c17e65324b0f62483e37e8793");
        let prv = bip32_get_private_key(get_ptr(seed), get_ptr(path));
        let message = get_u8vec_from_ptr(prv);
        assert_eq!(message[..], expected[..]);
    }
    #[test]
    fn can_ed25519_get_pub_from_prv() {
        let prv_str = "8f94d394a8e8fd6b1bc2f3f49f5c47e385281d5c17e65324b0f62483e37e8793";
        let expected = hex!("3c24da049451555d51a7014a37337aa4e12d41e485abccfa46b47dfb2af54b7a");
        let pub_ptr = ed25519_get_pub_from_prv(get_ptr(prv_str));
        let message = get_u8vec_from_ptr(pub_ptr);
        assert_eq!(message[..], expected[..]);
    }

    #[test]
    fn can_secp256k1_get_pub_from_prv() {
        let prv_str = "8f94d394a8e8fd6b1bc2f3f49f5c47e385281d5c17e65324b0f62483e37e8793";
        let expected = hex!("0215197801d5ba7001d143183d04bf4e675be6c24b5101fc89de1659d50dbbaa24");
        let pub_ptr = secp256k1_get_pub_from_prv(get_ptr(prv_str));
        let message = get_u8vec_from_ptr(pub_ptr);
        assert_eq!(message[..], expected[..]);
    }

    #[test]
    fn can_sr25519_get_pub_from_seed() {
        let seed = "9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60";
        let expected = hex!("44a996beb1eef7bdcab976ab6d2ca26104834164ecf28fb375600576fcc6eb0f");
        let pub_ptr = sr25519_get_pub_from_seed(get_ptr(seed));
        let message = get_u8vec_from_ptr(pub_ptr);
        assert_eq!(message[..], expected[..]);
    }
    #[test]
    fn can_ed25519_keypair_from_seed() {
        let seed = b"12345678901234567890123456789012";
        let seed_string: String = seed.to_vec().to_hex();
        let expected = hex!("2f8c6129d816cf51c374bc7f08c3e63ed156cf78aefb4a6550d97b87997977ee");
        let keypair_ptr = ed25519_keypair_from_seed(get_ptr(seed_string.as_str()));
        let keypair = get_u8vec_from_ptr(keypair_ptr);
        let public = &keypair[ed25519_dalek::SECRET_KEY_LENGTH..ed25519_dalek::KEYPAIR_LENGTH];
        assert_eq!(public, expected);
    }

    #[test]
    fn can_ed25519_sign() {
        let seed = generate_random_seed();
        let seed_string: String = seed.as_slice().to_hex();
        let keypair_ptr = ed25519_keypair_from_seed(get_ptr(seed_string.as_str()));
        let keypair = get_u8vec_from_ptr(keypair_ptr);

        let private = &keypair[0..ed25519_dalek::SECRET_KEY_LENGTH];
        let public = &keypair[ed25519_dalek::SECRET_KEY_LENGTH..ed25519_dalek::KEYPAIR_LENGTH];
        let message = b"this is a message";
        let message_string: String = message.to_vec().to_hex();
        let public_ptr = get_ptr_from_u8vec(public.to_vec());
        let private_ptr = get_ptr_from_u8vec(private.to_vec());
        let message_ptr = get_ptr(message_string.as_str());

        let signature_ptr = ed25519_sign(public_ptr, private_ptr, message_ptr);
        let signature = get_u8vec_from_ptr(signature_ptr);
        assert!(signature.len() == ed25519_dalek::SIGNATURE_LENGTH);
    }

    #[test]
    fn can_ed25519_verify_message() {
        let seed = generate_random_seed();
        let seed_string: String = seed.as_slice().to_hex();
        let keypair_ptr = ed25519_keypair_from_seed(get_ptr(seed_string.as_str()));
        let keypair = get_u8vec_from_ptr(keypair_ptr);

        let private = &keypair[0..ed25519_dalek::SECRET_KEY_LENGTH];
        let public = &keypair[ed25519_dalek::SECRET_KEY_LENGTH..ed25519_dalek::KEYPAIR_LENGTH];
        let message = b"this is a message";
        let message_string: String = message.to_vec().to_hex();
        let public_ptr = get_ptr_from_u8vec(public.to_vec());
        let private_ptr = get_ptr_from_u8vec(private.to_vec());
        let message_ptr = get_ptr(message_string.as_str());

        let signature_ptr = ed25519_sign(public_ptr, private_ptr, message_ptr);
        let is_valid = ed25519_verify(signature_ptr, message_ptr, public_ptr);

        assert!(is_valid);
    }

    #[test]
    fn can_ed25519_verify_known() {
        let public = hex!("2f8c6129d816cf51c374bc7f08c3e63ed156cf78aefb4a6550d97b87997977ee");
        let message = b"this is a message";
        let signature = hex!("90588f3f512496f2dd40571d162e8182860081c74e2085316e7c4396918f07da412ee029978e4dd714057fe973bd9e7d645148bf7b66680d67c93227cde95202");

        let public_ptr = get_ptr_from_u8vec(public.to_vec());
        let message_string: String = message.to_vec().to_hex();
        let message_ptr = get_ptr(message_string.as_str());

        let signature_ptr = get_ptr_from_u8vec(signature.to_vec());

        let is_valid = ed25519_verify(signature_ptr, message_ptr, public_ptr);

        assert!(is_valid);
    }

    #[test]
    fn can_ed25519_verify_known_wrong() {
        let public = hex!("2f8c6129d816cf51c374bc7f08c3e63ed156cf78aefb4a6550d97b87997977ee");
        let message = b"this is a message";
        let signature = &[0u8; 64];
        let public_ptr = get_ptr_from_u8vec(public.to_vec());
        let message_string: String = message.to_vec().to_hex();
        let message_ptr = get_ptr(message_string.as_str());

        let signature_ptr = get_ptr_from_u8vec(signature.to_vec());

        let is_valid = ed25519_verify(signature_ptr, message_ptr, public_ptr);

        assert_eq!(is_valid, false);
    }

    #[test]
    fn can_sr25519_keypair_from_seed() {
        let seed = hex!("fac7959dbfe72f052e5a0c3c8d6530f202b02fd8f9f5ca3580ec8deb7797479e");
        let expected = hex!("46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a");
        let keypair_ptr = sr25519_keypair_from_seed(get_ptr_from_u8vec(seed.to_vec()));
        let keypair = get_u8vec_from_ptr(keypair_ptr);
        let public = &keypair[schnorrkel::SECRET_KEY_LENGTH..schnorrkel::KEYPAIR_LENGTH];
        assert_eq!(public, expected);
    }

    #[test]
    fn can_sr25519_sign() {
        let seed = generate_random_seed();
        let seed_string: String = seed.as_slice().to_hex();
        let keypair_ptr = sr25519_keypair_from_seed(get_ptr(seed_string.as_str()));
        let keypair = get_u8vec_from_ptr(keypair_ptr);

        let private = &keypair[0..schnorrkel::SECRET_KEY_LENGTH];
        let public = &keypair[schnorrkel::SECRET_KEY_LENGTH..schnorrkel::KEYPAIR_LENGTH];
        let message = b"this is a message";
        let message_string: String = message.to_vec().to_hex();
        let public_ptr = get_ptr_from_u8vec(public.to_vec());
        let private_ptr = get_ptr_from_u8vec(private.to_vec());
        let message_ptr = get_ptr(message_string.as_str());

        let signature_ptr = sr25519_sign(public_ptr, private_ptr, message_ptr);
        let signature = get_u8vec_from_ptr(signature_ptr);
        assert!(signature.len() == schnorrkel::SIGNATURE_LENGTH);
    }

    #[test]
    fn can_sr25519_verify_message() {
        let seed = generate_random_seed();
        let seed_string: String = seed.as_slice().to_hex();
        let keypair_ptr = sr25519_keypair_from_seed(get_ptr(seed_string.as_str()));
        let keypair = get_u8vec_from_ptr(keypair_ptr);

        let private = &keypair[0..schnorrkel::SECRET_KEY_LENGTH];
        let public = &keypair[schnorrkel::SECRET_KEY_LENGTH..schnorrkel::KEYPAIR_LENGTH];
        let message = b"this is a message";
        let message_string: String = message.to_vec().to_hex();
        let public_ptr = get_ptr_from_u8vec(public.to_vec());
        let private_ptr = get_ptr_from_u8vec(private.to_vec());
        let message_ptr = get_ptr(message_string.as_str());

        let signature_ptr = sr25519_sign(public_ptr, private_ptr, message_ptr);
        let is_valid = sr25519_verify(signature_ptr, message_ptr, public_ptr);

        assert!(is_valid);
    }

    #[test]
    fn can_sr25519_verify_known() {
        let public = hex!("d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d");
        let message =
            b"I hereby verify that I control 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY";
        let signature = hex!("1037eb7e51613d0dcf5930ae518819c87d655056605764840d9280984e1b7063c4566b55bf292fcab07b369d01095879b50517beca4d26e6a65866e25fec0d83");

        let public_ptr = get_ptr_from_u8vec(public.to_vec());
        let message_string: String = message.to_vec().to_hex();
        let message_ptr = get_ptr(message_string.as_str());

        let signature_ptr = get_ptr_from_u8vec(signature.to_vec());

        let is_valid = sr25519_verify(signature_ptr, message_ptr, public_ptr);

        assert!(is_valid);
    }

    #[test]
    fn can_sr25519_soft_derives_pair() {
        let cc = hex!("0c666f6f00000000000000000000000000000000000000000000000000000000"); // foo
        let seed = hex!("fac7959dbfe72f052e5a0c3c8d6530f202b02fd8f9f5ca3580ec8deb7797479e");
        let expected = hex!("40b9675df90efa6069ff623b0fdfcf706cd47ca7452a5056c7ad58194d23440a");
        let seed_string: String = seed.to_hex();
        let cc_string: String = cc.to_hex();
        let keypair = sr25519_keypair_from_seed(get_ptr(seed_string.as_str()));
        let derived = sr25519_derive_keypair_soft(keypair, get_ptr(cc_string.as_str()));
        let derived_vec = get_u8vec_from_ptr(derived);
        let public = &derived_vec[schnorrkel::SECRET_KEY_LENGTH..schnorrkel::KEYPAIR_LENGTH];

        assert_eq!(public, expected);
    }

    #[test]
    fn can_sr25519_soft_derives_public() {
        let cc = hex!("0c666f6f00000000000000000000000000000000000000000000000000000000"); // foo
        let public = hex!("46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a");
        let expected = hex!("40b9675df90efa6069ff623b0fdfcf706cd47ca7452a5056c7ad58194d23440a");
        let cc_string: String = cc.to_hex();
        let public_string: String = public.to_hex();
        let derived = sr25519_derive_public_soft(
            get_ptr(public_string.as_str()),
            get_ptr(cc_string.as_str()),
        );
        let derived_vec = get_u8vec_from_ptr(derived);
        assert_eq!(derived_vec[..], expected[..]);
    }

    #[test]
    fn can_sr25519_hard_derives_pair() {
        let cc = hex!("14416c6963650000000000000000000000000000000000000000000000000000"); // Alice
        let seed = hex!("fac7959dbfe72f052e5a0c3c8d6530f202b02fd8f9f5ca3580ec8deb7797479e");
        let expected = hex!("d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d");
        let cc_string: String = cc.to_hex();
        let seed_string: String = seed.to_hex();
        let keypair = sr25519_keypair_from_seed(get_ptr(seed_string.as_str()));
        let derived = sr25519_derive_keypair_hard(keypair, get_ptr(cc_string.as_str()));
        let derived_vec = get_u8vec_from_ptr(derived);
        let public = &derived_vec[schnorrkel::SECRET_KEY_LENGTH..schnorrkel::KEYPAIR_LENGTH];
        assert_eq!(public, expected);
    }
}
