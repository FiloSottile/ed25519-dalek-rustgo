//go:binary-only-package

// Package edwards25519 implements operations on an Edwards curve that is
// isomorphic to curve25519.
//
// Crypto operations are implemented by calling directly into the Rust
// library curve25519-dalek, without cgo.
//
// You should not actually be using this.
package edwards25519

import _ "unsafe"

//go:cgo_import_static scalar_base_mult
//go:cgo_import_dynamic scalar_base_mult
//go:linkname scalar_base_mult scalar_base_mult
var scalar_base_mult uintptr
var _scalar_base_mult = &scalar_base_mult

// ScalarBaseMult multiplies the scalar in by the curve basepoint, and writes
// the compressed Edwards representation of the resulting point to dst.
func ScalarBaseMult(dst, in *[32]byte)
