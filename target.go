//+build ignore

// Command target converts GOOS and GOARCH into a Rust target triple.
package main

import (
	"fmt"
	"os"
)

func main() {
	if len(os.Args) != 3 {
		fmt.Fprintf(os.Stderr, "Usage: target GOOS GOARCH")
		os.Exit(1)
	}
	GOOS, GOARCH := os.Args[1], os.Args[2]

	var arch, sys string

	switch GOARCH {
	case "amd64":
		arch = "x86_64"
	default:
		fmt.Fprintf(os.Stderr, "Unsupported GOARCH: %s", GOARCH)
		os.Exit(1)
	}

	switch GOOS {
	case "linux":
		if os.Getenv("MUSL") != "" {
			sys = "unknown-linux-musl"
		} else {
			sys = "unknown-linux-gnu"
		}
	case "darwin":
		sys = "apple-darwin"
	default:
		fmt.Fprintf(os.Stderr, "Unsupported GOOS: %s", GOOS)
		os.Exit(1)
	}

	fmt.Printf("%s-%s", arch, sys)
}
