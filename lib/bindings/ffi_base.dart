import 'dart:ffi';
import 'package:ffi/ffi.dart';

import 'ffi_helpers.dart';

///
/// rust func:`fn rust_cstr_free(s: *mut c_char)`
///
typedef freeCStringFunc = void Function(Pointer<Utf8>);
typedef freeCStringFuncNative = Void Function(Pointer<Utf8>);
final freeCStringFuncName = "rust_cstr_free";
final freeCStringFunc freeCString =
    dylib.lookup<NativeFunction<freeCStringFuncNative>>(freeCStringFuncName).asFunction();

///
/// rust func: `fn bip39(words_number: u32) -> *mut c_char`
///
typedef rustBip39Func = Pointer<Utf8> Function(int wordsNumber);
typedef rustBip39Native = Pointer<Utf8> Function(Uint32);
final rustBip39Name = "bip39_generate";
final rustBip39Func rustBip39 =
    dylib.lookup<NativeFunction<rustBip39Native>>(rustBip39Name).asFunction();

///
/// rust func: `fn bip39_validate(phrase: &str) -> bool`
///
typedef rustBip39ValidateFunc = int Function(Pointer<Utf8> phrase);
typedef rustBip39ValidateNative = Int32 Function(Pointer<Utf8>);
final rustBip39ValidateName = "bip39_validate";
final rustBip39ValidateFunc rustBip39Validate =
    dylib.lookup<NativeFunction<rustBip39ValidateNative>>(rustBip39ValidateName).asFunction();

///
/// rust func: `fn bip39_to_entropy(phrase: *const c_char) -> *mut c_char`
///
typedef rustBip39ToEntropyFunc = Pointer<Utf8> Function(Pointer<Utf8> phrase);
typedef rustBip39ToEntropyNative = Pointer<Utf8> Function(Pointer<Utf8>);
final rustBip39ToEntropyName = "bip39_to_entropy";
final rustBip39ToEntropyFunc rustBip39ToEntropy =
    dylib.lookup<NativeFunction<rustBip39ToEntropyNative>>(rustBip39ToEntropyName).asFunction();

///
/// rust func: `fn bip39_to_mini_secret(phrase: *const c_char,password: *const c_char) -> *mut c_char`
///
typedef rustBip39ToMiniSecretFunc = Pointer<Utf8> Function(
    Pointer<Utf8> phrase, Pointer<Utf8> password);
typedef rustBip39ToMiniSecretNative = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>);
final rustBip39ToMiniSecretName = "bip39_to_mini_secret";
final rustBip39ToMiniSecretFunc rustBip39ToMiniSecret = dylib
    .lookup<NativeFunction<rustBip39ToMiniSecretNative>>(rustBip39ToMiniSecretName)
    .asFunction();

///
/// `fn bip39_to_seed(phrase: *const c_char, password: *const c_char) -> *mut c_char`
///
typedef rustBip39ToSeedFunc = Pointer<Utf8> Function(Pointer<Utf8> phrase, Pointer<Utf8> password);
typedef rustBip39ToSeedNative = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>);
final rustBip39ToSeedName = "bip39_to_seed";
final rustBip39ToSeedFunc rustBip39ToSeed =
    dylib.lookup<NativeFunction<rustBip39ToSeedNative>>(rustBip39ToSeedName).asFunction();

///
/// `fn blake2b(data: *const c_char, key: *const c_char, size: u32) -> *mut c_char`
///
typedef rustBlake2bFunc = Pointer<Utf8> Function(
    Pointer<Utf8> phrase, Pointer<Utf8> password, int size);
typedef rustBlake2bNative = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>, Uint32);
final rustBlake2bName = "blake2b";
final rustBlake2bFunc rustBlake2b =
    dylib.lookup<NativeFunction<rustBlake2bNative>>(rustBlake2bName).asFunction();

///
/// `fn keccak256(data: *const c_char) -> *mut c_char`
///
typedef rustKeccak256Func = Pointer<Utf8> Function(Pointer<Utf8> phrase);
typedef rustKeccak256Native = Pointer<Utf8> Function(Pointer<Utf8>);
final rustKeccak256Name = "keccak256";
final rustKeccak256Func rustKeccak256 =
    dylib.lookup<NativeFunction<rustKeccak256Native>>(rustKeccak256Name).asFunction();

