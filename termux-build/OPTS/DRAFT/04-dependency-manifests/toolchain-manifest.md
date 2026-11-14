# Toolchain Manifest (DRAFT)

**Goal:** Define ordered toolchain bootstrap and steady-state configuration for CUSTOM_UBU with strict Bionic/glibc and host/guest separation.  
**Critical rule:** Android/Termux builds on **Termux host** (NDK/LLD, `aarch64-linux-android`). Supported Linux-target builds in **Ubuntu guest** (mold where supported, `aarch64-unknown-linux-gnu`). Never mix sysroots, loaders, RPATHs, or artifacts.

## Toolchain flow (ordered)

| Stage | Layer | Component | Repo refs | Purpose | Prerequisites | Outputs | Status |
|---:|---|---|---|---|---|---|---|
| T1 | ubuntu (guest) | Bootstrap Rust | R09 (patterns), R08 context | Minimal Rust/cargo to enable further tooling | Guest base ready (Phases 7,9,10) | Isolated bootstrap toolchain, env notes | pending-unfetched |
| T2 | ubuntu (guest) | mise | R10, R11 (ref) | Tool/version management and activation in guest | T1 (or method per evidence/decision) | mise install/config, pinned tools | pending-unfetched |
| T3 | ubuntu (guest) | Final Rust/Cargo | R08, R09 | Stable development/CI-equivalent toolchain for Linux targets | T1-T2, resource budget | Final rustc/cargo/rustup (as chosen), per-target configs | pending-unfetched |
| T4 | ubuntu (guest) | mold linker integration | R07, R08, R22 (ref) | Fast linking for supported Linux targets | T3, compatible C/C++/Rust toolchain | Linker config/flags, audit results | pending-unfetched |
| T5 | termux (host) | Android/NDK build toolchain (if needed) | R01, R08 context | Build Android/Termux artifacts correctly on host | Host baseline, NDK/SDK components (on-device/external prep) | NDK/LLD config, host-only build env | pending-unfetched |
| T6 | both | Per-target compiler/linker policy & sysroot isolation | R01,R05,R07,R08,R09 | Enforce correct tool selection and artifact boundaries | T3-T5 evidence | Policy matrix, cargo/cmake/meson/pkg-config profiles | pending |

> **Decision pending:** exact bootstrap mechanism (prebuilt binaries, rustup, source build) and versions must follow mirrored `task.md`/conductor and on-device feasibility/resource constraints.

## Per-target policy matrix

| Target | Layer | Where to build | Compiler/toolchain | Linker | Loader/interpreter (expected) | Sysroot/lib search | Notes |
|---|---|---|---|---|---|---|---|
| `aarch64-linux-android` | termux host (Bionic) | **Termux host only** | NDK clang/LLVM as applicable | **LLD/NDK** | Android/Termux-compatible loader for target | NDK/Termux sysroots only | Never build in PRoot; never use mold. |
| `aarch64-unknown-linux-gnu` | ubuntu guest (glibc) | **Ubuntu guest** | gcc/clang + rustc as configured in guest | **mold** for supported targets (fallback documented if unsupported) | `/lib/ld-linux-aarch64.so.1` (guest) or per-rootfs | Guest sysroot `/usr` paths only | Do not link against Termux `$PREFIX`. |

## Rust/Cargo configuration guidance (DRAFT)

- Maintain separate cargo homes/configs if host and guest Rust environments coexist (preferred: guest-only for Linux targets, host-only for Android targets).
- Configure `target.<triple>.linker` and required `rustflags` explicitly per triple; avoid global flags that leak across targets.
- Use `CARGO_TARGET_DIR` per layer/workspace to prevent mixed artifacts.
- Record provenance: toolchain channel/version, source, install path, hash (when available).

## mise configuration guidance (DRAFT)

- Install and activate mise in **Ubuntu guest** context only unless explicitly separated.
- Pin tool versions in repo/config once `task.md`/conductor specifies canonical pins.
- Avoid devcontainer-specific behaviors (R11 is reference-only); no Docker daemon assumptions.
- Keep mise shims/data in guest XDG/workspace paths (see `ubuntu-guest-manifest.md`).

## Mold / linker notes

- Use mold for supported Linux targets in Ubuntu to improve link times/resource use where stable.
- Validate mold compatibility with selected LLVM/Rust/binutils versions (evidence from R07/R08/R22).
- For unsupported cases, document fallback linker and performance implications; do not silently switch target policy.
- Audit outputs with `readelf -l/-d` or equivalent (on-device) to confirm interpreter/RPATH/RUNPATH.

## Isolation and "do-not-mix" checks

- [ ] `PATH` resolves intended compiler/linker per layer and target.
- [ ] No `LD_LIBRARY_PATH` exports crossing host/guest.
- [ ] No shared build directory contains both Bionic and glibc artifacts.
- [ ] pkg-config/cmake/meson search paths point to correct sysroot per target.
- [ ] Android-target outputs not produced or linked inside PRoot.

## Risks

- Toolchain bootstrap can be resource-intensive on-device; prefer prebuilt/mirrored artifacts when authorized and verified.
- Version skew between LLVM/Rust/mold can break linking; pin after evidence.
- termux/glibc boundary patterns (R05/R08) are high-risk for ABI leakage; require explicit review before adoption.

## On-device validation checklist (deferred)

- [ ] `rustc -vV` / `cargo -V` report expected guest toolchain and paths.
- [ ] Guest sample build links with mold (supported target) and runs with guest loader.
- [ ] Host/Android sample build (if in scope) links with NDK/LLD on host.
- [ ] Artifact audit confirms correct interpreter, RPATH, and needed libs per layer.
- [ ] Rollback to prior toolchain config documented and tested.
