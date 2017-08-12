package main

import (
	"bytes"
	"encoding/hex"
	"fmt"
	"testing"

	"github.com/FiloSottile/ed25519-dalek-rustgo/edwards25519"
)

func main() {
	input, _ := hex.DecodeString("39129b3f7bbd7e17a39679b940018a737fc3bf430fcbc827029e67360aab3707")
	expected, _ := hex.DecodeString("1cc4789ed5ea69f84ad460941ba0491ff532c1af1fa126733d6c7b62f7ebcbcf")

	var dst, k [32]byte
	copy(k[:], input)

	edwards25519.ScalarBaseMult(&dst, &k)
	if !bytes.Equal(dst[:], expected) {
		fmt.Println("rustgo produces a wrong result!")
	}

	fmt.Printf("BenchmarkScalarBaseMult\t%v\n", testing.Benchmark(func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			edwards25519.ScalarBaseMult(&dst, &k)
		}
	}))
}
