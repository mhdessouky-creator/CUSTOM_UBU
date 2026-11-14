# Phases 1–20 Runbook (CUSTOM_UBU, DRAFT)

**Mapping basis:** tatata.md sections/phases 1–20 as provided in task context. Conductor/`task.md` bodies not mirrored; phase details must be reconciled against `termux-build/conductor/task.md` and KB after intake (see `00-intake/conductor-alignment.md`).  
**Execution context:** on-device (Honor 400 Pro, SD 8 Gen 3/Adreno 750, aarch64, Android, no root). **Not executable in this sandbox.**

## Global invariants (apply to every phase)

- **Layer separation:** Android/Bionic host (`aarch64-linux-android`) vs Ubuntu/glibc guest (`aarch64-unknown-linux-gnu`) binaries/libs/configs/toolchains/artifacts remain strictly separate.
- **Build placement:** Android/Termux packages build on **Termux host** (NDK/LLD). Supported Linux targets build in **Ubuntu guest** with **Mold** where applicable.
- **PRoot limits:** No real systemd, no cgroups/namespace/kernel-module/Docker-daemon assumptions. Services run under custom foreground supervisor/runit tested in PRoot.
- **GPU:** KGSL/Vulkan/ICD/Turnip/Mesa/Zink/OpenCL/EGL validation separated by layer; do not conflate host driver access with guest userspace stack.
- **Resources:** Resource-aware sequencing (jobs, memory, swap/tmp, storage, thermals). Capture logs/evidence for every gate.
- **Evidence-first:** No phase is “done” based on intent; record commands, outputs, paths, and deviations.

## Phase index

| Phase | Title (tatata 1–20 mapping) | Primary layer | Key dependencies |
|---:|---|---|---|
| 1 | Host readiness & baseline (Termux/Android environment) | termux | device access, storage, base pkgs |
| 2 | Workspace/layout & intake alignment | both (repo) | phase 1, mirrors |
| 3 | Termux core package/tool substrate | termux | R01-R04 evidence |
| 4 | termux-exec / shebang & exec correctness | termux | phase 3 |
| 5 | PRoot distro bootstrap (Ubuntu rootfs) | both | R06, phase 3-4 |
| 6 | Bind mounts, storage, proc/dev integration | both | phase 5 |
| 7 | Ubuntu base system hygiene & userland layout | ubuntu | phase 6 |
| 8 | Service supervision model (no systemd) | ubuntu | phase 7 |
| 9 | XDG/runtime dirs & workspace conventions | ubuntu | phase 7-8 |
| 10 | Network, DNS, certs, and fetch policy (on-device) | both | phase 5-7 |
| 11 | Toolchain bootstrap (bootstrap Rust) | ubuntu (+host constraints) | manifests, R09 context |
| 12 | mise installation & activation (Ubuntu) | ubuntu | phase 11, R10/R11 |
| 13 | Final Rust/Cargo toolchain & per-target config | both | phase 11-12, R08/R09 |
| 14 | Linkers/compilers policy (mold/LLD/NDK) & sysroot isolation | both | phase 13, R07/R08 |
| 15 | glibc-packages / cross-boundary ABI considerations | both | R05, phase 14 |
| 16 | Build pipeline hardening & resource controls | both | prior phases |
| 17 | GPU stack bring-up planning & userspace selection (Adreno 750) | both | R17/R18 context, phase 6-9 |
| 18 | GPU/runtime validation separation (Vulkan/ICD/Mesa/Turnip/Zink/EGL) | both | phase 17 |
| 19 | Desktop/runtime & workload integration (optional/reference-driven) | ubuntu | phase 17-18, R12-R18/R21-R22 |
| 20 | End-to-end validation, rollback drills, and sync-back to DRAFT | both | all prior |

> **Note:** Titles/objectives are structured to cover tatata 1–20 comprehensively; exact wording/ordering must be reconciled with mirrored `task.md`.

---

## Phase 1 — Host readiness & baseline (Termux/Android environment)

