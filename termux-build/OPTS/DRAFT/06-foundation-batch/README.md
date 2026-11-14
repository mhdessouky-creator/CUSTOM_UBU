# Foundation Batch — Deep Analysis Prep (DRAFT)

**Purpose:** Prepare evidence-driven deep analysis for the Milestone A foundation repositories. Stubs below are instantiated from `../02-analysis-templates/repo-analysis-template.md` and marked `pending-unfetched` until source evidence is collected.  
**Policy:** No wholesale integration. Record `adopt/adapt/reject/defer-TBD` only with cited evidence. Keep Termux/Bionic (`aarch64-linux-android`) and Ubuntu/glibc (`aarch64-unknown-linux-gnu`) concerns separated.

## Batch scope and priority

### P0 — foundation substrate (analyze first)
| Repo ID | Repo | Target layer | Primary focus | Stub |
|---|---|---|---|---|
| R01 | termux/termux-packages | termux | packaging model, patches, NDK/cross builds, prefix/linker policy, Android-on-host rule | `termux-packages.md` |
| R02 | termux/termux-tools | termux | host wrappers, env/path/prefix behavior, storage helpers | `termux-tools.md` |
| R03 | termux/termux-exec-package | termux | exec/shebang interception, path translation, loader/ABI guards, proot interaction | `termux-exec-package.md` |
| R04 | termux/termux-core-package | termux | core runtime primitives/services, host baseline behavior | `termux-core-package.md` |
| R06 | Nwokike/proot-distro | both | Ubuntu rootfs bootstrap, proot args/binds, env, users/services under PRoot | `proot-distro.md` |
| R05 | termux/glibc-packages | both | glibc packaging/boundary handling; strict separation from Bionic artifacts | `glibc-packages.md` |

### P1 — toolchain foundation (analyze after P0 substrate constraints known)
| Repo ID | Repo | Target layer | Primary focus | Stub |
|---|---|---|---|---|
| R07 | rui314/mold | ubuntu | mold integration for supported Linux targets, linker flags/RPATH behavior | `mold.md` |
| R08 | Gong-Mi/termux-llvm-rust-mold | both | LLVM/Rust/mold integration, per-target linker selection, separation patterns | `termux-llvm-rust-mold.md` |
| R09 | JEnoch/cargo_toolchain | both | Rust/cargo bootstrap/config, per-target cargo env, toolchain ordering | `cargo_toolchain.md` |
| R10 | Ruby-on-Rails-Wizardry/ubuntu-mise | ubuntu | mise install/activation in Ubuntu guest, PATH/shell integration, no daemon assumptions | `ubuntu-mise.md` |

## Extraction/validation focus per repo

- **R01 (termux-packages):** build recipes/patch layout, termux_step_* conventions, NDK/clang/LLD flags, RPATH/prefix handling, service scripts, how Android targets are isolated.
- **R02 (termux-tools):** command wrappers, login/env setup, termux-chroot/proot-related helpers, storage path handling.
- **R03 (termux-exec-package):** `termux-exec` mechanism, LD_PRELOAD/path rewrite behavior, shebang fixups, interaction with proot and different loaders.
- **R04 (termux-core-package):** core libs/binaries, runtime assumptions, dependency surface for higher-level tools.
- **R05 (glibc-packages):** glibc prefix/sysroot strategy, coexistence/anti-mixing safeguards, linker/loader implications for guest vs host.
- **R06 (proot-distro):** rootfs download/install, login scripts, bind mounts, env vars, user creation, distro plugin structure, known PRoot limitations.
- **R07 (mold):** supported architectures/features, build/install method, integration with gcc/clang/rust, debug/strip/RPATH considerations.
- **R08 (termux-llvm-rust-mold):** how LLVM/Rust/mold are composed, target triple handling, patches, where each artifact may run (host vs guest).
- **R09 (cargo_toolchain):** bootstrap sequence, rustup/cargo config, target installation, linker wrapper patterns.
- **R10 (ubuntu-mise):** install script behavior (normally networked — record for on-device/mirrored adaptation), activation hooks, XDG/data dirs, service implications.

## Sequencing and dependencies

1. Complete P0 host substrate evidence (R01-R04) to lock host/build conventions.
2. Complete R06 to lock guest bootstrap/bind/launch contract.
3. Complete R05 with explicit ABI boundary review (high sensitivity).
4. Complete P1 toolchain set (R07-R10) aligned with `04-dependency-manifests/toolchain-manifest.md`.
5. Update `01-repo-matrix/repo-matrix.md`, manifests, and runbooks with cited decisions.

## Evidence collection prerequisites (external/on-device)

- Mirrored `task.md`/KB/conductor for gates and naming.
- Access to repo sources at pinned commits (networked clone or mirrored archives).
- On-device environment for validation probes where required (not executable in this sandbox).

## Exit criteria for foundation batch (post-prep)

- Each stub advanced from `pending-unfetched` to `partial`/`sufficient` with source citations.
- Adopt/adapt/reject decisions recorded with rationale and conflicts.
- Dependency DAG/manifests updated for any ordering or policy changes.
- P0 invariants (host/guest separation, build placement, no-systemd-in-PRoot) validated or explicitly blocked with evidence.
