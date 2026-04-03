set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

_default:
    @just --list

# 🔧 Install/update toolchain and build dependencies
setup:
    rustup show

# 🏗️ Build (debug)
build:
    cargo build

# 🚀 Build and run (release)
run:
    cargo run --release

# 🐛 Run in debug mode
dev:
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