///
/// `fn pbkdf2(data: *const c_char, salt: *const c_char, rounds: u32) -> *mut c_char`
///
typedef rustPbkdf2Func = Pointer<Utf8> Function(Pointer<Utf8> data, Pointer<Utf8> salt, int rounds);
typedef rustPbkdf2Native = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>, Uint32);
final rustPbkdf2Name = "pbkdf2";
final rustPbkdf2Func rustPbkdf2 =
    dylib.lookup<NativeFunction<rustPbkdf2Native>>(rustPbkdf2Name).asFunction();

///
/// `fn scrypt(password: *const c_char, salt: *const c_char, log2_n: u8, r: u32, p: u32,) -> *mut c_char`
///
typedef rustScryptFunc = Pointer<Utf8> Function(
    Pointer<Utf8> password, Pointer<Utf8> salt, int log2N, int r, int p);
typedef rustScryptNative = Pointer<Utf8> Function(
    Pointer<Utf8>, Pointer<Utf8>, Uint8, Uint32, Uint32);
final rustScryptName = "scrypt";
final rustScryptFunc rustScrypt =
    dylib.lookup<NativeFunction<rustScryptNative>>(rustScryptName).asFunction();

///
/// `fn sha512(data: *const c_char) -> *mut c_char`
///
typedef rustSha512Func = Pointer<Utf8> Function(Pointer<Utf8> data);
typedef rustSha512Native = Pointer<Utf8> Function(Pointer<Utf8>);
final rustSha512Name = "sha512";
final rustSha512Func rustSha512 =
    dylib.lookup<NativeFunction<rustSha512Native>>(rustSha512Name).asFunction();

///
/// `fn twox(data: *const c_char, rounds: u32) -> *mut c_char`
///
typedef rustTwoxFunc = Pointer<Utf8> Function(Pointer<Utf8> data, int rounds);
typedef rustTwoxNative = Pointer<Utf8> Function(Pointer<Utf8>, Uint32);
final rustTwoxName = "twox";
final rustTwoxFunc rustTwox =
    dylib.lookup<NativeFunction<rustTwoxNative>>(rustTwoxName).asFunction();

///
/// `fn xxhash(data: *const c_char, seed: u32) -> *mut c_char`
///
typedef rustXxhash64Func = Pointer<Utf8> Function(Pointer<Utf8> data, int seed);
typedef rustXxhash64Native = Pointer<Utf8> Function(Pointer<Utf8>, Uint32);
final rustXxhash64Name = "xxhash64";
final rustXxhash64Func rustXxhash64 =
    dylib.lookup<NativeFunction<rustXxhash64Native>>(rustXxhash64Name).asFunction();

///
/// `fn bip32_get_private_key(seed: *const c_char, path: *const c_char) -> *mut c_char`
///
typedef rustBip32GetPrivateKeyFunc = Pointer<Utf8> Function(Pointer<Utf8> seed, Pointer<Utf8> path);
typedef rustBip32GetPrivateKeyNative = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>);
final rustBip32GetPrivateKeyName = "bip32_get_private_key";
final rustBip32GetPrivateKeyFunc rustBip32GetPrivateKey = dylib
    .lookup<NativeFunction<rustBip32GetPrivateKeyNative>>(rustBip32GetPrivateKeyName)
    .asFunction();

///
/// `fn ed25519_get_pub_from_prv(private_key: *const c_char) -> *mut c_char`
///
typedef rustEd25519GetPubFromPrivateFunc = Pointer<Utf8> Function(Pointer<Utf8> privateKey);
typedef rustEd25519GetPubFromPrivateNative = Pointer<Utf8> Function(Pointer<Utf8>);
final rustEd25519GetPubFromPrivateName = "ed25519_get_pub_from_prv";
final rustEd25519GetPubFromPrivateFunc rustEd25519GetPubFromPrivate = dylib
    .lookup<NativeFunction<rustEd25519GetPubFromPrivateNative>>(rustEd25519GetPubFromPrivateName)
    .asFunction();

