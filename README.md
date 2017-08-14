# ed25519-dalek-rustgo

[![Documentation](https://godoc.org/github.com/FiloSottile/ed25519-dalek-rustgo/edwards25519?status.svg)](http://godoc.org/github.com/FiloSottile/ed25519-dalek-rustgo/edwards25519)

> This repository is a demo for [rustgo](https://blog.filippo.io/rustgo), a technique to directly call Rust code from Go programs with near-zero overhead, meant to replace manually written assembly.
>
> You'd probably enjoy [the article](https://blog.filippo.io/rustgo) more.

edwards25519 implements operations on an Edwards curve that is isomorphic to curve25519 by wrapping the excellent pure-Rust [curve25519-dalek](https://github.com/isislovecruft/curve25519-dalek) library.

It exposes a Go interface, and can be imported, used and (cross-)compiled (but not installed) like a normal Go program. Benchmarks show this package to be more than 3 times faster than [a pure-Go alternative](https://godoc.org/github.com/agl/ed25519/edwards25519#GeScalarMultBase).

## Installation

To install using pre-built artifacts, download a tarball from [the Releases page](https://github.com/FiloSottile/ed25519-dalek-rustgo/releases) matching your Go version and untar it into `$GOPATH`. (The `_haswell` version is about 10% faster, but will only run on Haswell CPUs and newer.)

```
tar -C$GOPATH -xvf ed25519-dalek-rustgo_go1.8.3.tar.gz
```

That's it, you're ready to use the `github.com/FiloSottile/ed25519-dalek-rustgo/edwards25519` package.

### Manual installation

To build from source, you'll need Go, Rust, make and a linker.

Simply run `make install` from the root of this repository, which must be checked out at the right place in `$GOPATH`.

Cross-compilation is supported and based on `GOOS`/`GOARCH`. You'll need Rust setup and a linker for your target, specified with the `LD` variable. Set the `MUSL` environment variable to target `x86_64-unknown-linux-musl` for `linux_amd64`.

```
MUSL=1 GOOS=linux make clean install LD=x86_64-linux-musl-ld
```

The default `RUSTFLAGS` will target your native CPU.

## Usage

Just what you're used to. Import it, call its functions, `go build` your program.

Cross-compilation works normally, as long as a `.a` was installed for the target. Binary distributions currently include darwin_amd64 and linux_amd64 pre-built archives.

The only function currently exposed is multiplication of a scalar by the Curve25519 basepoint into an Edwards compressed point. PRs to add more APIs are welcome.