- **Objective:** Establish a known-good Termux host baseline on-device without root assumptions.
- **Prerequisites:** Android device access, Termux installed, sufficient storage/battery/thermal headroom.
- **Inputs:** Device state, Termux app version, `04-dependency-manifests/termux-host-manifest.md`.
- **Ordered steps:**
  1. Record device/OS/arch/Termux version and available storage/RAM/swap.
  2. Update Termux packages per approved method; install baseline tools required for later phases (git, curl/wget as allowed, tar, proot, build essentials) — on-device only.
  3. Confirm prefix/layout (`$PREFIX`) and shell environment; capture `env` relevant to PATH/LD.
  4. Verify no operations assume root, Docker, or kernel modification.
- **Artifacts/outputs:** Baseline inventory log, package list snapshot, environment capture.
- **Validation gates (on-device):** Core commands run; arch is aarch64; Termux prefix consistent; storage adequate.
- **Rollback/recovery:** Restore from prior Termux backup if available; remove only phase-added packages/configs.
- **Invariant checks:** Host remains Bionic/Android; no guest artifacts installed into `$PREFIX` as glibc replacements.

## Phase 2 — Workspace/layout & intake alignment

- **Objective:** Align repo layout with conductor/KB/`task.md` and establish working directories.
- **Prerequisites:** Phase 1; access to authoritative Drive materials (external to sandbox).
- **Inputs:** `00-intake/*`, mirrored `task.md`/KB/conductor (when available).
- **Ordered steps:**
  1. Mirror Drive bodies into `termux-build/knowledge_base/` and `termux-build/conductor/` per intake checklist.
  2. Complete `conductor-alignment.md` gates/naming/template decisions.
  3. Create/confirm working dirs for sources, builds, logs, and artifacts with per-layer separation.
  4. Record deviations from tatata/`task.md` with rationale.
- **Artifacts/outputs:** Updated intake docs, finalized layout map, sync notes.
- **Validation gates:** Required mirrors present; alignment checklist has no unresolved P0 TODOs.
- **Rollback/recovery:** Revert layout changes that conflict with conductor; keep DRAFT history.
- **Invariant checks:** No mixing of host/guest build trees.

## Phase 3 — Termux core package/tool substrate

- **Objective:** Establish understanding/config for core Termux packaging and runtime components.
- **Prerequisites:** Phases 1-2; evidence from R01-R04 when available.
- **Inputs:** `01-repo-matrix` R01-R04, foundation stubs, `termux-host-manifest.md`.
- **Ordered steps:**
  1. Extract build/patch/prefix conventions from termux-packages (evidence-driven).
  2. Map termux-tools/core behaviors affecting env, paths, and services.
  3. Define host-side script/config conventions for CUSTOM_UBU (no implementation here).
  4. Record Android-on-host build rule implications for later phases.
- **Artifacts/outputs:** Completed/updated R01-R04 analyses, host convention notes.
- **Validation gates:** R01-R04 evidence status advanced or explicitly blocked; no Bionic/glibc mixing proposed.
- **Rollback/recovery:** Revert convention docs to DRAFT if contradicted by evidence.
- **Invariant checks:** Target triple `aarch64-linux-android` for host packages.

## Phase 4 — termux-exec / shebang & exec correctness

- **Objective:** Ensure correct script execution and path/loader behavior on Termux host and across proot boundary.
- **Prerequisites:** Phase 3; R03 evidence.
- **Inputs:** R03 stub, exec/shim findings, `02-analysis-templates/evidence-extraction-checklist.md` §5.
- **Ordered steps:**
  1. Analyze termux-exec behavior, env vars, and edge cases.
  2. Identify shebang/path translation needs for host scripts vs guest scripts.
  3. Define test cases (on-device) for common interpreters and cross-boundary exec.
  4. Document mitigations for PRoot exec quirks.
