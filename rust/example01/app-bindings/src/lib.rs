use std::{
    panic::{self, UnwindSafe},
    process,
};

/// This is called by the true `main` function of our application.
#[no_mangle]
pub extern "C" fn main_rs() -> std::os::raw::c_int {
    // See `safe_unwind` below.
    stop_unwind(app_lib01::main_rs)
}

/// Panicking out of rust into another language is Undefined Behavior!
///
/// Catching a panic at the FFI boundary is one of the few generally agreed
/// upon use cases for `catch_unwind`.
/// https://doc.rust-lang.org/nomicon/unwinding.html
fn stop_unwind<F: FnOnce() -> T + UnwindSafe, T>(f: F) -> T {
    match panic::catch_unwind(f) {
        Ok(t) => t,
        Err(_) => {
            eprintln!("Attempt to Unwind out of rust code");

            // We should handle the error somehow, and, without knowing what the
            // error is, aborting is an OK choice.
            process::abort()
        }
    }
}
