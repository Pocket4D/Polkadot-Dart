use rustc_hex::{FromHex, FromHexError, ToHex};
use std::ffi::{CStr, CString};
use std::os::raw::c_char;
use std::str;

pub fn get_str(rust_ptr: *const c_char) -> String {
    let c_str = unsafe { CStr::from_ptr(rust_ptr) };
    let result_string = match c_str.to_str() {
        Err(_) => "Error: input string error",
        Ok(string) => string,
    };
    return String::from(result_string);
}

pub fn get_ptr(rust_string: &str) -> *mut c_char {
    CString::new(rust_string).unwrap().into_raw()
}

pub fn get_u8vec_from_ptr(rust_ptr: *const c_char) -> Vec<u8> {
    let message_result: Result<Vec<u8>, FromHexError> = get_str(rust_ptr).from_hex();
    return match message_result {
        Ok(c) => c,
        _ => panic!("Error: get_u8vec_from_ptr failed"),
    };
}

pub fn get_ptr_from_u8vec(u8vec: Vec<u8>) -> *mut c_char {
    let result: String = u8vec.to_hex();
    get_ptr(result.as_str())
}
