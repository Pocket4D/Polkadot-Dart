use std::ffi::{CStr, CString};
use std::os::raw::c_char;
use std::str;
pub fn get_str(rust_ptr: *const c_char) -> String {
    let c_str = unsafe { CStr::from_ptr(rust_ptr) };
    let result_string = match c_str.to_str() {
        Err(_) => "input string error",
        Ok(string) => string,
    };
    return String::from(result_string);
}

pub fn get_ptr(rust_string: &str) -> *mut c_char {
    CString::new(rust_string).unwrap().into_raw()
}
