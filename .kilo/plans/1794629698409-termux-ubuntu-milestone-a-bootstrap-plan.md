# CUSTOM_UBU Milestone A Bootstrap Plan (DRAFT)

**Plan ID:** 1794629698409-termux-ubuntu-milestone-a-bootstrap-plan  
**Scope:** Milestone A bootstrap artifacts (analysis/synthesis scaffolding), not wholesale integration  
**Status:** DRAFT — intake incomplete (Drive bodies not mirrored in-repo)

## Goal

Bootstrap a traceable, in-repo artifact set under `termux-build/OPTS/DRAFT/` for CUSTOM_UBU: a Termux-host + Ubuntu-PRoot guest development environment targeting Honor 400 Pro (Snapdragon 8 Gen 3 / Adreno 750, aarch64, Android, no root). Milestone A delivers intake records, a deduplicated repo matrix, reusable per-repo analysis/evidence templates, phases 1–20 runbooks, dependency manifests, category docs, and foundation-batch deep-analysis prep — structured to align with conductor workflow/KB/`task.md` once mirrored.

## Authoritative inputs/sources

| Source | Location / ref | Status in this environment |
|---|---|---|
| Task brief (tatata.md) | `/tmp/attachments/workspace_13e536b7-26f3-4c94-9963-16cf40320f91/46c22935-fa46-472c-991b-483b96a03496/3fdd4c66-0906-4522-a406-c5b80c45d957/93f3af94-6003-4ad9-b43e-eaf0be94fbd6.md` (user-specified path) | **Not readable** from this sandbox (path not found at authoring time). Artifacts derived from the provided task context and Drive inventory stated in-session; all repo evidence marked pending until repos/brief are directly inspected. |
| Authoritative ops Drive folder | https://drive.google.com/drive/folders/1eiNS5oHkLiyuufAo4YH83SL9BodL_yta | **Authoritative (user-designated).** Contents not accessible (no Drive read/write in sandbox). Top-level observed via web fetch: `agents/`, `commands/`, `DRAFT/` (upload target), `knowledge-base/`, `OPTS/`, `skills/`, `templates/`, `composio-mcp` (4 KB), `README.md` (5 KB, shared 8 Nov), `task.md` (33 KB, shared 13 Nov). |
| Prior KB Drive ref (tatata.md) | https://drive.google.com/drive/folders/1yEsEzqNjl1WDpAt8ou7_rTiFg6Kkc4_A | **Prior/reference only.** Record retained; `1eiNS5o...` is authoritative for ops/DRAFT uploads. |
| In-repo intake targets | `termux-build/knowledge_base/`, `termux-build/conductor/` | Created as `.gitkeep` placeholders; awaiting mirror of KB/conductor/`task.md` bodies. |
| External source repos (25 canonical) | Listed in `termux-build/OPTS/DRAFT/01-repo-matrix/repo-matrix.md` | **Not fetched/analyzed** (no network-heavy clone/fetch). Evidence status `pending-unmirrored/unfetched`. |

**Intake gap:** Conductor workflow, KB, and `task.md` bodies are not mirrored in-repo. `termux-build/OPTS/DRAFT/` must be synced by user to Drive `DRAFT/` under authoritative folder; mirror upstream Drive bodies into in-repo targets before deep analysis.

## Constraints/invariants

- **Environment separation (strict):** Keep Android/Bionic vs Ubuntu/glibc binaries, libs, configs, toolchains, and artifacts strictly separate (`aarch64-linux-android` vs `aarch64-unknown-linux-gnu`). No mixing of loaders, RPATHs, sysroots, or pkg artifacts across layers.
- **Build placement:** Build Android/Termux packages on Termux host (not inside PRoot). Use Mold for supported Linux targets in Ubuntu guest; use LLD/NDK for Android/Termux targets.
- **PRoot limits:** No real systemd in PRoot. Use custom foreground supervisor/runit-style supervision tested in PRoot. No cgroups, namespace, kernel-module, or Docker-daemon assumptions.
- **GPU/runtime:** Adreno 750/KGSL considerations require explicit GPU validation separation (Vulkan/ICD/Turnip/Mesa/Zink/OpenCL/EGL as applicable); do not assume host GPU stack availability in guest.
- **Operations:** Resource-aware, on-device validation required but **not executable in this environment**. No wholesale repo integration; analysis/synthesis and best-combination fixes only.
- **Evidence hygiene:** Do not invent evidence from unread repos/files. Mark unknowns and `evidence_status` explicitly; cite file/path/commit/link when available.
- **Sandbox limits:** No Drive read/write, no network-heavy external fetches, no Google Drive access from this environment.

## Boundaries/data flow

```
[Android kernel/userspace, no root]
        |
   Termux app UID / Bionic host  (aarch64-linux-android)
   - termux-packages/tools/exec/core, Android-target builds (NDK/LLD)
   - proot-distro / launcher / bindings / storage bridge
        |
   PRoot boundary (simulated root, no real namespaces/cgroups/systemd)
        |
   Ubuntu guest / glibc userspace  (aarch64-unknown-linux-gnu)
   - Linux-target builds (mold where supported), mise/rust/cargo toolchains
   - XDG/workspace layout, foreground supervisor/runit, services
        |
   Artifacts staged per-layer -> termux-build/OPTS/DRAFT analysis -> user sync to Drive DRAFT/
```

