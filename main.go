package main

import (
	"encoding/hex"
	"fmt"
	"testing"

	"github.com/agl/ed25519/edwards25519"
)

func main() {
	input, _ := hex.DecodeString("39129b3f7bbd7e17a39679b940018a737fc3bf430fcbc827029e67360aab3707")

	var dst, k [32]byte
	copy(k[:], input)

	fmt.Printf("BenchmarkScalarBaseMult\t%v\n", testing.Benchmark(func(b *testing.B) {
		h := &edwards25519.ExtendedGroupElement{}
		for i := 0; i < b.N; i++ {
			edwards25519.GeScalarMultBase(h, &k)
			h.ToBytes(&dst)
		}
	}))
}