- **Artifacts/outputs:** Exec/shim decision notes, validation case list.
- **Validation gates:** Shebang/exec behavior understood per layer; risks logged.
- **Rollback/recovery:** Disable/adjust wrappers per evidence; keep prior known-good config.
- **Invariant checks:** No guest loader invoked for host Bionic binaries.

## Phase 5 — PRoot distro bootstrap (Ubuntu rootfs)

- **Objective:** Provision Ubuntu guest rootfs under PRoot with reproducible inputs.
- **Prerequisites:** Phases 1,3,4; R06 evidence; sufficient storage.
- **Inputs:** R06 stub, `ubuntu-guest-manifest.md`.
- **Ordered steps:**
  1. Select Ubuntu rootfs source/version per `task.md`/device constraints (record decision).
  2. Analyze proot-distro install/launch flow, binds, and env handling.
  3. Define guest filesystem layout and ownership model under no-root constraints.
  4. Prepare launch wrapper contract (host->guest) with explicit env separation.
- **Artifacts/outputs:** Rootfs/bootstrap plan, launch contract, R06 analysis updates.
- **Validation gates (on-device):** Guest shell starts; basic userspace commands work; no systemd required.
- **Rollback/recovery:** Remove/recreate rootfs dir; preserve logs and manifests.
- **Invariant checks:** Guest treated as glibc (`aarch64-unknown-linux-gnu`); no host `$PREFIX` pollution.

## Phase 6 — Bind mounts, storage, proc/dev integration

- **Objective:** Provide necessary host/guest integration points without unsafe assumptions.
- **Prerequisites:** Phase 5.
- **Inputs:** R06/R12-R18 findings (as available), PRoot behavior notes.
- **Ordered steps:**
  1. Define required bind mounts (storage, tmp, devpts, proc as needed) and exclusions.
  2. Document `/proc`, `/dev`, `/sys` limitations under PRoot; plan workarounds.
  3. Map Android shared storage access paths and permission behavior.
  4. Validate path translation and symlink behavior for critical dirs.
- **Artifacts/outputs:** Mount/bind table, integration checklist.
- **Validation gates:** Required paths accessible; no reliance on unavailable kernel features.
- **Rollback/recovery:** Revert to minimal bind set; unmount/stop sessions cleanly.
- **Invariant checks:** No cgroups/namespace mounts assumed; SELinux constraints respected.

## Phase 7 — Ubuntu base system hygiene & userland layout

- **Objective:** Stabilize guest userspace layout for builds and runtime.
- **Prerequisites:** Phase 6.
- **Inputs:** `ubuntu-guest-manifest.md`, selected rootfs docs.
- **Ordered steps:**
  1. Define directory layout for sources, build dirs, caches, logs, and runtime data.
  2. Establish user accounts/groups strategy compatible with PRoot.
  3. Configure locale/timezone/certs prerequisites as needed (on-device).
  4. Document package manager state and update policy (resource-aware).
- **Artifacts/outputs:** Guest layout spec, baseline package/profile notes.
- **Validation gates:** Consistent paths; writable work areas; no privilege escalation assumptions.
- **Rollback/recovery:** Snapshot/restore rootfs state if available; revert config files.
- **Invariant checks:** Guest libs/binaries remain glibc-only in guest paths.

## Phase 8 — Service supervision model (no systemd)

- **Objective:** Provide reliable service/process management compatible with PRoot.
- **Prerequisites:** Phase 7.
- **Inputs:** R06/R16/R18 service patterns (evidence pending), supervisor requirements.
- **Ordered steps:**
  1. Select/adapt custom foreground supervisor or runit approach tested in PRoot.
  2. Define service definitions, logging, readiness checks, and restart policy.
  3. Prohibit systemd/cgroup-dependent units; document fallbacks.
  4. Create validation scenarios for long-running and one-shot tasks.
- **Artifacts/outputs:** Supervision design doc, service template(s) (DRAFT).
- **Validation gates:** Services start/stop/restart under supervision; logs captured.
- **Rollback/recovery:** Stop supervised tree; revert to foreground/manual runs.
- **Invariant checks:** No PID 1/systemd assumptions.

