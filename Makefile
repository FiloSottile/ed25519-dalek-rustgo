IMPORT_PATH ?= github.com/FiloSottile/ed25519-dalek-rustgo

edwards25519/edwards25519.a: edwards25519/rustgo.go edwards25519/rustgo.o target/release/libed25519_dalek_rustgo.a
		go tool compile -N -l -o $@ -p main -pack edwards25519/rustgo.go
		go tool pack r $@ edwards25519/rustgo.o
		mkdir -p target/release/libed25519_dalek_rustgo && cd target/release/libed25519_dalek_rustgo && \
			rm -f *.o && ar xv "$(CURDIR)/target/release/libed25519_dalek_rustgo.a"
		go tool pack r $@ target/release/libed25519_dalek_rustgo/*.o

target/release/libed25519_dalek_rustgo.a: src/* Cargo.toml Cargo.lock .cargo/config
		cargo build --release

edwards25519/rustgo.o: edwards25519/rustgo.s
		go tool asm -I "$(shell go env GOROOT)/pkg/include" -o $@ $^

.PHONY: install
install: edwards25519/edwards25519.a
		mkdir -p "$(shell go env GOPATH)/pkg/darwin_amd64/$(IMPORT_PATH)/"
		cp edwards25519/edwards25519.a "$(shell go env GOPATH)/pkg/darwin_amd64/$(IMPORT_PATH)/"

.PHONY: clean
clean:
		rm -rf edwards25519/*.[oa] target
