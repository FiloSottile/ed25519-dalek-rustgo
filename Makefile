IMPORT_PATH      := github.com/FiloSottile/ed25519-dalek-rustgo
INSTALL_PATH     := $(shell go env GOPATH)/pkg/$(shell go env GOOS)_$(shell go env GOARCH)/$(IMPORT_PATH)
SYMBOL           := scalar_base_mult
LD               ?= ld
export RUSTFLAGS ?= -Ctarget-cpu=native
TARGET           := $(shell GOOS=$(shell go env GOHOSTOS) GOARCH=$(shell go env GOHOSTARCH) \
                            go run target.go $(shell go env GOOS) $(shell go env GOARCH))

edwards25519/edwards25519.a: edwards25519/rustgo.go edwards25519/rustgo.o edwards25519/libed25519_dalek_rustgo.o
		go tool compile -N -l -o $@ -p main -pack edwards25519/rustgo.go
		go tool pack r $@ edwards25519/rustgo.o edwards25519/libed25519_dalek_rustgo.o

edwards25519/libed25519_dalek_rustgo.o: target/$(TARGET)/release/libed25519_dalek_rustgo.a
ifeq ($(shell go env GOOS),darwin)
		$(LD) -r -o $@ -arch x86_64 -u "_$(SYMBOL)" $^
else
		$(LD) -r -o $@ --gc-sections -u "$(SYMBOL)" $^
endif

target/$(TARGET)/release/libed25519_dalek_rustgo.a: src/* Cargo.toml Cargo.lock
		cargo build --release --target $(TARGET)

edwards25519/rustgo.o: edwards25519/rustgo.s
		go tool asm -I "$(shell go env GOROOT)/pkg/include" -o $@ $^

.PHONY: install uninstall
install: edwards25519/edwards25519.a
		mkdir -p "$(INSTALL_PATH)"
		cp edwards25519/edwards25519.a "$(INSTALL_PATH)"
uninstall:
		rm -f "$(INSTALL_PATH)/edwards25519.a"

.PHONY: clean
clean:
		rm -rf edwards25519/*.[oa] target ed25519-dalek-rustgo