## Phase 9 — XDG/runtime dirs & workspace conventions

- **Objective:** Standardize runtime directories and developer workspace ergonomics.
- **Prerequisites:** Phases 7-8.
- **Inputs:** R10/R11/R23/R24 patterns (reference), `ubuntu-guest-manifest.md`.
- **Ordered steps:**
  1. Define `XDG_*`, TMPDIR, cache, and state dirs with correct ownership/permissions.
  2. Align shell init/profile hooks without leaking host/guest env.
  3. Establish workspace naming for projects, toolchains, and artifacts.
  4. Document cleanup/rotation for resource-constrained device.
- **Artifacts/outputs:** XDG/workspace convention doc.
- **Validation gates:** Tools resolve correct dirs; no cross-layer PATH contamination.
- **Rollback/recovery:** Restore prior profile/env files.
- **Invariant checks:** Host and guest env files maintained separately.

## Phase 10 — Network, DNS, certs, and fetch policy (on-device)

- **Objective:** Ensure predictable network behavior for on-device operations within policy.
- **Prerequisites:** Phases 5-7.
- **Inputs:** Device network state, rootfs cert config.
- **Ordered steps:**
  1. Validate DNS/resolv.conf behavior under PRoot and bind strategy.
  2. Verify CA certificates/TLS trust store in guest.
  3. Define fetch policy: prefer pre-mirrored artifacts; avoid network-heavy operations in constrained contexts; document approvals.
  4. Record proxy/offline considerations if applicable.
- **Artifacts/outputs:** Network/certs notes, fetch policy checklist.
- **Validation gates:** Name resolution and TLS verification work for approved endpoints (on-device).
- **Rollback/recovery:** Restore resolv/cert configs; disable failing overrides.
- **Invariant checks:** No assumptions that bypass Android network constraints.

## Phase 11 — Toolchain bootstrap (bootstrap Rust)

- **Objective:** Establish initial Rust toolchain bootstrap path with strict layer separation.
- **Prerequisites:** Phases 7,9,10; `toolchain-manifest.md`; R08/R09 evidence.
- **Inputs:** Toolchain manifest, resource budget.
- **Ordered steps:**
  1. Select bootstrap method/version per `task.md` and evidence (prebuilt vs build-from-source decision recorded).
  2. Place bootstrap artifacts in guest-appropriate, isolated paths.
  3. Configure minimal cargo/rustc env without affecting host Bionic toolchain.
  4. Verify `rustc/cargo` identify correct host triple for guest (`aarch64-unknown-linux-gnu`).
- **Artifacts/outputs:** Bootstrap inventory, env/config snippets (DRAFT), validation logs.
- **Validation gates:** Basic compile/run in guest; correct target triple; no host contamination.
- **Rollback/recovery:** Remove bootstrap dir; revert PATH/env changes.
- **Invariant checks:** No Android-target Rust build performed in PRoot.

## Phase 12 — mise installation & activation (Ubuntu)

- **Objective:** Install/activate mise in Ubuntu guest for tool/version management.
- **Prerequisites:** Phase 11; R10/R11 evidence.
- **Inputs:** `toolchain-manifest.md`, mise configs (if defined).
- **Ordered steps:**
  1. Choose mise install method compatible with guest and offline/mirrored constraints where possible.
  2. Configure activation in guest shell init (scoped, reversible).
  3. Define tool/version pins and directories per XDG/workspace conventions.
  4. Avoid devcontainer/Docker-specific assumptions from reference repos.
- **Artifacts/outputs:** mise config plan, activation notes.
- **Validation gates:** `mise` resolves and manages intended tools in guest; no host env leakage.
- **Rollback/recovery:** Remove activation hooks and mise data dirs.
- **Invariant checks:** mise manages guest/glibc-context tools only unless explicitly separated.

## Phase 13 — Final Rust/Cargo toolchain & per-target config