///
/// `fn secp256k1_get_pub_from_prv(private_key: *const c_char) -> *mut c_char`
///
typedef rustSecp256k1GetPubFromPrivateFunc = Pointer<Utf8> Function(Pointer<Utf8> privateKey);
typedef rustSecp256k1GetPubFromPrivateNative = Pointer<Utf8> Function(Pointer<Utf8>);
final rustSecp256k1GetPubFromPrivateName = "secp256k1_get_pub_from_prv";
final rustSecp256k1GetPubFromPrivateFunc rustSecp256k1GetPubFromPrivate = dylib
    .lookup<NativeFunction<rustSecp256k1GetPubFromPrivateNative>>(
        rustSecp256k1GetPubFromPrivateName)
    .asFunction();

///
/// pub extern "C" fn secp256k1_get_compress_pub(uncompressed: *const c_char) -> *mut c_char
///
typedef rustSecp256k1GetCompressPubFunc = Pointer<Utf8> Function(Pointer<Utf8> privateKey);
typedef rustSecp256k1GetCompressPubNative = Pointer<Utf8> Function(Pointer<Utf8>);
final rustSecp256k1GetCompressPubName = "secp256k1_get_compress_pub";
final rustSecp256k1GetCompressPubFunc rustSecp256k1GetCompressPub = dylib
    .lookup<NativeFunction<rustSecp256k1GetCompressPubNative>>(rustSecp256k1GetCompressPubName)
    .asFunction();

///
/// `fn sr25519_get_pub_from_seed(seed: *const c_char) -> *mut c_char`
///
typedef rustSr25519GetPubFromSeedFunc = Pointer<Utf8> Function(Pointer<Utf8> seed);
typedef rustSr25519GetPubFromSeedNative = Pointer<Utf8> Function(Pointer<Utf8>);
final rustSr25519GetPubFromSeedName = "sr25519_get_pub_from_seed";
final rustSr25519GetPubFromSeedFunc rustSr25519GetPubFromSeed = dylib
    .lookup<NativeFunction<rustSr25519GetPubFromSeedNative>>(rustSr25519GetPubFromSeedName)
    .asFunction();

///
/// `fn ed25519_keypair_from_seed(seed: *const c_char) -> *mut c_char`
///
typedef rustEd25519KeypairFromSeedFunc = Pointer<Utf8> Function(Pointer<Utf8> seed);
typedef rustEd25519KeypairFromSeedNative = Pointer<Utf8> Function(Pointer<Utf8>);
final rustEd25519KeypairFromSeedName = "ed25519_keypair_from_seed";
final rustEd25519KeypairFromSeedFunc rustEd25519KeypairFromSeed = dylib
    .lookup<NativeFunction<rustEd25519KeypairFromSeedNative>>(rustEd25519KeypairFromSeedName)
    .asFunction();

///
/// `fn ed25519_sign(pubkey: *const c_char,seckey: *const c_char,message: *const c_char) -> *mut c_char`
///
typedef rustEd25519SignFunc = Pointer<Utf8> Function(
    Pointer<Utf8> pubkey, Pointer<Utf8> seckey, Pointer<Utf8> message);
typedef rustEd25519SignNative = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);
final rustEd25519SignName = "ed25519_sign";
final rustEd25519SignFunc rustEd25519Sign =
    dylib.lookup<NativeFunction<rustEd25519SignNative>>(rustEd25519SignName).asFunction();

///
/// `fn ed25519_verify(signature: *const c_char,message: *const c_char,pubkey: *const c_char) -> bool`
///
typedef rustEd25519VerifyFunc = int Function(
    Pointer<Utf8> signature, Pointer<Utf8> message, Pointer<Utf8> pubkey);
typedef rustEd25519VerifyNative = Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);
final rustEd25519VerifyName = "ed25519_verify";
final rustEd25519VerifyFunc rustEd25519Verify =
    dylib.lookup<NativeFunction<rustEd25519VerifyNative>>(rustEd25519VerifyName).asFunction();

///
/// `fn sr25519_derive_keypair_hard(pair: *const c_char,cc: *const c_char) -> *mut c_char`
///
typedef rustSr25519DeriveKeypairHardFunc = Pointer<Utf8> Function(
    Pointer<Utf8> pair, Pointer<Utf8> cc);
