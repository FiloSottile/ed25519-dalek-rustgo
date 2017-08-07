#![no_std]

#![feature(lang_items)]
#[lang = "eh_personality"] extern fn eh_personality() {}
#[lang = "panic_fmt"] fn panic_fmt() -> ! { loop {} }

extern crate curve25519_dalek;
use curve25519_dalek::scalar::Scalar;
use curve25519_dalek::constants;

#[no_mangle]
pub extern fn scalar_base_mult(dst: &mut [u8; 32], k: &[u8; 32]) {
    let res = &constants::ED25519_BASEPOINT_TABLE * &Scalar(*k);
    dst.clone_from(res.compress_edwards().as_bytes());
    // if let Some(ref r) = res.compress_montgomery() {
    //     dst.clone_from(&r.to_bytes());
    // }
}
