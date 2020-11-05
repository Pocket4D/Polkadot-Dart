use rustc_hex::ToHex;
use std::ffi::CString;
use std::os::raw::c_char;

use super::bip39;
use super::hashing;
use super::util::{get_ptr, get_str};

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
    let result = bip39::ext_bip39_to_entropy(&get_str(validated_phrase));
    let rust_string: String = result.to_hex();
    get_ptr(&rust_string.as_str())
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
    let result = bip39::ext_bip39_to_mini_secret(&get_str(validated_phrase), &get_str(password));
    let rust_string: String = result.to_hex();
    get_ptr(&rust_string.as_str())
}

#[no_mangle]
pub extern "C" fn bip39_to_seed(phrase: *const c_char, password: *const c_char) -> *mut c_char {
    let validated_phrase = match bip39_validate(phrase) {
        true => phrase,
        false => return get_ptr("Error: Phrases are in-valid"),
    };
    let result = bip39::ext_bip39_to_seed(&get_str(validated_phrase), &get_str(password));
    let rust_string: String = result.to_hex();
    get_ptr(rust_string.as_str())
}

// Binding hashing to dart
#[no_mangle]
pub extern "C" fn blake2b(data: *const c_char, key: *const c_char, size: u32) -> *mut c_char {
    let result_vec = hashing::ext_blake2b(get_str(data).as_bytes(), get_str(key).as_bytes(), size);
    let result_hex: String = result_vec.to_hex();
    get_ptr(result_hex.as_str())
}

#[no_mangle]
pub extern "C" fn keccak256(data: *const c_char) -> *mut c_char {
    let result_vec = hashing::ext_keccak256(get_str(data).as_bytes());
    let result_hex: String = result_vec.to_hex();
    get_ptr(result_hex.as_str())
}

#[no_mangle]
pub extern "C" fn pbkdf2(data: *const c_char, salt: *const c_char, rounds: u32) -> *mut c_char {
    let result_vec =
        hashing::ext_pbkdf2(get_str(data).as_bytes(), get_str(salt).as_bytes(), rounds);
    let result_hex: String = result_vec.to_hex();
    get_ptr(result_hex.as_str())
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
    let result_hex: String = result_vec.to_hex();
    get_ptr(result_hex.as_str())
}

#[no_mangle]
pub extern "C" fn sha512(data: *const c_char) -> *mut c_char {
    let result_vec = hashing::ext_sha512(get_str(data).as_bytes());
    let result_hex: String = result_vec.to_hex();
    get_ptr(result_hex.as_str())
}

#[no_mangle]
pub extern "C" fn twox(data: *const c_char, rounds: u32) -> *mut c_char {
    let result_vec = hashing::ext_twox(get_str(data).as_bytes(), rounds);
    let result_hex: String = result_vec.to_hex();
    get_ptr(result_hex.as_str())
}

#[cfg(test)]
pub mod tests {
    use super::*;
    use hex_literal::hex;
    use rustc_hex::{FromHex, FromHexError};

    #[test]
    fn can_bip39_to_entropy() {
        let phrase = "legal winner thank year wave sausage worth useful legal winner thank yellow";
        let entropy = hex!("7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f");
        let result = bip39_to_entropy(get_ptr(&phrase));
        let message_result: Result<Vec<u8>, FromHexError> = get_str(result).from_hex();
        let message = match message_result {
            Ok(c) => c,
            _ => panic!("wrong"),
        };
        assert_eq!(message, entropy);
    }

    #[test]
    fn can_bip39_to_mini_secret() {
        let phrase = "legal winner thank year wave sausage worth useful legal winner thank yellow";
        let password = "Substrate";
        let mini = hex!("4313249608fe8ac10fd5886c92c4579007272cb77c21551ee5b8d60b78041685");
        let result = bip39_to_mini_secret(get_ptr(phrase), get_ptr(password));
        let message_result: Result<Vec<u8>, FromHexError> = get_str(result).from_hex();
        let message = match message_result {
            Ok(c) => c,
            _ => panic!("wrong"),
        };
        assert_eq!(message[..], mini[..]);
    }

