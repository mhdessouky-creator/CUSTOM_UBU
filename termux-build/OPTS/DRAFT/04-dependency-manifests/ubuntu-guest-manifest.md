# Ubuntu Guest Manifest (DRAFT)

**Target layer:** Ubuntu guest userspace in PRoot (glibc, `aarch64-unknown-linux-gnu`)  
**Host boundary:** Runs under Termux host (Bionic, `aarch64-linux-android`), Android no-root, no real namespaces/cgroups/systemd.  
**Rule:** Keep guest binaries/libs/configs/toolchains/artifacts strictly separated from Termux host. Linux-target builds in guest may use mold where supported.

## Guest bootstrap and runtime ordering

| Order | Component / area | Repo ref | Purpose | Prerequisites | Outputs/artifacts | Validation (on-device) | Status |
|---:|---|---|---|---|---|---|---|
| G1 | Ubuntu rootfs provisioning | R06, R12-R15 (patterns) | Obtain/install base Ubuntu rootfs compatible with aarch64 and PRoot | Termux host ready; storage; selected rootfs source (evidence/decision) | Rootfs tree, install log | Guest shell enters; `/etc/os-release` as expected | pending-unfetched |
| G2 | PRoot bind mounts & integration | R06, R12-R18 (patterns) | Map storage, tmp, devpts, proc/dev/sys as available/needed | G1; host launch contract | Bind/mount table, launch wrapper config | Required paths readable/writable as designed; no kernel-feature assumptions | pending-unfetched |
| G3 | Base system hygiene & layout | — (rootfs + evidence) | Users/groups, locale, certs, package manager baseline, directory layout | G2 | Layout spec, baseline package snapshot | Basic package/query commands work; writable work dirs | pending |
| G4 | XDG/workspace/runtime dirs | R10/R11/R23/R24 (ref) | Standardize `XDG_*`, cache/tmp/state, project/build/log locations | G3 | Env/profile snippets (guest-only), workspace tree | Tools resolve intended dirs; no host env leakage | pending |
| G5 | Service supervision (no systemd) | R06/R16/R18 (patterns) | Foreground supervisor/runit-style process management tested in PRoot | G3-G4 | Supervisor config/templates, service defs, logs | Services start/stop/restart; readiness/logging verified | pending-unfetched |
| G6 | Network/DNS/certs runtime | — | Predictable resolver/TLS behavior in guest | G2-G3 | `resolv.conf` strategy, CA trust state | Name resolution and TLS checks pass for approved endpoints (on-device) | pending |
| G7 | Toolchain/runtime consumers | R07-R11, R17/R18/R21/R22 | Hosts mise/Rust/Cargo/build tools and optional runtimes | G4-G6 + manifests | Toolchain installs/configs in guest paths only | See toolchain/GPU runbook gates | pending |

## Directory/layout policy (guest, proposed)

| Path class | Purpose | Separation rule |
|---|---|---|
| Rootfs system dirs (`/usr`, `/lib`, `/etc`, etc.) | Guest OS and packages | glibc-only; do not bind-replace with Termux `$PREFIX` libs. |
| Workspace/build dirs (TBD canonical path) | Sources, build trees, caches, logs | Must be distinct from host build trees; record in layout spec. |
| Runtime/state dirs (XDG/TMP) | Tool/runtime state | Guest-scoped env vars only. |
| Bind-mounted shared storage | User files/artifact exchange | Treat as boundary; avoid executing ambiguous mixed-ABI binaries from shared paths. |

## Service supervision requirements

- **Allowed:** custom foreground supervisor, runit-style supervision, or equivalent approach verified in PRoot.
- **Not allowed:** real systemd as PID/init, reliance on cgroups, privileged namespaces, kernel modules, Docker daemon.
- Service definitions must include: command, working dir, env (guest-only), stdout/stderr logging, restart policy, and dependency/order notes.
- All long-running components (dev servers, daemons, UI helpers) must be manageable without systemd.

## PRoot/proc/dev constraints to document during validation

- `/proc`, `/dev`, `/sys` behavior may differ from full Linux; do not assume full feature parity.
- `/dev/shm`, pts, IPC, and networking features depend on PRoot/bind configuration and Android kernel behavior.
- Record exact proot arguments/binds and observed limitations in R06/foundation analysis.

## Risks / constraints

- No-root and SELinux may limit mounts, permissions, and device access.
- Resource constraints on-device (CPU/RAM/storage/thermals) affect package installs and builds.
- GUI/GPU paths are sensitive to driver/userspace boundary; validate separately (Phases 17-18).
- Rootfs updates/upgrades can drift; snapshot or document state before major changes.

## On-device validation checklist (deferred)

- [ ] Rootfs boots to shell reliably via defined launch path.
- [ ] Bind mounts match plan; critical paths accessible.
- [ ] Base packages/certs/locale functional.
- [ ] Supervisor starts/stops representative services without systemd.
- [ ] XDG/workspace dirs isolated and writable.
- [ ] No Termux/Bionic libs present in guest load paths for guest binaries.
