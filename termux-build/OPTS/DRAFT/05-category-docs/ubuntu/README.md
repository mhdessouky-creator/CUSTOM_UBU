# Category: Ubuntu Guest (DRAFT)

**Layer:** Ubuntu guest — glibc userspace in PRoot, `aarch64-unknown-linux-gnu`  
**Scope:** Rootfs/bootstrap, bind/storage integration, base hygiene/layout, supervision, XDG/workspace, guest-side toolchains/runtimes.

## Responsibilities

- Provision and maintain Ubuntu rootfs/userspace under PRoot (no real systemd).
- Manage bind mounts, runtime dirs, and service supervision compatible with PRoot/no-root constraints.
- Host Linux-target development toolchains/builds in guest with mold where supported.
- Keep all guest artifacts/env isolated from Termux host Bionic environment.

## Scripts / automation placeholders

| Item | Purpose | Status | Location (planned) |
|---|---|---|---|
| Rootfs bootstrap/install helper | Reproducible Ubuntu rootfs setup | pending (on-device) | TBD per conductor layout |
| Bind/mount profile | Declarative proot bind set and validation | pending | TBD |
| Supervisor/service templates | Foreground/runit-style service definitions | pending | TBD |
| XDG/profile init snippets | Guest-only env activation (mise, cargo, PATH) | pending | TBD |
| Guest build wrapper | Enforce guest triple, mold, sysroot isolation | pending | TBD |

## Manual procedures (DRAFT)

1. Enter guest via approved host launch contract; record proot args/binds.
2. Apply base config (layout, certs, locale, user dirs) with rollback notes.
3. Start services under supervisor only; capture logs and readiness.
4. Run toolchain/build steps with resource-aware settings; audit produced artifacts.

## Dependency ordering notes

- Follows: Termux host readiness and host-side proot launch contract (Phases 1,3-5).
- Precedes: guest toolchain bootstrap/finalization and GPU/runtime integration.
- Key repos: R06 (P0), R07/R10/R11 (P1), R05 boundary considerations, R12-R18/R21-R22 as applicable.
- See: `../../04-dependency-manifests/ubuntu-guest-manifest.md`, `../../04-dependency-manifests/toolchain-manifest.md`, `../../04-dependency-manifests/global-dependency-dag.md`.

## Invariants

- No real systemd, cgroups, namespaces, kernel modules, or Docker daemon.
- No Android-target builds in PRoot.
- No Termux/Bionic libs or loaders used by guest binaries.
- Guest env activation must not modify host shell/runtime.
- GPU/runtime validation results tracked per layer.
