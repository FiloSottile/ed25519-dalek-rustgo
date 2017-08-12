#!/bin/bash
set -exuo pipefail

GOOS=darwin make clean install
MUSL=1 GOOS=linux make clean install LD=x86_64-linux-musl-ld

make clean
GO_VERSION=$(go version | cut -d' ' -f 3)
tar -C "$GOPATH" -cvzf ed25519-dalek-rustgo_$GO_VERSION.tar.gz \
    --exclude \*.tar.gz --exclude .git src/github.com/FiloSottile/ed25519-dalek-rustgo \
    pkg/linux_amd64/github.com/FiloSottile/ed25519-dalek-rustgo/edwards25519.a \
    pkg/darwin_amd64/github.com/FiloSottile/ed25519-dalek-rustgo/edwards25519.a
