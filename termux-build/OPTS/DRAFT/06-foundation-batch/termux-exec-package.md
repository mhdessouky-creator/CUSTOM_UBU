# Repo Analysis: termux/termux-exec-package (R03, DRAFT)

> Foundation-batch stub instantiated from `../02-analysis-templates/repo-analysis-template.md`. **Evidence not collected in this environment.**

## Metadata

- **Repo ID:** `R03`
- **Name:** termux-exec-package
- **URL:** https://github.com/termux/termux-exec-package
- **Category:** exec/shebang/shim
- **Priority:** P0
- **Target layer:** termux
- **Upstream license (if known):** `pending`
- **Pinned ref/commit analyzed:** `pending-unfetched`
- **Analysis date / analyst:** 2026-11-14 / bootstrap (no source inspection)
- **Evidence status:** `pending-unfetched`

## Ubuntu-in-Termux / PRoot problem(s) addressed

- Problem statement: `pending` — expected relevance: shebang/exec interception, path translation, linker/loader invocation quirks under Termux prefix; critical at host/guest boundary.
- Scope/limitations in upstream approach: `pending`
- Relevance to CUSTOM_UBU phases (1–20): 4 (primary), 5-6 (interaction with proot), 3.

## Non-default patches (to mine)

| Patch/file area | Purpose | Layer | Target triple impact | Risk | Evidence (path/commit/link) | Status |
|---|---|---|---|---|---|---|
| `pending` |  | termux | `aarch64-linux-android` |  |  | pending-unfetched |

## Environment variables

| Variable | Set/consumed where | Purpose | Layer | Interaction risks | Evidence | Status |
|---|---|---|---|---|---|---|
| `pending` (e.g. LD_PRELOAD-related controls, if any) |  |  | termux | May affect guest process startup under proot if leaked |  | pending-unfetched |

## Syscall / exec / shebang shims

- Shim/interposition mechanism: `pending` (core subject of repo).
- Shebang/path translation behavior: `pending`
- Execve/fexecve/argv/env rewriting considerations: `pending`
- PRoot-specific constraints observed/expected: `pending`
- Evidence: `pending-unfetched`

## ABI fixes and architecture handling

- Target: `aarch64-linux-android` host; ABI guards: `pending`
- Evidence: `pending-unfetched`

## Linker / RPATH / loader handling

- Loader redirection/invocation behavior: `pending`
- Interaction with Bionic vs guest glibc loaders: **must remain separated** — `pending`
- Evidence: `pending-unfetched`

## Permission / SELinux / proc / dev / storage hacks

- `pending-unfetched`

## GPU (KGSL / Vulkan / ICD / Turnip / Mesa / Zink / OpenCL / EGL) — if applicable

- Applicability: `unlikely-pending`
- Evidence: `pending-unfetched`

## Service / init workarounds

- Applicability: `pending`
- Evidence: `pending-unfetched`

## Build pipeline / customizations

- Build system/install integration: `pending`
- Evidence: `pending-unfetched`

## Source evidence log

| Claim / finding | Evidence type (file/path/commit/link/command output) | Location/ref | Extracted by | Date | Confidence |
|---|---|---|---|---|---|
| _none yet_ |  |  |  |  |  |

## Applicability (termux / ubuntu / both)

- **Termux host:** defer-TBD (critical)
- **Ubuntu guest:** defer-TBD (boundary behavior only; do not apply Bionic shim semantics inside guest)
- **Cross-layer interfaces:** defer-TBD

## Risks and limitations

- Incorrect adaptation can break script execution on host or inside proot; high regression risk.
- `pending-unfetched`

## Decision (adopt / adapt / reject / defer)

- **Decision:** `defer-TBD`
- **Rationale:** No source evidence inspected in sandbox.
- **Prerequisites before adoption:** Source-level understanding of interception conditions, env controls, and proot interactions; on-device regression tests.
- **Conflicts with other repos/decisions:** R02 wrappers, R06 proot launch/env.

## Dependency ordering impact

- Must precede: reliable Phase 4-6 execution behavior.
- Must follow: R01/R02, Phase 3.
- Manifest updates required: `termux-host-manifest.md`, `global-dependency-dag.md`.

## On-device validation items (not executed here)

| ID | Validation step | Layer | Expected signal | Failure signal | Rollback |
|---|---|---|---|---|---|
| V1 | Execute representative shebang scripts on host | termux | Correct interpreter/path resolution | Exec format/path errors | Revert exec config/package state |
| V2 | Execute scripts across proot boundary per contract | both | Expected host/guest interpreter selection | Wrong loader or leaked interception | Adjust contract/env; rollback change |

## Open questions / TODO

- [ ] Confirm interception mechanism, opt-out controls, and edge cases.
- [ ] Document behavior with proot bind mounts and guest binaries.
- [ ] Capture known issues relevant to aarch64/Android.
