# Termux Host Manifest (DRAFT)

**Target layer:** Termux host (Android app UID, Bionic, `aarch64-linux-android`)  
**Device:** Honor 400 Pro (SD 8 Gen 3 / Adreno 750), Android, no root  
**Rule:** Build Android/Termux packages on Termux host (NDK/LLD), **not** inside PRoot. Keep host artifacts strictly separated from Ubuntu/glibc guest artifacts.

## Core package/tooling ordering

| Order | Component / area | Repo ref | Purpose | Prerequisites | Outputs/artifacts | Validation (on-device) | Status |
|---:|---|---|---|---|---|---|---|
| H1 | Termux base environment | — | Stable shell, prefix, pkg manager, storage access | Termux app installed; storage permission as needed | Baseline env snapshot, pkg list | `uname -m` aarch64; `$PREFIX` correct; basic cmds work | pending |
| H2 | termux-packages model & patching conventions | R01 | Packaging/build recipes, NDK/cross patterns, patch workflow | H1; repo evidence | Documented conventions, selected patches/scripts (evidence-backed) | Recipe/patch applicability reviewed per target | pending-unfetched |
| H3 | termux-tools | R02 | Host wrappers/env/path helpers | H2 conventions | Tool configs/wrappers as needed | Wrappers resolve correct host paths | pending-unfetched |
| H4 | termux-exec-package behavior | R03 | Shebang/exec interception and path translation correctness | H2-H3 | Exec/shim configuration notes, compatibility tests | Scripts/interpreters execute with correct loader/paths | pending-unfetched |
| H5 | termux-core-package substrate | R04 | Core runtime primitives/services baseline | H2-H4 | Core runtime notes/config | Core host workflows stable | pending-unfetched |
| H6 | PRoot/launcher integration boundary | R06 (host side) | Host-side entrypoints, bind/proot invocation contract to guest | H1-H5 | Launch scripts/contract (separate from guest internals) | Guest starts; host env not polluted | pending-unfetched |
| H7 | Host build infra for Android targets (if required) | R01/R08/R09 context | NDK/LLD toolchain placement and usage for `aarch64-linux-android` | H1-H5, NDK availability | Per-target build config, sysroot isolation | Produced ELF uses Android-compatible loader/ABI | pending |
| H8 | Host services/utilities (Termux-side) | R02/R04 context | Minimal host services needed for workflow (non-systemd guest assumptions irrelevant) | H1-H6 | Service/run scripts, logs | Start/stop/status verifiable on-device | pending |

## Environment and path separation (host)

| Item | Required value/policy | Notes |
|---|---|---|
| Prefix | Termux `$PREFIX` (Bionic) only for host tools/libs | Never install guest glibc libs into `$PREFIX` as replacements. |
| Target triple (host builds) | `aarch64-linux-android` | Enforce in build scripts/cargo/cmake/meson configs as applicable. |
| Linker (Android targets) | LLD/NDK toolchain | Do not use mold for Android/NDK targets. |
| Dynamic loader | Android/Termux loader for host binaries | Do not point host binaries at guest glibc loader. |
| PATH/LD vars | Host-scoped; avoid exporting guest paths | Audit shell init and wrappers. |
| Storage bridge | Use Android/Termux-approved storage paths/binds | Respect scoped storage and permissions (no root). |

## Patches / customizations to evaluate (evidence-gated)

- R01: packaging patches, cross flags, prefix assumptions — **pending-unfetched**.
- R02: path/env wrappers — **pending-unfetched**.
- R03: exec/shebang interception edge cases, proot interactions — **pending-unfetched**.
- R04: core runtime behaviors impacting services/proc/dev — **pending-unfetched**.
- R06: host launch/proot argument and bind patterns — **pending-unfetched**.

## Risks / constraints

- No root: cannot rely on mount namespaces/cgroups/system-level changes.
- SELinux and app sandbox may restrict proc/dev/bind behaviors; validate on-device.
- Resource limits: prefer scoped builds/tests; avoid repo-wide heavy commands on device.
- Any host-side change affecting exec/loader must be regression-tested with guest launch.

## On-device validation checklist (deferred)

- [ ] Termux packages updated and baseline recorded.
- [ ] Exec/shebang behavior verified for representative scripts.
- [ ] PRoot/guest launch works from host without env leakage.
- [ ] Android-target build (if performed) uses NDK/LLD and correct ABI.
- [ ] Logs/artifacts stored in host-designated paths only.
