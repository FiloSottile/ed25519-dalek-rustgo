// Package edwards25519 implements operations on an Edwards curve that is
// isomorphic to curve25519.
//
// Crypto operations are implemented by calling directly into the Rust
// library curve25519-dalek, without cgo.
//
// You should not actually be using this.
package edwards25519

// ScalarBaseMult multiplies the scalar in by the curve basepoint, and writes
// the compressed Edwards representation of the resulting point to dst.
func ScalarBaseMult(dst, in *[32]byte)
