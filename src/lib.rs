#![no_std]
#![feature(lang_items, compiler_builtins_lib, core_intrinsics)]
use core::intrinsics;
#[allow(private_no_mangle_fns)] #[no_mangle] // rust-lang/rust#38281
#[lang = "panic_fmt"] fn panic_fmt() -> ! { unsafe { intrinsics::abort() } }
#[lang = "eh_personality"] extern fn eh_personality() {}
extern crate compiler_builtins; // rust-lang/rust#43264
extern crate rlibc;

extern crate curve25519_dalek;
use curve25519_dalek::scalar::Scalar;
use curve25519_dalek::constants;

#[no_mangle]
pub extern fn scalar_base_mult(dst: &mut [u8; 32], k: &[u8; 32]) {
    let res = &constants::ED25519_BASEPOINT_TABLE * &Scalar(*k);
    dst.clone_from(res.compress_edwards().as_bytes());
}
