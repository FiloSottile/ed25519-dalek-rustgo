edwards25519/edwards25519: edwards25519/rustgo.a target/release/libed25519_dalek_rustgo.a
		go tool link -o $@ -buildmode exe -buildid b01dca11ab1e -linkmode external \
			-v -extldflags="-ldl -led25519_dalek_rustgo -L$(CURDIR)/target/release" edwards25519/rustgo.a

target/release/libed25519_dalek_rustgo.a: src/* Cargo.toml Cargo.lock .cargo/config
		cargo build --release

edwards25519/rustgo.o: edwards25519/rustgo.s
		go tool asm -I "$(shell go env GOROOT)/pkg/include" -o $@ $^

edwards25519/rustgo.a: edwards25519/rustgo.go edwards25519/rustgo.o
		go tool compile -N -l -o $@ -p main -pack edwards25519/rustgo.go
		go tool pack r $@ edwards25519/rustgo.o

.PHONY: clean
clean:
		rm -rf edwards25519/edwards25519 target edwards25519/rustgo.o edwards25519/rustgo.a	
