# Repo Analysis: rui314/mold (R07, DRAFT)

> Foundation-batch stub instantiated from `../02-analysis-templates/repo-analysis-template.md`. **Evidence not collected in this environment.**

## Metadata

- **Repo ID:** `R07`
- **Name:** mold
- **URL:** https://github.com/rui314/mold
- **Category:** linker
- **Priority:** P1
- **Target layer:** ubuntu
- **Upstream license (if known):** `pending`
- **Pinned ref/commit analyzed:** `pending-unfetched`
- **Analysis date / analyst:** 2026-11-14 / bootstrap (no source inspection)
- **Evidence status:** `pending-unfetched`

## Ubuntu-in-Termux / PRoot problem(s) addressed

- Problem statement: `pending` — expected relevance: fast linking for supported Linux targets in Ubuntu guest, improving on-device build/resource efficiency.
- Scope/limitations in upstream approach: `pending` (target/feature support must be evidenced).
- Relevance to CUSTOM_UBU phases (1–20): 14 (primary), 13, 16, 19.

## Non-default patches (to mine)

| Patch/file area | Purpose | Layer | Target triple impact | Risk | Evidence (path/commit/link) | Status |
|---|---|---|---|---|---|---|
| `pending` |  | ubuntu | `aarch64-unknown-linux-gnu` (expected) |  |  | pending-unfetched |

## Environment variables

| Variable | Set/consumed where | Purpose | Layer | Interaction risks | Evidence | Status |
|---|---|---|---|---|---|---|
| `pending` |  |  | ubuntu | Must not affect host Android/NDK builds |  | pending-unfetched |

## Syscall / exec / shebang shims

- Applicability: `unlikely-pending`
- Evidence: `pending-unfetched`

## ABI fixes and architecture handling

- aarch64/Linux support, TLS/RELRO/feature flags: `pending`
- Evidence: `pending-unfetched`

## Linker / RPATH / loader handling

- Linker flags, RPATH/RUNPATH/$ORIGIN behavior, `--sysroot`/library search: `pending` (core subject)
- Compatibility with gcc/clang/rustc in guest: `pending`
- Evidence: `pending-unfetched`

## Permission / SELinux / proc / dev / storage hacks

- Applicability: `unlikely-pending`
- Evidence: `pending-unfetched`

## GPU (KGSL / Vulkan / ICD / Turnip / Mesa / Zink / OpenCL / EGL) — if applicable

- Not applicable (linker). Build performance may affect GPU stack builds — indirect only.
- Evidence: `pending-unfetched`

## Service / init workarounds

- Not applicable.
- Evidence: `pending-unfetched`

## Build pipeline / customizations

- Build/install method, dependencies, on-device resource cost: `pending`
- Integration via compiler driver `-fuse-ld=mold` or cargo config: `pending`
- Evidence: `pending-unfetched`

## Source evidence log

| Claim / finding | Evidence type (file/path/commit/link/command output) | Location/ref | Extracted by | Date | Confidence |
|---|---|---|---|---|---|
| _none yet_ |  |  |  |  |  |

## Applicability (termux / ubuntu / both)

- **Termux host:** reject/defer-TBD for Android/NDK linking (use LLD/NDK).
- **Ubuntu guest:** defer-TBD — primary intended use for supported Linux targets.
- **Cross-layer interfaces:** defer-TBD (policy boundary only)

## Risks and limitations

- Version/feature compatibility with guest toolchain; unsupported cases require fallback.
- `pending-unfetched`

## Decision (adopt / adapt / reject / defer)

- **Decision:** `defer-TBD`
- **Rationale:** No source/evidence inspected.
- **Prerequisites before adoption:** Confirm aarch64 support/version, integrate in guest-only config, audit linked outputs.
- **Conflicts with other repos/decisions:** R08 integration patterns, NDK/LLD policy for host.

## Dependency ordering impact

- Must precede: Phase 14 policy enforcement, efficient guest builds.
- Must follow: Phase 13 guest toolchain baseline.
- Manifest updates required: `toolchain-manifest.md`, `global-dependency-dag.md`.

## On-device validation items (not executed here)

| ID | Validation step | Layer | Expected signal | Failure signal | Rollback |
|---|---|---|---|---|---|
| V1 | Link sample C/C++/Rust program in guest with mold | ubuntu | Successful link, correct interpreter/RPATH | Link errors or wrong runtime deps | Fallback linker per policy |

## Open questions / TODO

- [ ] Confirm supported targets/features for chosen mold version on aarch64.
- [ ] Determine install/build strategy under resource constraints.
- [ ] Capture cargo/rustc and C/C++ integration patterns.
