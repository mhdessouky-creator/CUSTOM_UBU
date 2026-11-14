# Repo Analysis: Gong-Mi/termux-llvm-rust-mold (R08, DRAFT)

> Foundation-batch stub instantiated from `../02-analysis-templates/repo-analysis-template.md`. **Evidence not collected in this environment.**

## Metadata

- **Repo ID:** `R08`
- **Name:** termux-llvm-rust-mold
- **URL:** https://github.com/Gong-Mi/termux-llvm-rust-mold
- **Category:** toolchain integration
- **Priority:** P1
- **Target layer:** both
- **Upstream license (if known):** `pending`
- **Pinned ref/commit analyzed:** `pending-unfetched`
- **Analysis date / analyst:** 2026-11-14 / bootstrap (no source inspection)
- **Evidence status:** `pending-unfetched`

## Ubuntu-in-Termux / PRoot problem(s) addressed

- Problem statement: `pending` — expected relevance: combined LLVM/Rust/mold setup patterns relevant to Termux/Android constraints and linker-per-target selection.
- Scope/limitations in upstream approach: `pending`
- Relevance to CUSTOM_UBU phases (1–20): 13, 14 (primary), 11, 15.

## Non-default patches (to mine)

| Patch/file area | Purpose | Layer | Target triple impact | Risk | Evidence (path/commit/link) | Status |
|---|---|---|---|---|---|---|
| `pending` |  | both | `aarch64-linux-android` / `aarch64-unknown-linux-gnu` | High if boundaries unclear |  | pending-unfetched |

## Environment variables

| Variable | Set/consumed where | Purpose | Layer | Interaction risks | Evidence | Status |
|---|---|---|---|---|---|---|
| `pending` (CC/CXX/CARGO_* / RUSTFLAGS / linker vars) |  |  | both | Cross-layer leakage |  | pending-unfetched |

## Syscall / exec / shebang shims

- Applicability: `pending`
- Evidence: `pending-unfetched`

## ABI fixes and architecture handling

- Target triple handling and per-target tool selection: `pending` (critical)
- ABI correctness across Bionic/glibc: `pending`
- Evidence: `pending-unfetched`

## Linker / RPATH / loader handling

- mold vs LLD/NDK selection logic: `pending` (critical)
- RPATH/sysroot/loader per target: `pending`
- Evidence: `pending-unfetched`

## Permission / SELinux / proc / dev / storage hacks

- Applicability: `pending`
- Evidence: `pending-unfetched`

## GPU (KGSL / Vulkan / ICD / Turnip / Mesa / Zink / OpenCL / EGL) — if applicable

- Not primary; may affect builds of GPU-related components — `pending`
- Evidence: `pending-unfetched`

## Service / init workarounds

- Applicability: `unlikely-pending`
- Evidence: `pending-unfetched`

## Build pipeline / customizations

- How LLVM/Rust/mold are built/installed/composed: `pending`
- Build placement (host vs guest) per component: `pending`
- Evidence: `pending-unfetched`

## Source evidence log

| Claim / finding | Evidence type (file/path/commit/link/command output) | Location/ref | Extracted by | Date | Confidence |
|---|---|---|---|---|---|
| _none yet_ |  |  |  |  |  |

## Applicability (termux / ubuntu / both)

- **Termux host:** defer-TBD (only where Android-target-safe and evidenced)
- **Ubuntu guest:** defer-TBD (Linux-target toolchain patterns)
- **Cross-layer interfaces:** defer-TBD (separation patterns most valuable)

## Risks and limitations

- High risk of conflating host/guest toolchains if adopted without decomposition.
- Upstream intent/environment may differ from CUSTOM_UBU constraints.
- `pending-unfetched`

## Decision (adopt / adapt / reject / defer)

- **Decision:** `defer-TBD`
- **Rationale:** No source evidence inspected; integration repo requires decomposition.
- **Prerequisites before adoption:** Identify per-component layer placement, target routing, and artifact provenance; reject mixed-boundary shortcuts.
- **Conflicts with other repos/decisions:** R01/R05/R07/R09, toolchain manifest policies.

## Dependency ordering impact

- Must precede: finalized per-target toolchain config (if adopted).
- Must follow: R07/R09 evidence and ABI boundary review.
- Manifest updates required: `toolchain-manifest.md`, `global-dependency-dag.md`.

## On-device validation items (not executed here)

| ID | Validation step | Layer | Expected signal | Failure signal | Rollback |
|---|---|---|---|---|---|
| V1 | Validate target-routed build outputs per layer | both | Correct linker/loader/ABI per triple | Mixed or wrong artifacts | Revert config; enforce separation |

## Open questions / TODO

- [ ] Decompose repo into host-relevant vs guest-relevant pieces.
- [ ] Verify mold usage is restricted to supported Linux guest targets.
- [ ] Extract reproducible config snippets with evidence citations.
