# Global Dependency DAG (DRAFT)

**Purpose:** Define phase and repo/toolchain ordering for CUSTOM_UBU and enforce “do-not-mix” artifact rules across Termux host (Bionic) and Ubuntu guest (glibc) in PRoot.  
**Status:** DRAFT; refine after `task.md`/conductor and repo evidence are mirrored.

## High-level phase DAG

```text
[Phase 1 Host readiness]
          |
[Phase 2 Workspace/intake alignment]
          |
[Phase 3 Termux core/tool substrate (R01-R04)]
          |
[Phase 4 termux-exec / shebang-exec correctness (R03)]
          |
[Phase 5 PRoot Ubuntu bootstrap (R06)] ---> [Phase 10 Network/DNS/certs policy]
          |                                            |
[Phase 6 Binds/storage/proc/dev]                       |
          |                                            |
[Phase 7 Ubuntu base hygiene/layout] <-----------------+
          |
   +------+-------------------+
   |                          |
[Phase 8 Supervision/no-systemd]  [Phase 11 Toolchain bootstrap (Rust)]
   |                          |
[Phase 9 XDG/workspace conventions]  [Phase 12 mise (Ubuntu, R10/R11)]
   |                          |
   +----------+---------------+
              |
      [Phase 13 Final Rust/Cargo & per-target config (R08/R09)]
              |
      [Phase 14 Linkers/compilers policy & sysroot isolation (R07/R08)]
              |
      [Phase 15 glibc-packages / ABI boundary (R05)]
              |
      [Phase 16 Build pipeline hardening & resource controls]
              |
      [Phase 17 GPU bring-up planning (Adreno 750, R17/R18/...)]
              |
      [Phase 18 GPU/runtime validation separation]
              |
      [Phase 19 Optional desktop/runtime/workloads (R12-R18/R21-R22)]
              |
      [Phase 20 E2E validation, rollback drills, sync-back]
```

## Repo-to-phase alignment (primary)

| Repo (ID) | Priority | Primary phase(s) | Role in DAG | Hard prerequisites |
|---|---|---|---|---|
| termux/termux-packages (R01) | P0 | 3, 13, 14 | Host packaging/build conventions, Android-target patterns | Phase 1-2 |
| termux/termux-tools (R02) | P0 | 3, 4 | Host env/path tooling | R01 conventions |
| termux/termux-exec-package (R03) | P0 | 4 | Exec/shebang shim behavior | R01/R02, Phase 3 |
| termux/termux-core-package (R04) | P0 | 3 | Core host runtime substrate | R01-R03 |
| termux/glibc-packages (R05) | P0 | 15 | glibc/boundary patterns (sensitive) | Phase 14, strict separation |
| Nwokike/proot-distro (R06) | P0 | 5, 6, 8 | Guest bootstrap/binds/launch/service context | Phase 3-4 |
| rui314/mold (R07) | P1 | 14 | Linux guest linker (supported targets) | Phase 13, guest toolchain |
| Gong-Mi/termux-llvm-rust-mold (R08) | P1 | 13, 14 | LLVM/Rust/mold integration patterns | R07/R09 evidence, separation rules |
| JEnoch/cargo_toolchain (R09) | P1 | 11, 13 | Rust/cargo bootstrap/config patterns | Phase 7/9/10 |
| Ruby-on-Rails-Wizardry/ubuntu-mise (R10) | P1 | 12 | mise install/activation in Ubuntu | Phase 11 |
| mkvlrn/mise-devcontainers (R11) | P1 | 12 | mise/env reproducibility patterns (reference, no Docker) | R10 |
| pdev-labs/Linux-For-Android (R12) | P1/P2 | 5-6, 17-19 | Runtime/integration patterns | R06 baseline |
| NicolasArthurDev/linux-android (R13) | P1/P2 | 5-6, 17-19 | Alternative runtime patterns | R06 baseline |
| ItsMeAbhishekRai/Ultimate-Termux-Linux-Installer (R14) | P1/P2 | 5-6, 19 | Installer/desktop-runtime patterns | R06 baseline |
| mugabiBenjamin/installer (R15) | P1/P2 | 5-6 | Installer/bootstrap patterns | R06 baseline |
| santoni-star/hermesbox (R16) | P1/P2 | 8, 9, 19 | Runtime/layout/supervision patterns | Phase 7-8 |
| bunnyxzyq-debug/termux-ubuntu-gpu-desktop (R17) | P1/P2 | 17, 18, 19 | Adreno/GPU/desktop integration patterns | Phase 6-9, device GPU |
| adittaya/ubuntu-mobile-desktop (R18) | P1/P2 | 17, 19 | Mobile desktop/runtime composition | Phase 8, 17 |
| eggplants/mb (R19) | P2/P3 | 16, 19 (if relevant) | Utility reference | evidence-driven only |
| ssfuisu/cortex (R20) | P2/P3 | 19 (if relevant) | Utility/framework reference | evidence-driven only |
| jakasasmita/sugarmaker-ubuntu-termux (R21) | P2/P3 | 16, 19 | Workload/build validation candidate | toolchain ready |
| Human-XD/MoldSign_Server_linux (R22) | P2/P3 | 14, 19 | mold-linked build/service reference | R07, Phase 14 |
| takuzoo3868/dotfiles (R23) | P2/P3 | 9 | Env/workspace reference | none strict |
| DakEnviy/dots (R24) | P2/P3 | 9 | Env/workspace reference | none strict |
| xcrystalxmariex-svn/bash (R25) | P2/P3 | 8, 16 (ref) | Scripting patterns reference | vetted adoption only |