typedef rustSr25519DeriveKeypairHardNative = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>);
final rustSr25519DeriveKeypairHardName = "sr25519_derive_keypair_hard";
final rustSr25519DeriveKeypairHardFunc rustSr25519DeriveKeypairHard = dylib
    .lookup<NativeFunction<rustSr25519DeriveKeypairHardNative>>(rustSr25519DeriveKeypairHardName)
    .asFunction();

///
/// `fn sr25519_derive_keypair_soft(pair: *const c_char,cc: *const c_char) -> *mut c_char`
///
typedef rustSr25519DeriveKeypairSoftFunc = Pointer<Utf8> Function(
    Pointer<Utf8> pair, Pointer<Utf8> cc);
typedef rustSr25519DeriveKeypairSoftNative = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>);
final rustSr25519DeriveKeypairSoftName = "sr25519_derive_keypair_soft";
final rustSr25519DeriveKeypairSoftFunc rustSr25519DeriveKeypairSoft = dylib
    .lookup<NativeFunction<rustSr25519DeriveKeypairSoftNative>>(rustSr25519DeriveKeypairSoftName)
    .asFunction();

///
/// `fn sr25519_derive_public_soft(public: *const c_char,cc: *const c_char) -> *mut c_char`
///
typedef rustSr25519DerivePublicSoftFunc = Pointer<Utf8> Function(
    Pointer<Utf8> public, Pointer<Utf8> cc);
typedef rustSr25519DerivePublicSoftNative = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>);
final rustSr25519DerivePublicSoftName = "sr25519_derive_public_soft";
final rustSr25519DerivePublicSoftFunc rustSr25519DerivePublicSoft = dylib
    .lookup<NativeFunction<rustSr25519DerivePublicSoftNative>>(rustSr25519DerivePublicSoftName)
    .asFunction();

///
/// `fn sr25519_keypair_from_seed(seed: *const c_char) -> *mut c_char`
///
typedef rustSr25519KeypairFromSeedFunc = Pointer<Utf8> Function(Pointer<Utf8> seed);
typedef rustSr25519KeypairFromSeedNative = Pointer<Utf8> Function(Pointer<Utf8>);
final rustSr25519KeypairFromSeedName = "sr25519_keypair_from_seed";
final rustSr25519KeypairFromSeedFunc rustSr25519KeypairFromSeed = dylib
    .lookup<NativeFunction<rustSr25519KeypairFromSeedNative>>(rustSr25519KeypairFromSeedName)
    .asFunction();

///
/// `fn sr25519_keypair_from_pair(pair: *const c_char) -> *mut c_char`
///
typedef rustSr25519KeypairFromPairFunc = Pointer<Utf8> Function(Pointer<Utf8> pair);
typedef rustSr25519KeypairFromPairNative = Pointer<Utf8> Function(Pointer<Utf8>);
final rustSr25519KeypairFromPairName = "sr25519_keypair_from_pair";
final rustSr25519KeypairFromPairFunc rustSr25519KeypairFromPair = dylib
    .lookup<NativeFunction<rustSr25519KeypairFromPairNative>>(rustSr25519KeypairFromPairName)
    .asFunction();

///
/// `fn sr25519_sign(pubkey: *const c_char,seckey: *const c_char,message: *const c_char) -> *mut c_char`
///
typedef rustSr25519SignFunc = Pointer<Utf8> Function(
    Pointer<Utf8> pubkey, Pointer<Utf8> seckey, Pointer<Utf8> message);
typedef rustSr25519SignNative = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);
final rustSr25519SignName = "sr25519_sign";
final rustSr25519SignFunc rustSr25519Sign =
    dylib.lookup<NativeFunction<rustSr25519SignNative>>(rustSr25519SignName).asFunction();

///
/// `fn sr25519_verify(signature: *const c_char,message: *const c_char,pubkey: *const c_char) -> bool`
///
typedef rustSr25519VerifyFunc = int Function(
    Pointer<Utf8> signature, Pointer<Utf8> message, Pointer<Utf8> pubkey);
typedef rustSr25519VerifyNative = Int32 Function(Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>);
final rustSr25519VerifyName = "sr25519_verify";
final rustSr25519VerifyFunc rustSr25519Verify =
    dylib.lookup<NativeFunction<rustSr25519VerifyNative>>(rustSr25519VerifyName).asFunction();
