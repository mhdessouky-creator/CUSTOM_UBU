# Repo Analysis: Nwokike/proot-distro (R06, DRAFT)

> Foundation-batch stub instantiated from `../02-analysis-templates/repo-analysis-template.md`. **Evidence not collected in this environment.**

## Metadata

- **Repo ID:** `R06`
- **Name:** proot-distro
- **URL:** https://github.com/Nwokike/proot-distro
- **Category:** proot distro mgmt
- **Priority:** P0
- **Target layer:** both
- **Upstream license (if known):** `pending`
- **Pinned ref/commit analyzed:** `pending-unfetched`
- **Analysis date / analyst:** 2026-11-14 / bootstrap (no source inspection)
- **Evidence status:** `pending-unfetched`

## Ubuntu-in-Termux / PRoot problem(s) addressed

- Problem statement: `pending` — expected relevance: Ubuntu/rootfs install, bind mounts, user setup, proot launch scripts, guest bootstrap under no-root Android.
- Scope/limitations in upstream approach: `pending`
- Relevance to CUSTOM_UBU phases (1–20): 5, 6, 7, 8 (primary); influences 9, 10, 17+.

## Non-default patches (to mine)

| Patch/file area | Purpose | Layer | Target triple impact | Risk | Evidence (path/commit/link) | Status |
|---|---|---|---|---|---|---|
| `pending` (distro plugins, launch scripts) |  | both | N/A (scripts/config) but affects runtime |  |  | pending-unfetched |

## Environment variables

| Variable | Set/consumed where | Purpose | Layer | Interaction risks | Evidence | Status |
|---|---|---|---|---|---|---|
| `pending` (PROOT_*, PATH, HOME, TMPDIR, etc.) |  |  | both | Host/guest env leakage; LD/path collisions |  | pending-unfetched |

## Syscall / exec / shebang shims

- Proot invocation patterns, command wrappers: `pending`
- Shebang/path translation behavior in guest: `pending`
- Interaction with termux-exec (R03): `pending`
- PRoot-specific constraints: `pending`
- Evidence: `pending-unfetched`

## ABI fixes and architecture handling

- aarch64/rootfs selection and compatibility: `pending`
- Bionic host / glibc guest boundary enforcement: `pending`
- Evidence: `pending-unfetched`

## Linker / RPATH / loader handling

- Primarily runtime/launch; any packaged binaries must be layer-correct: `pending`
- Evidence: `pending-unfetched`

## Permission / SELinux / proc / dev / storage hacks

- Bind mounts (`/dev`, `/proc`, `/sys`, `/storage`, `/sdcard`, tmp): `pending`
- UID/GID/user mapping and ownership fixups: `pending`
- SELinux/no-root constraints: `pending`
- Fake/proc entries or compatibility workarounds: `pending`
- Evidence: `pending-unfetched`

## GPU (KGSL / Vulkan / ICD / Turnip / Mesa / Zink / OpenCL / EGL) — if applicable

- Device node/bind or env hints for GPU access: `pending`
- Evidence: `pending-unfetched`

## Service / init workarounds

- Startup/login scripts, daemon handling, systemd absence: `pending`
- Mapping to foreground supervisor/runit in PRoot: `pending`
- Evidence: `pending-unfetched`

## Build pipeline / customizations

- Rootfs fetch/extract/install flow (normally networked): `pending` — requires mirrored/offline adaptation plan.
- Distro plugin structure and customization points: `pending`
- Evidence: `pending-unfetched`

## Source evidence log

| Claim / finding | Evidence type (file/path/commit/link/command output) | Location/ref | Extracted by | Date | Confidence |
|---|---|---|---|---|---|
| _none yet_ |  |  |  |  |  |

## Applicability (termux / ubuntu / both)

- **Termux host:** defer-TBD (launcher/orchestration side)
- **Ubuntu guest:** defer-TBD (rootfs/userspace/bootstrap target)
- **Cross-layer interfaces:** defer-TBD (critical contract)

## Risks and limitations

- PRoot limitations (no real root/namespaces/cgroups/systemd) must be respected.
- Bind-mount/env choices can leak state or break isolation.
- `pending-unfetched`

## Decision (adopt / adapt / reject / defer)

- **Decision:** `defer-TBD`
- **Rationale:** No source evidence inspected in sandbox.
- **Prerequisites before adoption:** Review launch scripts, bind tables, distro plugins, and env handling; validate on-device.
- **Conflicts with other repos/decisions:** R12-R18 installers/runtime stacks may overlap; choose best-combination with evidence.

## Dependency ordering impact

- Must precede: Phases 6-9 guest operational readiness.
- Must follow: Phases 1,3,4 host readiness.
- Manifest updates required: `ubuntu-guest-manifest.md`, `global-dependency-dag.md`, cross-category docs.

## On-device validation items (not executed here)

| ID | Validation step | Layer | Expected signal | Failure signal | Rollback |
|---|---|---|---|---|---|
| V1 | Install/provision Ubuntu rootfs per approved method | both | Rootfs present, login succeeds | Extract/install/mount errors | Remove rootfs, retry with adjusted config |
| V2 | Verify bind mounts and storage access | both | Required paths accessible | Missing nodes/permission failures | Revert to minimal bind set |
| V3 | Confirm no systemd dependency for basic operation | ubuntu | Shell/services usable without systemd | Hangs/errors expecting systemd/cgroups | Use supervisor/foreground alternatives |

## Open questions / TODO

- [ ] Extract exact proot args, bind defaults, and distro plugin for Ubuntu.
- [ ] Identify offline/mirrored rootfs acquisition path compliant with environment policy.
- [ ] Compare with R12-R15 for best bootstrap approach.