- **Objective:** Promote from bootstrap to final Rust/Cargo setup with explicit per-target configuration.
- **Prerequisites:** Phases 11-12; R08/R09.
- **Inputs:** `toolchain-manifest.md`, target requirements.
- **Ordered steps:**
  1. Install/select final Rust/Cargo toolchain(s) per manifest.
  2. Define cargo config per target (linker, rustflags, sysroot) for `aarch64-unknown-linux-gnu` and, if needed for host-side workflows, separately managed `aarch64-linux-android`.
  3. Ensure Android/Termux Rust/package builds (if any) are directed to Termux host with NDK/LLD.
  4. Validate cross-compilation boundaries explicitly; document unsupported combinations.
- **Artifacts/outputs:** Per-target cargo/config matrix, toolchain provenance record.
- **Validation gates:** Correct linker invoked per target; test builds produce correct ELF/interpreter per layer.
- **Rollback/recovery:** Pin/revert toolchain version; restore prior cargo config.
- **Invariant checks:** Strict target-triple separation; no mixed loaders/RPATHs.

## Phase 14 — Linkers/compilers policy (mold/LLD/NDK) & sysroot isolation

- **Objective:** Enforce linker/compiler selection and sysroot isolation across layers.
- **Prerequisites:** Phase 13; R07/R08.
- **Inputs:** `toolchain-manifest.md`, build logs.
- **Ordered steps:**
  1. Configure mold for supported Linux targets in Ubuntu guest.
  2. Configure LLD/NDK for Android/Termux targets on Termux host.
  3. Audit RPATH/RUNPATH, interpreter, and `DT_NEEDED` for representative outputs.
  4. Lock sysroot/include/lib search paths per target.
- **Artifacts/outputs:** Linker policy doc, audit checklist/results.
- **Validation gates:** No guest binary links against Bionic/Termux libs and vice versa.
- **Rollback/recovery:** Fallback linker per target as documented; revert flags.
- **Invariant checks:** Mold not used for Android/NDK targets; host/guest sysroots isolated.

## Phase 15 — glibc-packages / cross-boundary ABI considerations

- **Objective:** Resolve/contain ABI boundary issues when glibc-oriented components interact with Termux ecosystem.
- **Prerequisites:** Phases 5,13,14; R05 evidence.
- **Inputs:** R05 stub, ABI findings.
- **Ordered steps:**
  1. Extract relevant patterns from termux/glibc-packages with evidence.
  2. Identify safe interfaces between host and guest (commands, sockets, files) vs unsafe binary mixing.
  3. Document forbidden combinations and required wrappers/serialization boundaries.
  4. Update manifests/matrix decisions accordingly.
- **Artifacts/outputs:** ABI boundary guidance, updated R05 analysis.
- **Validation gates:** No mixed-ABI linkage in planned flows; interface contracts explicit.
- **Rollback/recovery:** Remove unsafe integrations; isolate components per layer.
- **Invariant checks:** Bionic and glibc runtime artifacts never co-loaded.

## Phase 16 — Build pipeline hardening & resource controls

- **Objective:** Make builds reproducible and resource-aware on-device.
- **Prerequisites:** Phases 11-15.
- **Inputs:** Prior build logs, device resource profile.
- **Ordered steps:**
  1. Set parallelism, memory, tmp/swap, and cache policies for host and guest builds.
  2. Standardize logging, artifact staging, and cleanup.
  3. Define retry/timeout guidance (respecting environment command limits where applicable).
  4. Identify heavy commands to scope or avoid (repo-wide lint/typecheck/typegen) per policy.
- **Artifacts/outputs:** Build/runbook addendum, resource policy.
- **Validation gates:** Representative builds complete within constraints; logs sufficient for diagnosis.
- **Rollback/recovery:** Reduce concurrency; clear caches/tmp; restore prior settings.
- **Invariant checks:** Build placement rules still enforced under automation.

## Phase 17 — GPU stack bring-up planning & userspace selection (Adreno 750)

