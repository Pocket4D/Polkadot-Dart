import 'dart:ffi';
import 'package:ffi/ffi.dart';

import 'ffi_helpers.dart';

///
/// rust func:`pub extern "C" fn rust_cstr_free(s: *mut c_char)`
///
typedef freeCStringFunc = void Function(Pointer<Utf8>);
typedef freeCStringFuncNative = Void Function(Pointer<Utf8>);
final freeCStringFuncName = "rust_cstr_free";
final freeCStringFunc freeCString =
    dylib.lookup<NativeFunction<freeCStringFuncNative>>(freeCStringFuncName).asFunction();

///
/// rust func: `pub extern "C" fn bip39(words_number: u32) -> *mut c_char`
///
typedef rustBip39Func = Pointer<Utf8> Function(int wordsNumber);
typedef rustBip39Native = Pointer<Utf8> Function(Uint32);
final rustBip39Name = "bip39_generate";
final rustBip39Func rustBip39 =
    dylib.lookup<NativeFunction<rustBip39Native>>(rustBip39Name).asFunction();

///
/// rust func: `pub extern "C" fn bip39_validate(phrase: &str) -> bool`
///
typedef rustBip39ValidateFunc = int Function(Pointer<Utf8> phrase);
typedef rustBip39ValidateNative = Int32 Function(Pointer<Utf8>);
final rustBip39ValidateName = "bip39_validate";
final rustBip39ValidateFunc rustBip39Validate =
    dylib.lookup<NativeFunction<rustBip39ValidateNative>>(rustBip39ValidateName).asFunction();

///
/// rust func: `pub extern "C" fn bip39_to_entropy(phrase: *const c_char) -> *mut c_char`
///
typedef rustBip39ToEntropyFunc = Pointer<Utf8> Function(Pointer<Utf8> phrase);
typedef rustBip39ToEntropyNative = Pointer<Utf8> Function(Pointer<Utf8>);
final rustBip39ToEntropyName = "bip39_to_entropy";
final rustBip39ToEntropyFunc rustBip39ToEntropy =
    dylib.lookup<NativeFunction<rustBip39ToEntropyNative>>(rustBip39ToEntropyName).asFunction();

///
/// rust func: `pub extern "C" fn bip39_to_mini_secret(phrase: *const c_char,password: *const c_char) -> *mut c_char`
///
typedef rustBip39ToMiniSecretFunc = Pointer<Utf8> Function(
    Pointer<Utf8> phrase, Pointer<Utf8> password);
typedef rustBip39ToMiniSecretNative = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>);
final rustBip39ToMiniSecretName = "bip39_to_mini_secret";
final rustBip39ToMiniSecretFunc rustBip39ToMiniSecret = dylib
    .lookup<NativeFunction<rustBip39ToMiniSecretNative>>(rustBip39ToMiniSecretName)
    .asFunction();

///
/// rust func `pub extern "C" fn bip39_to_seed(phrase: *const c_char, password: *const c_char) -> *mut c_char`
///
typedef rustBip39ToSeedFunc = Pointer<Utf8> Function(Pointer<Utf8> phrase, Pointer<Utf8> password);
typedef rustBip39ToSeedNative = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>);
final rustBip39ToSeedName = "bip39_to_seed";
final rustBip39ToSeedFunc rustBip39ToSeed =
    dylib.lookup<NativeFunction<rustBip39ToSeedNative>>(rustBip39ToSeedName).asFunction();

///
/// rust func `pub extern "C" fn blake2b(data: *const c_char, key: *const c_char, size: u32) -> *mut c_char`
///
typedef rustBlake2bFunc = Pointer<Utf8> Function(
    Pointer<Utf8> phrase, Pointer<Utf8> password, int size);
typedef rustBlake2bNative = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>, Uint32);
final rustBlake2bName = "blake2b";
final rustBlake2bFunc rustBlake2b =
    dylib.lookup<NativeFunction<rustBlake2bNative>>(rustBlake2bName).asFunction();

///
/// rust func `pub extern "C" fn keccak256(data: *const c_char) -> *mut c_char`
///
typedef rustKeccak256Func = Pointer<Utf8> Function(Pointer<Utf8> phrase);
typedef rustKeccak256Native = Pointer<Utf8> Function(Pointer<Utf8>);
final rustKeccak256Name = "keccak256";
final rustKeccak256Func rustKeccak256 =
    dylib.lookup<NativeFunction<rustKeccak256Native>>(rustKeccak256Name).asFunction();

///
/// rust func `pub extern "C" fn pbkdf2(data: *const c_char, salt: *const c_char, rounds: u32) -> *mut c_char`
///
typedef rustPbkdf2Func = Pointer<Utf8> Function(Pointer<Utf8> data, Pointer<Utf8> salt, int rounds);
typedef rustPbkdf2Native = Pointer<Utf8> Function(Pointer<Utf8>, Pointer<Utf8>, Uint32);
final rustPbkdf2Name = "pbkdf2";
final rustPbkdf2Func rustPbkdf2 =
    dylib.lookup<NativeFunction<rustPbkdf2Native>>(rustPbkdf2Name).asFunction();

///
/// rust func `pub extern "C" fn scrypt(password: *const c_char, salt: *const c_char, log2_n: u8, r: u32, p: u32,) -> *mut c_char`
///
typedef rustScryptFunc = Pointer<Utf8> Function(
    Pointer<Utf8> password, Pointer<Utf8> salt, int log2N, int r, int p);
typedef rustScryptNative = Pointer<Utf8> Function(
    Pointer<Utf8>, Pointer<Utf8>, Uint8, Uint32, Uint32);
final rustScryptName = "scrypt";
final rustScryptFunc rustScrypt =
    dylib.lookup<NativeFunction<rustScryptNative>>(rustScryptName).asFunction();

///
/// rust func `pub extern "C" fn sha512(data: *const c_char) -> *mut c_char`
///
typedef rustSha512Func = Pointer<Utf8> Function(Pointer<Utf8> data);
typedef rustSha512Native = Pointer<Utf8> Function(Pointer<Utf8>);
final rustSha512Name = "sha512";
final rustSha512Func rustSha512 =
    dylib.lookup<NativeFunction<rustSha512Native>>(rustSha512Name).asFunction();

///
/// rust func `pub extern "C" fn twox(data: *const c_char, rounds: u32) -> *mut c_char`
///
typedef rustTwoxFunc = Pointer<Utf8> Function(Pointer<Utf8> data, int rounds);
typedef rustTwoxNative = Pointer<Utf8> Function(Pointer<Utf8>, Uint32);
final rustTwoxName = "twox";
final rustTwoxFunc rustTwox =
    dylib.lookup<NativeFunction<rustTwoxNative>>(rustTwoxName).asFunction();
