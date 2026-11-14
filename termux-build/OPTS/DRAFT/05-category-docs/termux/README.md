# Category: Termux Host (DRAFT)

**Layer:** Termux host — Android app UID, Bionic runtime, `aarch64-linux-android`  
**Scope:** Host-side environment, packaging/build conventions, exec/shebang behavior, and host-side integration points for PRoot/Ubuntu guest.

## Responsibilities

- Maintain Termux prefix/environment integrity and host tool availability.
- Build Android/Termux packages on host using NDK/LLD (never in PRoot).
- Provide correct exec/shebang/path behavior for host scripts and host-invoked tools.
- Own host-side launch/bind contract into Ubuntu guest without leaking guest glibc env into host.

## Scripts / automation placeholders

| Item | Purpose | Status | Location (planned) |
|---|---|---|---|
| Host bootstrap checklist | Install/verify baseline Termux packages and capture env | pending (on-device) | TBD per conductor layout |
| Exec/shim validation script | Verify shebang/interpreter/path behavior | pending | TBD |
| Guest launch wrapper (host side) | Start PRoot Ubuntu with approved binds/env | pending | TBD |
| Android-target build wrapper | Enforce NDK/LLD, triple, sysroot isolation | pending | TBD |

## Manual procedures (DRAFT)

1. Record baseline: device, Termux version, `$PREFIX`, arch, storage.
2. Apply host config changes incrementally; capture before/after evidence.
3. Validate host operations independently before testing guest integration.
4. For any Android/Termux build, confirm target triple and linker/loader in outputs.

## Dependency ordering notes

- Follows: device/Termux installation readiness.
- Precedes: PRoot guest bootstrap (R06 host side), Android-target build flows.
- Key repos: R01-R04 (P0), host aspects of R05/R06/R08/R09 as applicable.
- See: `../../04-dependency-manifests/termux-host-manifest.md`, `../../04-dependency-manifests/global-dependency-dag.md`.

## Invariants

- No guest glibc libs/loaders in host paths.
- No Android-target builds in PRoot.
- No root/cgroup/namespace assumptions required.
- Changes to exec/loader behavior require regression checks across host and guest entrypoints.