    #[test]
    fn can_bip39_to_seed() {
        let phrase = "seed sock milk update focus rotate barely fade car face mechanic mercy";
        let seed = hex!("3c121e20de068083b49c2315697fb59a2d9e8643c24e5ea7628132c58969a027");
        let result = bip39_to_seed(get_ptr(phrase), get_ptr(""));
        let message_result: Result<Vec<u8>, FromHexError> = get_str(result).from_hex();
        let message = match message_result {
            Ok(c) => c,
            _ => panic!("wrong"),
        };
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
        let data = "abc";
        let key = "";
        let expected_32 = hex!("bddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319");
        let expected_64 = hex!("ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923");
        let hash_32 = blake2b(get_ptr(data), get_ptr(key), 32);
        let hash_64 = blake2b(get_ptr(data), get_ptr(key), 64);
        let message_result_32: Result<Vec<u8>, FromHexError> = get_str(hash_32).from_hex();
        let message_32 = match message_result_32 {
            Ok(c) => c,
            _ => panic!("wrong"),
        };
        let message_result_64: Result<Vec<u8>, FromHexError> = get_str(hash_64).from_hex();
        let message_64 = match message_result_64 {
            Ok(c) => c,
            _ => panic!("wrong"),
        };
        assert_eq!(message_32[..], expected_32[..]);
        assert_eq!(message_64[..], expected_64[..]);
    }

    #[test]
    fn can_keccak256() {
        let data = "test value";
        let expected = hex!("2d07364b5c231c56ce63d49430e085ea3033c750688ba532b24029124c26ca5e");
        let hash = keccak256(get_ptr(data));
        let message_result: Result<Vec<u8>, FromHexError> = get_str(hash).from_hex();
        let message = match message_result {
            Ok(c) => c,
            _ => panic!("wrong"),
        };
        assert_eq!(message[..], expected[..]);
    }

    #[test]
    fn can_pbkdf2() {
        let salt = "this is a salt";
        let data = "hello world";
        let expected = hex!("5fcbe04f05300a3ecc5c35d18ea0b78f3f6853d2ae5f3fca374f69a7d1f78b5def5c60dae1a568026c7492511e0c53521e8bb6e03a650e1263265fee92722270");
        let hash = pbkdf2(get_ptr(data), get_ptr(salt), 2048);

        let message_result: Result<Vec<u8>, FromHexError> = get_str(hash).from_hex();
        let message = match message_result {
            Ok(c) => c,
            _ => panic!("wrong"),
        };
        assert_eq!(message[..], expected[..]);
    }

    #[test]
    fn can_scrypt() {
        let password = "password";
        let salt = "salt";
        let expected = hex!("745731af4484f323968969eda289aeee005b5903ac561e64a5aca121797bf7734ef9fd58422e2e22183bcacba9ec87ba0c83b7a2e788f03ce0da06463433cda6");
        let hash = scrypt(get_ptr(password), get_ptr(salt), 14, 8, 1);
        let message_result: Result<Vec<u8>, FromHexError> = get_str(hash).from_hex();
        let message = match message_result {
            Ok(c) => c,
            _ => panic!("wrong"),
        };
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
        let message_result: Result<Vec<u8>, FromHexError> = get_str(hash).from_hex();
        let message = match message_result {
            Ok(c) => c,
            _ => panic!("wrong"),
        };
        assert_eq!(message[..], expected[..]);
    }

    #[test]
    fn can_twox() {
        let data = "abc";
        let expected_64 = hex!("990977adf52cbc44");
        let expected_256 = hex!("990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b");
        let hash_64 = twox(get_ptr(data), 1);
        let hash_256 = twox(get_ptr(data), 4);

        let message_result_64: Result<Vec<u8>, FromHexError> = get_str(hash_64).from_hex();
        let message_64 = match message_result_64 {
            Ok(c) => c,
            _ => panic!("wrong"),
        };

        let message_result_256: Result<Vec<u8>, FromHexError> = get_str(hash_256).from_hex();
        let message_256 = match message_result_256 {
            Ok(c) => c,
            _ => panic!("wrong"),
        };

        assert_eq!(message_64[..], expected_64[..]);
        assert_eq!(message_256[..], expected_256[..]);
    }
}
