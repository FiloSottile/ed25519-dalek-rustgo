//go:binary-only-package

package edwards25519

import _ "unsafe"

//go:cgo_import_static scalar_base_mult
//go:cgo_import_dynamic scalar_base_mult
//go:linkname scalar_base_mult scalar_base_mult
var scalar_base_mult uintptr
var _scalar_base_mult = &scalar_base_mult

func ScalarBaseMult(dst, in *[32]byte)
