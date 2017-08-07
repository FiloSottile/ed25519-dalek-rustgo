//+build ignore

package main

// #cgo LDFLAGS: -lresolv -led25519_dalek_rustgo -L${SRCDIR}/target/release
// void scalar_base_mult(void *, void *);
import "C"
import (
	"bytes"
	"encoding/hex"
	"fmt"
	"testing"
	"unsafe"
)

func main() {
	fmt.Println("Starting...")

	input, _ := hex.DecodeString("39129b3f7bbd7e17a39679b940018a737fc3bf430fcbc827029e67360aab3707")
	expected, _ := hex.DecodeString("1cc4789ed5ea69f84ad460941ba0491ff532c1af1fa126733d6c7b62f7ebcbcf")

	var dst, k [32]byte
	copy(k[:], input)

	C.scalar_base_mult(unsafe.Pointer(&dst), unsafe.Pointer(&k))
	if bytes.Equal(dst[:], expected) {
		fmt.Println("Result matches!")
	} else {
		fmt.Println("Wrong result!")
	}

	fmt.Printf("BenchmarkScalarBaseMult/cgo\t%v\n", testing.Benchmark(func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			C.scalar_base_mult(unsafe.Pointer(&dst), unsafe.Pointer(&k))
		}
	}))
}
