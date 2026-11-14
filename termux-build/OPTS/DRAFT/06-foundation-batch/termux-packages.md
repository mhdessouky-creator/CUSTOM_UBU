# Repo Analysis: termux/termux-packages (R01, DRAFT)

> Foundation-batch stub instantiated from `../02-analysis-templates/repo-analysis-template.md`. **Evidence not collected in this environment.**

## Metadata

- **Repo ID:** `R01`
- **Name:** termux-packages
- **URL:** https://github.com/termux/termux-packages
- **Category:** packaging/build base
- **Priority:** P0
- **Target layer:** termux
- **Upstream license (if known):** `pending`
- **Pinned ref/commit analyzed:** `pending-unfetched`
- **Analysis date / analyst:** 2026-11-14 / bootstrap (no source inspection)
- **Evidence status:** `pending-unfetched`

## Ubuntu-in-Termux / PRoot problem(s) addressed

- Problem statement: `pending` — expected relevance: Termux packaging model, patches, cross-compilation patterns, host tool bootstrap, prefix/layout constraints impacting downstream guest integration.
- Scope/limitations in upstream approach: `pending`
- Relevance to CUSTOM_UBU phases (1–20): 3, 13, 14 (primary); informs host build policy globally.

## Non-default patches (to mine)

| Patch/file area | Purpose | Layer | Target triple impact | Risk | Evidence (path/commit/link) | Status |
|---|---|---|---|---|---|---|
| `pending` |  | termux | `aarch64-linux-android` |  |  | pending-unfetched |

## Environment variables

| Variable | Set/consumed where | Purpose | Layer | Interaction risks | Evidence | Status |
|---|---|---|---|---|---|---|
| `pending` |  |  | termux | PREFIX/PATH/NDK/LD collisions with guest |  | pending-unfetched |

## Syscall / exec / shebang shims

- Mechanism: `pending` (likely related via termux-exec ecosystem; confirm in R03)
- Evidence: `pending-unfetched`

## ABI fixes and architecture handling

- Target triples: expected focus `aarch64-linux-android`; confirm.
- Bionic vs glibc boundary handling: `pending`
- SD 8 Gen 3 / arm64 considerations: `pending`
- Evidence: `pending-unfetched`

## Linker / RPATH / loader handling

- Linker(s): expected NDK/LLD for Android targets; confirm per package/build system.
- RPATH/RUNPATH/$ORIGIN policies: `pending`
- Dynamic loader paths: `pending`
- Sysroot/prefix isolation: `pending`
- Evidence: `pending-unfetched`

## Permission / SELinux / proc / dev / storage hacks

- `pending-unfetched`

## GPU (KGSL / Vulkan / ICD / Turnip / Mesa / Zink / OpenCL / EGL) — if applicable

- Applicability: `unknown-pending` (package recipes may include graphics components; assess per evidence)
- Evidence: `pending-unfetched`

## Service / init workarounds

- Termux service scripts/packaging behavior: `pending`
- PRoot/systemd non-applicability: ensure no guest systemd assumptions imported.
- Evidence: `pending-unfetched`

## Build pipeline / customizations

- Build system: Termux build scripts/ndk-build/cmake/meson/make/cargo as per packages — `pending`
- Host vs guest build placement: **Android/Termux packages must build on Termux host**.
- Resource constraints (on-device): `pending`
- Evidence: `pending-unfetched`

## Source evidence log

| Claim / finding | Evidence type (file/path/commit/link/command output) | Location/ref | Extracted by | Date | Confidence |
|---|---|---|---|---|---|
| _none yet_ |  |  |  |  |  |

## Applicability (termux / ubuntu / both)

- **Termux host (Bionic, `aarch64-linux-android`):** defer-TBD — core reference; evidence required.
- **Ubuntu guest (glibc, `aarch64-unknown-linux-gnu`, PRoot):** defer-TBD — indirect (build conventions only), no artifact mixing.
- **Cross-layer interfaces:** defer-TBD

## Risks and limitations

- `pending-unfetched` (risk of importing host-specific assumptions into guest if misapplied).

## Decision (adopt / adapt / reject / defer)

- **Decision:** `defer-TBD`
- **Rationale:** No source evidence inspected in sandbox.
- **Prerequisites before adoption:** Pinned commit review, patch/env/linker extraction, alignment with manifests.
- **Conflicts with other repos/decisions:** Potential overlap with R02-R05/R08; resolve via evidence.

## Dependency ordering impact

- Must precede: R02-R04 informed usage, host-side toolchain decisions (R08/R09 context).
- Must follow: Phase 1-2 baseline/intake.
- Manifest updates required: `termux-host-manifest.md`, `global-dependency-dag.md`.

## On-device validation items (not executed here)

| ID | Validation step | Layer | Expected signal | Failure signal | Rollback |
|---|---|---|---|---|---|
| V1 | Apply selected recipe/patch pattern in controlled test | termux | Correct target triple, NDK/LLD linkage, runnable on host | Wrong loader/ABI/RPATH or build failure | Revert patch/config; restore baseline pkg state |

## Open questions / TODO

- [ ] Fetch/pin repo commit and extract relevant build infrastructure docs/scripts.
- [ ] Identify aarch64/SD 8 Gen 3 relevant patches and resource knobs.
- [ ] Reconcile with mirrored `task.md`/conductor packaging requirements.