- **Objective:** Plan GPU userspace stack with clear host/guest separation for Adreno 750/KGSL.
- **Prerequisites:** Phases 6,7,9; R17/R18 (and related) evidence.
- **Inputs:** GPU-related matrix rows, device driver availability (on-device observation).
- **Ordered steps:**
  1. Inventory available KGSL/device nodes and host driver capabilities (on-device).
  2. Evaluate Mesa/Turnip/Zink/Vulkan/OpenCL/EGL options per layer with evidence.
  3. Define ICD/loader manifest/env strategy and file locations per layer.
  4. Document display/compositor/surface options (X11/Wayland/VNC) and PRoot constraints.
- **Artifacts/outputs:** GPU plan, component selection matrix (DRAFT).
- **Validation gates:** Selected components have explicit layer ownership and dependency mapping.
- **Rollback/recovery:** Revert to software rendering/minimal config.
- **Invariant checks:** No assumption that guest can access unavailable kernel/driver interfaces.

## Phase 18 — GPU/runtime validation separation (Vulkan/ICD/Mesa/Turnip/Zink/EGL)

- **Objective:** Validate GPU/runtime components in isolation per layer.
- **Prerequisites:** Phase 17.
- **Inputs:** Validation probes/tools available on-device, GPU plan.
- **Ordered steps:**
  1. Run host-side and guest-side capability probes separately (as available).
  2. Verify ICD discovery, loader behavior, and env correctness per layer.
  3. Test minimal Vulkan/EGL/GL paths; capture renderer/driver strings and failures.
  4. Record performance/thermal observations and constraints.
- **Artifacts/outputs:** Layered validation report, known issues list.
- **Validation gates:** Each tested path has pass/fail evidence and layer attribution.
- **Rollback/recovery:** Disable problematic ICDs/env overrides; fall back to stable renderer.
- **Invariant checks:** Results not generalized across host/guest boundaries.

## Phase 19 — Desktop/runtime & workload integration (optional/reference-driven)

- **Objective:** Integrate optional desktop/runtime or reference workloads based on validated components.
- **Prerequisites:** Phases 8,17,18 (as applicable); R12-R18/R21/R22 evidence.
- **Inputs:** Selected runtime/desktop components, supervision model.
- **Ordered steps:**
  1. Choose minimal workload(s) (e.g. reference build/runtime) aligned with validated stack.
  2. Run under foreground supervision; avoid daemon/systemd dependencies.
  3. Measure resource impact and stability on-device.
  4. Document user-facing startup/stop procedures.
- **Artifacts/outputs:** Integration notes, workload validation records.
- **Validation gates:** Workload runs within resource limits; clean shutdown; logs available.
- **Rollback/recovery:** Stop services, remove optional packages/configs.
- **Invariant checks:** Optional components do not weaken layer separation or security posture.

## Phase 20 — End-to-end validation, rollback drills, and sync-back to DRAFT

- **Objective:** Confirm Milestone A->operational readiness artifacts and close the loop to Drive.
- **Prerequisites:** All prior required phases; updated analyses.
- **Inputs:** All DRAFT docs, validation logs, `reports/sync-manifest.md`.
- **Ordered steps:**
  1. Execute end-to-end checklist across host bootstrap, guest boot, toolchains, and selected runtime/GPU paths (on-device).
  2. Perform rollback/recovery drills for critical phases (rootfs, toolchain, supervision, GPU config).
  3. Update matrix/stubs/manifests/runbooks with evidence, decisions, and deviations.
  4. Sync `termux-build/OPTS/DRAFT/` to Drive authoritative `DRAFT/`; record date/revision and remaining blockers.
- **Artifacts/outputs:** Final Milestone A validation summary, updated sync manifest, change log.
- **Validation gates:** No unresolved P0 invariant violations; blockers explicitly documented.
- **Rollback/recovery:** Restore last known-good snapshots/configs per phase notes.
- **Invariant checks:** Final artifacts reflect actual evidence status; no fabricated validation claims.
