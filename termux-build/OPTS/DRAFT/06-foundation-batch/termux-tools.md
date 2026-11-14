# Repo Analysis: termux/termux-tools (R02, DRAFT)

> Foundation-batch stub instantiated from `../02-analysis-templates/repo-analysis-template.md`. **Evidence not collected in this environment.**

## Metadata

- **Repo ID:** `R02`
- **Name:** termux-tools
- **URL:** https://github.com/termux/termux-tools
- **Category:** host tooling
- **Priority:** P0
- **Target layer:** termux
- **Upstream license (if known):** `pending`
- **Pinned ref/commit analyzed:** `pending-unfetched`
- **Analysis date / analyst:** 2026-11-14 / bootstrap (no source inspection)
- **Evidence status:** `pending-unfetched`

## Ubuntu-in-Termux / PRoot problem(s) addressed

- Problem statement: `pending` — expected relevance: Termux CLI wrappers, environment setup, path/prefix handling, user-facing host utilities affecting guest launch and host workflows.
- Scope/limitations in upstream approach: `pending`
- Relevance to CUSTOM_UBU phases (1–20): 3, 4 (primary).

## Non-default patches (to mine)

| Patch/file area | Purpose | Layer | Target triple impact | Risk | Evidence (path/commit/link) | Status |
|---|---|---|---|---|---|---|
| `pending` |  | termux | `aarch64-linux-android` |  |  | pending-unfetched |

## Environment variables

| Variable | Set/consumed where | Purpose | Layer | Interaction risks | Evidence | Status |
|---|---|---|---|---|---|---|
| `pending` |  |  | termux | PATH/PREFIX/HOME/TMPDIR collisions across host/guest |  | pending-unfetched |

## Syscall / exec / shebang shims

- Mechanism: `pending` (wrapper scripts may influence exec behavior; confirm).
- Evidence: `pending-unfetched`

## ABI fixes and architecture handling

- Target: `aarch64-linux-android` host context — `pending`
- Evidence: `pending-unfetched`

## Linker / RPATH / loader handling

- Primarily scripts/wrappers expected; confirm any compiled components — `pending`
- Evidence: `pending-unfetched`

## Permission / SELinux / proc / dev / storage hacks

- Storage access helpers, Android path conventions: `pending`
- Evidence: `pending-unfetched`

## GPU (KGSL / Vulkan / ICD / Turnip / Mesa / Zink / OpenCL / EGL) — if applicable

- Applicability: `unlikely-pending`
- Evidence: `pending-unfetched`

## Service / init workarounds

- Host-side service/helpers (if any): `pending`
- Evidence: `pending-unfetched`

## Build pipeline / customizations

- Packaging/build/install details: `pending`
- Evidence: `pending-unfetched`

## Source evidence log

| Claim / finding | Evidence type (file/path/commit/link/command output) | Location/ref | Extracted by | Date | Confidence |
|---|---|---|---|---|---|
| _none yet_ |  |  |  |  |  |

## Applicability (termux / ubuntu / both)

- **Termux host:** defer-TBD
- **Ubuntu guest:** defer-TBD (reference for interface expectations only)
- **Cross-layer interfaces:** defer-TBD

## Risks and limitations

- `pending-unfetched` (wrappers may leak host env into guest if adapted incorrectly).

## Decision (adopt / adapt / reject / defer)

- **Decision:** `defer-TBD`
- **Rationale:** No source evidence inspected in sandbox.
- **Prerequisites before adoption:** Source review of wrappers/env handling; test against guest launch contract.
- **Conflicts with other repos/decisions:** R03 exec behavior, R06 login/launch scripts.

## Dependency ordering impact

- Must precede: stable host env for Phases 4-6.
- Must follow: R01 conventions, Phase 1-2.
- Manifest updates required: `termux-host-manifest.md`.

## On-device validation items (not executed here)

| ID | Validation step | Layer | Expected signal | Failure signal | Rollback |
|---|---|---|---|---|---|
| V1 | Verify affected commands resolve host paths/env correctly | termux | Correct `$PREFIX`/PATH behavior | Misresolved paths, guest env leakage | Revert wrapper/config |

## Open questions / TODO

- [ ] Identify wrappers involved in proot/login/storage workflows.
- [ ] Map env vars set/consumed and cross-layer implications.
- [ ] Align with mirrored `task.md` conventions.