Data/evidence flows: Drive ops (authoritative) -> in-repo mirror (`knowledge_base/`, `conductor/`, `OPTS/`) -> per-repo evidence extraction -> phase runbooks/manifests -> on-device validation (external/manual) -> feedback into DRAFT.

## Ordered Milestone A tasks

1. **Intake/alignment (bootstrap, this pass):** Record Drive inventory and authority; capture intake gaps; create `conductor-alignment.md` checklist tied to `task.md`/conductor dirs; establish in-repo mirror targets.
2. **Scaffold:** Create `termux-build/OPTS/DRAFT/` structure, category skeletons, and intake/support directories (`knowledge_base/.gitkeep`, `conductor/.gitkeep`).
3. **Deduped/prioritized repo matrix:** Produce canonical 25-repo matrix with P0/P1/P1-P2/P2-P3 priorities, target layers, problems, artifacts-to-mine, deps/prereqs, evidence/decision fields.
4. **Per-repo analysis template + evidence checklist:** Publish reusable template covering proot/Ubuntu-in-Termux problems, patches, env vars, shims, ABI/linker/RPATH/loader, permissions/SELinux/proc/dev/storage, GPU, service/init, build pipeline, evidence, applicability, risks, decisions, validation.
5. **Phase 1–20 runbooks & dependency manifests:** Map tatata phases 1–20 to actionable runbooks with objectives/prereqs/steps/outputs/gates/rollback/invariants; produce global DAG and per-domain manifests (termux-host, ubuntu-guest, toolchain) enforcing separation.
6. **Foundation-batch deep-analysis prep:** Instantiate per-repo stubs from template for P0/P1 foundation set (10 repos), marked evidence pending; define extraction/validation focus per repo.
7. **Sync/report:** Emit `reports/sync-manifest.md` listing upload set and blockers (KB/conductor/task.md bodies, repo evidence).
8. **Post-intake (blocked):** Mirror `task.md`, KB, conductor workflow/agents/commands/skills/templates into repo; reconcile matrix/runbooks/templates; perform deep evidence extraction per foundation batch; record adopt/adapt/reject decisions with citations.

## Failure modes

| Failure mode | Impact | Mitigation / gate |
|---|---|---|
| Drive bodies not mirrored / `task.md` unreadable | Misalignment with conductor gates/naming/templates | Keep artifacts DRAFT; `00-intake/conductor-alignment.md` TODOs; block decisions on missing authoritative text. |
| Brief attachment path unreadable in sandbox | Possible omission vs tatata.md | Mark provenance gap; treat in-session brief as operative; reconcile on mirror. |
| Evidence invented from unfetched repos | Invalid adopt/adapt decisions | Enforce `evidence_status=pending` until file/commit/link cited. |
| Bionic/glibc or host/guest artifact mixing | Runtime/ABI breakage, hard-to-diagnose faults | Manifests/runbooks require separate sysroots, loaders, RPATH policies, and validation per layer. |
| Real systemd/cgroups/kernel assumptions in PRoot | Service/startup failures | Runbooks mandate foreground supervisor/runit tested in PRoot; explicit non-goals. |
| Android targets built in PRoot | Toolchain/ABI mismatch | Runbook invariant: Android/Termux builds on Termux host (NDK/LLD). |
| Resource exhaustion on device | Build/install failures, thermal/throttle | Runbooks require resource-aware sequencing, swap/tmp controls, and bounded parallelism (on-device). |
| GPU stack conflation (host vs guest KGSL/ICD) | Graphics/compute failures | Separate GPU validation gates; record ICD/loader/env per layer. |

## Validation plan

*Not executable in this environment; to be performed on-device by user/operator.*

- **Structural:** All required scaffold files/dirs present; manifests and matrix internally consistent; no contradictory layer/ABI assignments.
- **Traceability:** Every repo row has category/priority/layer/problems/artifacts/deps/evidence/decision fields; every foundation stub links to template sections.
- **Invariant checks:** Host/guest and Bionic/glibc separation stated in plan, runbooks, manifests, and category docs; no-systemd-in-PRoot stated; Android-on-host build rule stated; linker-per-target policy stated.
- **On-device gates (future):** Termux host pkg/build sanity; PRoot Ubuntu boot/bind mounts; toolchain probes per target triple; runtime/service smoke tests under supervisor; GPU capability probes separated by layer; phase-specific rollback verification.

## Out of scope (Milestone A)

- Fetching/cloning external repos or running network-heavy downloads.
- Reading/writing Google Drive contents or automating sync.
- Whole-repo integration of upstream projects.
- Executing builds, installs, GPU tests, or on-device validation.
- Creating commits/PRs or changing runtime system state.

## Open decision

**Mirror location for authoritative bodies:** mirror `task.md`, KB, and conductor workflow materials into `termux-build/knowledge_base/` and `termux-build/conductor/` (or an equivalent layout mandated by conductor once inspected). Finalize paths/naming after `00-intake/conductor-alignment.md` is completed against mirrored `task.md` and `conductor/README` or equivalent gates. Until resolved, treat current paths as intake targets only.
