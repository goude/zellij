# CLAUDE.md

## Session Discipline

- Never write >150 lines in a single tool call
- For files >100 lines: create skeleton first, fill sections in subsequent edits
- Never retry a timed-out operation identically — break it smaller
- On interrupt: stop immediately, commit partial work, then reassess
- After any file edit, re-read before editing again (stale context kills diffs)

## Boundaries

| Crate           | May import from                        | Must NOT import from |
| --------------- | -------------------------------------- | -------------------- |
| `zellij-utils`  | (stdlib + external crates only)        | client, server, tile |
| `zellij-tile`   | `zellij-utils`                         | client, server       |
| `zellij-client` | `zellij-utils`                         | server               |
| `zellij-server` | `zellij-utils`, `zellij-tile`          | client               |
| `zellij` (bin)  | `zellij-client`, `zellij-server`, `zellij-utils` |               |

Soft rules — not enforced by CI, but violations need justification.

## Ownership

- `src/` — binary entry point, CLI wiring, session bootstrapping
- `zellij-client/` — terminal I/O, input handling, client-side rendering
- `zellij-server/` — pty management, plugin host, screen/tab/pane logic
- `zellij-tile/` — public plugin API (WASM interface for plugins)
- `zellij-tile-utils/` — helpers for plugin authors
- `zellij-utils/` — shared types, config, IPC protocol, no side effects
- `default-plugins/` — bundled plugins (written against `zellij-tile`)
- `xtask/` — build automation (invoked via `cargo xtask`)

## Before Finishing

Run `just check` (fmt → clippy → test). Zero warnings.

## Reference

- Architecture: docs/ARCHITECTURE.md
- Contributing: CONTRIBUTING.md
- Backlog: docs/backlog.md
