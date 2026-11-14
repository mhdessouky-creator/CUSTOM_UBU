# Repo Analysis: termux/glibc-packages (R05, DRAFT)

> Foundation-batch stub instantiated from `../02-analysis-templates/repo-analysis-template.md`. **Evidence not collected in this environment. High-sensitivity: ABI/boundary risks.**

## Metadata

- **Repo ID:** `R05`
- **Name:** glibc-packages
- **URL:** https://github.com/termux/glibc-packages
- **Category:** glibc packaging (Termux context)
- **Priority:** P0
- **Target layer:** both
- **Upstream license (if known):** `pending`
- **Pinned ref/commit analyzed:** `pending-unfetched`
- **Analysis date / analyst:** 2026-11-14 / bootstrap (no source inspection)
- **Evidence status:** `pending-unfetched`

## Ubuntu-in-Termux / PRoot problem(s) addressed

- Problem statement: `pending` — expected relevance: glibc-based packages/tooling patterns in Termux ecosystem and coexistence/separation from Bionic; informs Ubuntu-guest boundary strategy.
- Scope/limitations in upstream approach: `pending`
- Relevance to CUSTOM_UBU phases (1–20): 15 (primary), 11-14 (boundary constraints).

## Non-default patches (to mine)

| Patch/file area | Purpose | Layer | Target triple impact | Risk | Evidence (path/commit/link) | Status |
|---|---|---|---|---|---|---|
| `pending` |  | both | `aarch64-unknown-linux-gnu` / boundary handling | **High** (ABI mixing) |  | pending-unfetched |

## Environment variables

| Variable | Set/consumed where | Purpose | Layer | Interaction risks | Evidence | Status |
|---|---|---|---|---|---|---|
| `pending` |  |  | both | Critical: loader/library path leakage across Bionic/glibc |  | pending-unfetched |

## Syscall / exec / shebang shims

- `pending` (any loader/prefix selection logic is high-value evidence)
- Evidence: `pending-unfetched`

## ABI fixes and architecture handling

- glibc vs Bionic ABI boundaries, symbol/version handling: `pending`
- Target triple/prefix/sysroot separation mechanisms: `pending`
- Evidence: `pending-unfetched`

## Linker / RPATH / loader handling

- glibc dynamic loader paths, RPATH/RUNPATH policies, sysroot isolation: `pending`
- Interaction with Termux prefix and Android loader: **must not mix** — `pending`
- Evidence: `pending-unfetched`

## Permission / SELinux / proc / dev / storage hacks

- `pending-unfetched`

## GPU (KGSL / Vulkan / ICD / Turnip / Mesa / Zink / OpenCL / EGL) — if applicable

- Applicability: `possible-pending` (graphics libs may exist; assess layer placement)
- Evidence: `pending-unfetched`

## Service / init workarounds

- `pending-unfetched`

## Build pipeline / customizations

- Packaging/build system for glibc-targeted artifacts in Termux context: `pending`
- Where builds run and which sysroots used: `pending`
- Evidence: `pending-unfetched`

## Source evidence log

| Claim / finding | Evidence type (file/path/commit/link/command output) | Location/ref | Extracted by | Date | Confidence |
|---|---|---|---|---|---|
| _none yet_ |  |  |  |  |  |

## Applicability (termux / ubuntu / both)

- **Termux host:** defer-TBD — mine separation strategy; do not import glibc runtime into Bionic host.
- **Ubuntu guest:** defer-TBD — compare packaging concepts only; guest has its own glibc userspace.
- **Cross-layer interfaces:** defer-TBD (primary value if safe)

## Risks and limitations

- **High risk:** accidental Bionic/glibc mixing, wrong loader, or RPATH leakage can break host/guest.
- Must not treat this repo as permission to co-locate runtimes without evidence-backed isolation.
- `pending-unfetched`

## Decision (adopt / adapt / reject / defer)

- **Decision:** `defer-TBD`
- **Rationale:** No source evidence inspected; boundary-sensitive repo requires careful review.
- **Prerequisites before adoption:** Explicit evidence of isolation model, loader/RPATH handling, and successful on-device separation tests.
- **Conflicts with other repos/decisions:** R01 host packaging, R06 guest rootfs, R07/R08 toolchain linking.

## Dependency ordering impact

- Must precede: Phase 15 ABI boundary decisions.
- Must follow: Phases 13-14 toolchain/linker policy drafts.
- Manifest updates required: `global-dependency-dag.md`, `toolchain-manifest.md`, cross-category docs.

## On-device validation items (not executed here)

| ID | Validation step | Layer | Expected signal | Failure signal | Rollback |
|---|---|---|---|---|---|
| V1 | Audit any adopted artifact for interpreter/needed libs | both | Correct loader and libs per layer | Cross-layer loader/lib references | Reject artifact; restore separation |

## Open questions / TODO

- [ ] Determine how repo separates glibc prefix/sysroot from Termux Bionic prefix.
- [ ] Identify artifacts directly relevant vs hazardous for CUSTOM_UBU.
- [ ] Reconcile with mirrored `task.md`/KB guidance on glibc-in-Termux approaches.
