# Default recipe: show help
default:
    @just --list

## Initialization ------------------------------------------------------------

# Run project initialization script
initialize:
    scripts/initialize.sh

# Run project rename script
rename:
    scripts/rename.sh

## Development ---------------------------------------------------------------

# Run tauri dev server (auto-assigned port)
dev:
    pnpm tauri dev

# Build for production
build:
    pnpm tauri build

# Build with debug symbols
build-debug:
    pnpm tauri build --debug

# Launch Storybook dev server (placeholder)
storybook:
    @echo "Storybook is not yet configured for this project."
    @echo "See: https://storybook.js.org/docs/get-started"

# Show auto-assigned port block for this worktree
ports:
    @scripts/dev-port.sh --all

## Frontend ------------------------------------------------------------------

# Run Astro dev server
frontend-dev:
    cd src-astro && pnpm run dev

# Build Astro for production
frontend-build:
    cd src-astro && pnpm run build

# Preview Astro production build
frontend-preview:
    cd src-astro && pnpm run preview

# Run frontend linter
frontend-lint:
    pnpm run frontend:lint

# Run frontend tests
frontend-test:
    pnpm run frontend:test

# Run frontend type checking
frontend-typecheck:
    pnpm run frontend:typecheck

# Format frontend code
frontend-format:
    cd src-astro && pnpm run format

# Check frontend formatting
frontend-format-check:
    cd src-astro && pnpm run format:check

## Linting & Formatting ------------------------------------------------------

# Run all linters (frontend + Rust)
lint:
    pnpm run frontend:lint
    cd src-tauri && cargo clippy -- -D warnings

# Auto-fix lint issues
lint-fix:
    cd src-astro && pnpm eslint . --fix
    cd src-tauri && cargo clippy --fix --allow-dirty

# Format all code
format:
    cd src-astro && pnpm run format

# Check formatting without changes
format-check:
    cd src-astro && pnpm run format:check
    cd src-tauri && cargo fmt -- --check

# Run frontend type checking
typecheck:
    pnpm run frontend:typecheck

## Testing -------------------------------------------------------------------

# Run all tests (frontend + Rust)
test:
    pnpm run frontend:test
    cd src-tauri && cargo test

# Run frontend unit tests only
test-unit:
    pnpm run frontend:test

## Rust ----------------------------------------------------------------------

# Run cargo clippy
rust-lint:
    cd src-tauri && cargo clippy -- -D warnings

# Run cargo fmt
rust-format:
    cd src-tauri && cargo fmt

# Run cargo test
rust-test:
    cd src-tauri && cargo test

# Alias for rust-lint
backend-lint: rust-lint

# Check backend formatting
backend-format-check:
    pnpm run backend:format:check

# Alias for rust-test
backend-test: rust-test

## CI & Setup ----------------------------------------------------------------

# Build Storybook static site (placeholder)
storybook-build:
    @echo "Storybook is not yet configured for this project."

# Run full CI pipeline (lint, format-check, typecheck, test, build)
ci: lint format-check typecheck test build

# Install dependencies and git hooks
setup:
    pnpm run project:init
    pnpm lefthook install

# Remove build artifacts
clean:
    pnpm run clean

# Install system dependencies (Debian/Ubuntu)
install-deps-debian:
    sudo apt install build-essential pkg-config libgtk-3-dev libglib2.0-dev libwebkit2gtk-4.1-dev libayatana-appindicator3-dev librsvg2-dev libssl-dev

# Create a new release
release:
    pnpm run release

# Check template sync status
template-check:
    scripts/sync-template-check
