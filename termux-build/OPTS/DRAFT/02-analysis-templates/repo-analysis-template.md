# Per-Repo Analysis Template (CUSTOM_UBU, DRAFT)

> Instantiate one copy per repository (e.g. `06-foundation-batch/<repo-id>.md` or `07-repo-analyses/<repo-id>.md`). Replace placeholders; do not invent evidence. Cite sources as `file/path`, `commit`, or `URL` with access date/context.

## Metadata

- **Repo ID:** `R??`
- **Name:** 
- **URL:** 
- **Category:** (packaging/build base | host tooling | exec/shebang/shim | core runtime | glibc packaging | proot distro mgmt | linker | toolchain integration | Rust/cargo toolchain | mise | installer/runtime | GPU/desktop | utility/reference | dotfiles/scripts)
- **Priority:** P0 | P1 | P1/P2 | P2 | P3
- **Target layer:** termux | ubuntu | both
- **Upstream license (if known):** `pending`
- **Pinned ref/commit analyzed:** `pending-unfetched` (record exact commit/tag when extracted)
- **Analysis date / analyst:** 
- **Evidence status:** `pending-unfetched` | `partial` | `sufficient`

## Ubuntu-in-Termux / PRoot problem(s) addressed

- Problem statement (as relevant to simulated root, bind mounts, glibc-on-Bionic host, no root, Adreno 750 target):
- Scope/limitations in upstream approach:
- Relevance to CUSTOM_UBU phases (1–20): 

## Non-default patches (to mine)

| Patch/file area | Purpose | Layer | Target triple impact | Risk | Evidence (path/commit/link) | Status |
|---|---|---|---|---|---|---|
|  |  | termux/ubuntu | `aarch64-linux-android` / `aarch64-unknown-linux-gnu` |  |  | pending |

## Environment variables

| Variable | Set/consumed where | Purpose | Layer | Interaction risks | Evidence | Status |
|---|---|---|---|---|---|---|
|  |  |  |  | PATH/LD/PREFIX collisions across Bionic/glibc |  | pending |

## Syscall / exec / shebang shims

- Shim/interposition mechanism (e.g. `termux-exec`, proot `-b`/script wrappers, loader redirection):
- Shebang/path translation behavior:
- Execve/fexecve/binfmt or argv/env rewriting considerations:
- PRoot-specific constraints observed/expected:
- Evidence:
- Applicability/risk:

## ABI fixes and architecture handling

- Target triples addressed (`aarch64-linux-android`, `aarch64-unknown-linux-gnu`, others):
- ABI boundaries (Bionic vs glibc), symbol/versioning issues:
- Data/type/alignment/endian or struct-layout concerns (if any):
- CPU feature assumptions (armv8.x, NEON, etc.) and device fit (SD 8 Gen 3):
- Evidence:

## Linker / RPATH / loader handling

- Linker(s) used/intended (LLD/NDK, mold, bfd/lld in guest): 
- RPATH/RUNPATH/`$ORIGIN` policies:
- Dynamic loader paths (`/system/bin/linker64`, Termux loader, `/lib/ld-linux-aarch64.so.1` in guest, etc.):
- Sysroot/prefix isolation measures:
- Cross-layer leakage risks and mitigations:
- Evidence:

## Permission / SELinux / proc / dev / storage hacks

- Android permission/storage model handling (`/storage/emulated/0`, app data, scoped storage):
- SELinux constraints/workarounds (no root; do not assume permissive):
- `/proc`, `/dev`, `/sys` availability/quirks under PRoot:
- Bind mounts, fake/procfs entries, tmp/devpts/shm handling:
- Evidence:

## GPU (KGSL / Vulkan / ICD / Turnip / Mesa / Zink / OpenCL / EGL) — if applicable

- Device/GPU assumptions (Adreno 750 / KGSL):
- Vulkan ICD / loader discovery, env vars, JSON manifests:
- Mesa/Turnip/Zink paths and glibc/Bionic layer placement:
- OpenCL/EGL/GLX/Wayland/X11 surface considerations:
- Validation separation required (host vs guest, driver vs userspace):
- Evidence:

## Service / init workarounds

- Init/service model in upstream (systemd/openrc/runit/ad-hoc scripts):
- PRoot constraints (no real systemd/cgroups/namespaces/daemon assumptions):
- Foreground supervisor/runit adaptations applicable:
- Start/stop/restart, logging, readiness checks:
- Evidence:

## Build pipeline / customizations

- Build system (make/cmake/meson/cargo/ndk-build/custom scripts):
- Bootstrap/order dependencies:
- Host vs guest build placement (Android/Termux on host; Linux targets in Ubuntu):
- Caching, parallelism, resource constraints (on-device):
- Patch application and source provenance:
- Evidence:

## Source evidence log

| Claim / finding | Evidence type (file/path/commit/link/command output) | Location/ref | Extracted by | Date | Confidence |
|---|---|---|---|---|---|
|  |  |  |  |  |  |

## Applicability (termux / ubuntu / both)

- **Termux host (Bionic, `aarch64-linux-android`):** adopt/adapt/reject/TBD — rationale
- **Ubuntu guest (glibc, `aarch64-unknown-linux-gnu`, PRoot):** adopt/adapt/reject/TBD — rationale
- **Cross-layer interfaces (bindings/launch/env contracts):** adopt/adapt/reject/TBD — rationale

## Risks and limitations

- Technical/ABI/runtime risks:
- Maintenance/upstream drift risks:
- Device/performance/resource risks:
- Security/permission/SELinux risks:
- Unknowns requiring on-device validation:

## Decision (adopt / adapt / reject / defer)

- **Decision:** `defer-TBD`
- **Rationale:** 
- **Prerequisites before adoption:** 
- **Conflicts with other repos/decisions:** 

## Dependency ordering impact

- Must precede: 
- Must follow: 
- Co-dependent with (and separation rules): 
- Manifest updates required (`global-dependency-dag.md`, per-domain manifests):

## On-device validation items (not executed here)

| ID | Validation step | Layer | Expected signal | Failure signal | Rollback |
|---|---|---|---|---|---|
| V1 |  | termux/ubuntu |  |  |  |

## Open questions / TODO

- [ ] 
