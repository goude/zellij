set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

_default:
    @just --list

# 🔧 Install/update toolchain and build dependencies
setup:
    rustup show

# 🏗️ Build WASM plugins
build-plugins:
    cargo build --target wasm32-wasip1 \
        --package compact-bar \
        --package status-bar \
        --package tab-bar \
        --package strider \
        --package session-manager \
        --package configuration \
        --package plugin-manager \
        --package about \
        --package share \
        --package multiple-select \
        --package layout-manager \
        --package link

# 🏗️ Build (debug)
build: build-plugins
    cargo build

# 🚀 Build and run (release)
run: build-plugins
    cargo run --release

# 🐛 Run in debug mode
dev: build-plugins
    cargo run

# 🎨 Format code
fmt:
    cargo fmt

# 🔍 Lint with clippy
lint:
    cargo clippy -- -D warnings

# 🧪 Run tests
test:
    cargo test

# ✅ Run all checks: fmt → lint → test
check:
    cargo fmt --check
    cargo clippy -- -D warnings
    cargo test

# 🧹 Remove build artifacts
clean:
    cargo clean
