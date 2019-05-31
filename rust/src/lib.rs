#[no_mangle]
pub extern fn hello_rust() -> *const u8 {
    "Hello, world from Rust!\0".as_ptr()
}