## Toolchain ordering (critical path)

1. **Host baseline (Termux/Bionic):** core packages/tools/exec ready for host-side operations.
2. **Guest base (Ubuntu/glibc in PRoot):** rootfs, binds, layout, supervision, XDG.
3. **Bootstrap Rust (guest):** isolated install, correct guest triple.
4. **mise (guest):** manages guest tool versions/environments.
5. **Final Rust/Cargo:** per-target configs; Android/Termux builds remain on host.
6. **Linkers/compilers:** mold for supported Linux targets in Ubuntu; LLD/NDK for Android/Termux on host.
7. **Build hardening & validation:** before GPU/runtime integration and E2E.

## "Do-not-mix" artifact rules

| Domain | Termux host (Bionic) | Ubuntu guest (glibc, PRoot) | Forbidden |
|---|---|---|---|
| Target triple | `aarch64-linux-android` | `aarch64-unknown-linux-gnu` | Using wrong triple for produced artifacts |
| C runtime / libs | Bionic, Termux `$PREFIX` libs | glibc, guest `/usr/lib`/sysroot libs | Co-loading or linking Bionic libs into guest binaries (and vice versa) |
| Dynamic loader | Android/Termux linker/loader as appropriate | `/lib/ld-linux-aarch64.so.1` (guest) | Hardcoding cross-layer loader paths |
| Build location | Android/Termux packages on host (NDK/LLD) | Linux-target builds in guest | Building Android targets in PRoot |
| Linker | LLD/NDK for Android/Termux | mold for supported Linux targets (else documented fallback) | mold for Android/NDK; mixing linker/sysroot flags across layers |
| Env/config | Host PATH/PREFIX/LD vars scoped to host | Guest PATH/XDG/LD vars scoped to guest | Exporting guest LD_LIBRARY_PATH or prefixes into host build env |
| Services | Termux services (host-side, as applicable) | Foreground supervisor/runit tested in PRoot | systemd/cgroups/namespace/daemon assumptions in PRoot |
| GPU userspace | Host driver/KGSL interfaces as exposed | Guest ICD/Mesa/Turnip/Zink userspace as configured | Treating validation results as interchangeable across layers |
| Artifacts | Stored under host-designated trees | Stored under guest-designated trees | Shared bin/lib dirs containing mixed-ABI artifacts |

## Gate dependencies (must satisfy before advancing)

- **Before Phase 5+:** host baseline stable (Phase 1) and exec/proot approach evidenced (Phases 3-4, R03/R06).
- **Before Phase 11+:** guest layout/supervision/XDG and network policy defined (Phases 7-10).
- **Before Phase 17+:** toolchain/linker/ABI boundaries enforced (Phases 13-15).
- **Before Phase 20:** layer-separated validation evidence collected; no unresolved P0 invariant violations.

## Open items

- TODO: reconcile phase naming/numbering and gate text with mirrored `task.md` (see `00-intake/conductor-alignment.md`).
- TODO: add explicit artifact directory map once conductor layout is confirmed.
