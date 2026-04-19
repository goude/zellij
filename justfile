set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

_default:
    @just --list

# 🔧 Install/update toolchain and build dependencies
setup:
    rustup show
    rustup target add wasm32-wasip1

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

# 🏗️ Build WASM plugins in release mode and refresh zellij-utils/assets/plugins/
#
# Release builds of the main binary embed plugins from zellij-utils/assets/plugins
# via include_bytes! (see zellij-utils/src/consts.rs). The plugins_from_target
# feature only swaps in freshly-built debug wasm when debug_assertions is on —
# for release we must rebuild the committed asset blobs.
build-plugins-release:
    cargo build --release --target wasm32-wasip1 \
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
    for plugin in compact-bar status-bar tab-bar strider session-manager configuration plugin-manager about share multiple-select layout-manager link; do \
        cp "target/wasm32-wasip1/release/$plugin.wasm" "zellij-utils/assets/plugins/$plugin.wasm"; \
    done

# 🚀 Build and run (release)
run: build-plugins-release
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
