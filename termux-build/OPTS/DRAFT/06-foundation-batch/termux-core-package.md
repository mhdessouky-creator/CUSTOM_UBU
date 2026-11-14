# Repo Analysis: termux/termux-core-package (R04, DRAFT)

> Foundation-batch stub instantiated from `../02-analysis-templates/repo-analysis-template.md`. **Evidence not collected in this environment.**

## Metadata

- **Repo ID:** `R04`
- **Name:** termux-core-package
- **URL:** https://github.com/termux/termux-core-package
- **Category:** core runtime
- **Priority:** P0
- **Target layer:** termux
- **Upstream license (if known):** `pending`
- **Pinned ref/commit analyzed:** `pending-unfetched`
- **Analysis date / analyst:** 2026-11-14 / bootstrap (no source inspection)
- **Evidence status:** `pending-unfetched`

## Ubuntu-in-Termux / PRoot problem(s) addressed

- Problem statement: `pending` — expected relevance: core Termux runtime primitives/services and foundational behavior required for host stability.
- Scope/limitations in upstream approach: `pending`
- Relevance to CUSTOM_UBU phases (1–20): 3 (primary), 4-6 (baseline dependency).

## Non-default patches (to mine)

| Patch/file area | Purpose | Layer | Target triple impact | Risk | Evidence (path/commit/link) | Status |
|---|---|---|---|---|---|---|
| `pending` |  | termux | `aarch64-linux-android` |  |  | pending-unfetched |

## Environment variables

| Variable | Set/consumed where | Purpose | Layer | Interaction risks | Evidence | Status |
|---|---|---|---|---|---|---|
| `pending` |  |  | termux | `pending` |  | pending-unfetched |

## Syscall / exec / shebang shims

- Mechanism: `pending`
- Evidence: `pending-unfetched`

## ABI fixes and architecture handling

- Target: `aarch64-linux-android` — `pending`
- Evidence: `pending-unfetched`

## Linker / RPATH / loader handling

- `pending`
- Evidence: `pending-unfetched`

## Permission / SELinux / proc / dev / storage hacks

- `pending-unfetched`

## GPU (KGSL / Vulkan / ICD / Turnup / Mesa / Zink / OpenCL / EGL) — if applicable

- Applicability: `unknown-pending`
- Evidence: `pending-unfetched`

## Service / init workarounds

- `pending-unfetched`

## Build pipeline / customizations

- `pending-unfetched`

## Source evidence log

| Claim / finding | Evidence type (file/path/commit/link/command output) | Location/ref | Extracted by | Date | Confidence |
|---|---|---|---|---|---|
| _none yet_ |  |  |  |  |  |

## Applicability (termux / ubuntu / both)

- **Termux host:** defer-TBD
- **Ubuntu guest:** defer-TBD (separate runtime; no shared binaries)
- **Cross-layer interfaces:** defer-TBD

## Risks and limitations

- `pending-unfetched`

## Decision (adopt / adapt / reject / defer)

- **Decision:** `defer-TBD`
- **Rationale:** No source evidence inspected in sandbox.
- **Prerequisites before adoption:** Source review and host baseline validation.
- **Conflicts with other repos/decisions:** R01-R03 integration points.

## Dependency ordering impact

- Must precede: stable host substrate for proot/toolchain orchestration.
- Must follow: R01-R03 as applicable.
- Manifest updates required: `termux-host-manifest.md`.

## On-device validation items (not executed here)

| ID | Validation step | Layer | Expected signal | Failure signal | Rollback |
|---|---|---|---|---|---|
| V1 | Validate core host functionality after any adopted change | termux | Baseline commands/services stable | Regressions in host runtime | Revert to prior package/config |

## Open questions / TODO

- [ ] Identify concrete components provided and their dependency edges.
- [ ] Determine relevance to CUSTOM_UBU beyond baseline Termux.
- [ ] Extract any non-default patches or env requirements.
