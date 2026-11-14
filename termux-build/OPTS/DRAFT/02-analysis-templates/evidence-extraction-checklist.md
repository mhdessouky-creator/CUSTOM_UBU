# Evidence Extraction Checklist (DRAFT)

Use this checklist when mining each canonical repo. Record findings in the per-repo analysis (template in this directory) with `file/path`, commit hash, or URL and access date. If a source cannot be inspected, mark the item `pending-unfetched` — **do not infer or invent**.

## 1. Provenance and scope

- [ ] Record canonical repo URL, default branch, license, and exact commit/tag analyzed.
- [ ] Capture README/docs summary relevant to Ubuntu-in-Termux/PRoot/Termux packaging/toolchain/GPU (quote paths/sections).
- [ ] Identify components in scope (scripts, patches, build recipes, binaries, configs) and out of scope.
- [ ] Note forks/duplicates already represented in matrix; avoid duplicate evidence claims.

## 2. Ubuntu-in-Termux / PRoot problems addressed

- [ ] What host/guest boundary problem is solved? (rootfs bootstrap, bind mounts, UID/GID mapping, path translation, etc.)
- [ ] Which assumptions require root, real namespaces, cgroups, kernel modules, Docker daemon, or systemd? Flag incompatibilities with PRoot/no-root.
- [ ] What storage/proc/dev behaviors are relied upon or faked?

## 3. Non-default patches

- [ ] Enumerate patch files/diff hunks and their targets.
- [ ] For each patch: purpose, affected layer/triple, upstream status (if stated), and regression risk.
- [ ] Distinguish Android/Bionic-target patches from Linux/glibc-target patches.

## 4. Environment variables

- [ ] List exported/required env vars (PATH, PREFIX, HOME, LD_*, PROOT_*, TMPDIR, XDG_*, VK_ICD_*, MESA_*, compiler/linker vars).
- [ ] Note default values, override points, and cross-layer collision risks.
- [ ] Capture shell init files or wrappers that set them.

## 5. Syscall / exec / shebang shims

- [ ] Identify exec interception (e.g. termux-exec), shebang fixups, path rewriting, binfmt handling.
- [ ] Document argument/env rewriting behavior and edge cases (spaces, symlinks, relative paths).
- [ ] Note proot-specific invocation patterns and known breakages.

## 6. ABI fixes

- [ ] Identify target triple handling and ABI-specific guards.
- [ ] Record fixes for Bionic vs glibc differences (TLS, symbol versions, libc calls, dynamic linking).
- [ ] Note arm64/aarch64 assumptions relevant to SD 8 Gen 3; flag incompatible hardening/features.

## 7. Linker / RPATH / loader handling

- [ ] Identify linker selection (LLD/NDK, mold, ld.bfd/lld) per target and build phase.
- [ ] Extract RPATH/RUNPATH/$ORIGIN policies and runtime loader paths.
- [ ] Verify sysroot/prefix isolation; detect hardcoded paths that cross host/guest boundaries.
- [ ] Note pkg-config/cmake/meson/cargo linker flags.

## 8. Permission / SELinux / proc / dev / storage

- [ ] Document required Android permissions and storage paths; scoped-storage behavior.
- [ ] Record SELinux-dependent behavior and no-root-safe alternatives.
- [ ] Identify `/proc`, `/dev`, `/sys`, `/dev/shm`, pts, tun, binder, ashmem assumptions.
- [ ] Extract bind-mount tables and ownership/permission fixups.

## 9. GPU (KGSL / Vulkan / ICD / Turnip / Mesa / Zink / OpenCL / EGL)

- [ ] Identify Adreno/KGSL assumptions and required Android driver interfaces.
- [ ] Locate Vulkan ICD loader/manifest setup and env vars; separate host vs guest userspace.
- [ ] Record Mesa/Turnip/Zink build flags, runtime selection, and fallback paths.
- [ ] Note OpenCL/EGL/GL/GLES/Wayland/X11 integration points and package deps.
- [ ] Define on-device validation probes (informational here; not executed).

## 10. Service / init workarounds

- [ ] Identify init system expectations (systemd units, rc scripts, runit, supervisord, ad-hoc).
- [ ] Extract what must run in foreground under PRoot; identify daemonization/cgroup dependencies.
- [ ] Record logging, pidfile, readiness/healthcheck, and restart behavior.
- [ ] Map to custom foreground supervisor/runit-tested-in-PRoot approach.

## 11. Build pipeline / customizations

- [ ] Document build entrypoints, scripts, and required tool versions.
- [ ] Record bootstrap ordering, staged artifacts, and install destinations.
- [ ] Confirm where builds must run: Termux host for Android/Termux (`aarch64-linux-android`, NDK/LLD) vs Ubuntu guest for Linux (`aarch64-unknown-linux-gnu`, mold where supported).
- [ ] Capture resource-sensitive options (parallel jobs, LTO, swap/tmp usage) relevant on-device.

## 12. Decision support

- [ ] Classify each mined artifact: `adopt`, `adapt`, `reject`, or `defer-TBD` with rationale.
- [ ] List conflicts/overlaps with other matrix repos and dependency ordering impact.
- [ ] State required on-device validation before promotion from DRAFT.
- [ ] Summarize unknowns and follow-up evidence requests.

## Evidence quality rules

- Prefer primary evidence (source file, build script, commit diff) over README claims.
- Record exact references: `<repo>@<commit>:<path>#Lx-Ly` or URL + snapshot note.
- Mark confidence: high (direct source), medium (doc-only), low (inferred) — avoid low-confidence claims in decisions.
- Never promote pending/inferred items to `sufficient` without citation.
- Keep Bionic/glibc and host/guest observations separated in notes.
