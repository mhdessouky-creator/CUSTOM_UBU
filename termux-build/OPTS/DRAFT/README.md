# CUSTOM_UBU — Milestone A Bootstrap Artifacts (DRAFT)

**Location:** `termux-build/OPTS/DRAFT/`  
**Target device/context:** Honor 400 Pro (Snapdragon 8 Gen 3 / Adreno 750, aarch64, Android, no root)  
**Architecture:** Termux app UID / Bionic host + Ubuntu simulated-root / glibc guest in PRoot

## Scope

Analysis/synthesis bootstrap only (best-combination fixes), **not** wholesale integration. Artifacts provide:
- Intake and Drive/conductor alignment records
- Deduplicated, prioritized canonical repo matrix (25 repos)
- Reusable per-repo analysis template and evidence extraction checklist
- Phases 1–20 runbooks and dependency manifests
- Category skeletons (termux / ubuntu / cross)
- Foundation-batch deep-analysis preparation stubs

## Provenance

- **Authoritative ops Drive folder (user-designated):** https://drive.google.com/drive/folders/1eiNS5oHkLiyuufAo4YH83SL9BodL_yta — uploads target subfolder `DRAFT/`.
- **Prior KB ref (tatata.md):** https://drive.google.com/drive/folders/1yEsEzqNjl1WDpAt8ou7_rTiFg6Kkc4_A — retained for traceability; **not** authoritative over `1eiNS5o...`.
- **Task brief (tatata.md, user-specified path):** `/tmp/attachments/workspace_13e536b7-26f3-4c94-9963-16cf40320f91/46c22935-fa46-472c-991b-483b96a03496/3fdd4c66-0906-4522-a406-c5b80c45d957/93f3af94-6003-4ad9-b43e-eaf0be94fbd6.md` — not readable in this sandbox; artifacts derived from provided in-session context and must be reconciled once mirrored.
- **Plan:** `.kilo/plans/1794629698409-termux-ubuntu-milestone-a-bootstrap-plan.md`

## Environment limitations (this sandbox)

- **Drive read/write:** not possible. Cannot fetch `task.md` body, KB, conductor workflow docs, or validate uploads.
- **Network:** no network-heavy fetches/clones of external repos performed; repo evidence is `pending` until gathered on a connected environment/on-device.
- **Execution:** resource-aware on-device validation required but not executable here.
- **Sync responsibility:** user/operator must mirror and upload artifacts as described below.

## Drive sync instructions

1. **Upload to authoritative `DRAFT/`:** sync the contents of `termux-build/OPTS/DRAFT/` to https://drive.google.com/drive/folders/1eiNS5oHkLiyuufAo4YH83SL9BodL_yta under subfolder `DRAFT/` (preserve relative paths where practical).
2. **Mirror inbound (priority):** bring authoritative Drive bodies into repo:
   - `task.md` (33 KB) -> reconcile against `00-intake/conductor-alignment.md` and runbooks/matrix (suggested: `termux-build/conductor/task.md` or path mandated by conductor).
   - `knowledge-base/` -> `termux-build/knowledge_base/` (or conductor-mandated equivalent).
   - `agents/`, `commands/`, `skills/`, `templates/`, `README.md`, `composio-mcp` -> `termux-build/conductor/` or documented equivalents per alignment.
3. **Use `reports/sync-manifest.md`:** it lists files/dirs to upload and items blocked on mirroring.
4. **After sync:** update `00-intake/drive-inventory.md` intake status, complete `00-intake/conductor-alignment.md`, replace `pending` evidence in matrix/foundation stubs with citations.

## How to use these artifacts

1. Read `00-intake/drive-inventory.md` and `00-intake/conductor-alignment.md` to understand gaps and required gates.
2. Use `01-repo-matrix/repo-matrix.md` for canonical priorities/layers and mining targets.
3. For each repo, copy/fill `02-analysis-templates/repo-analysis-template.md` guided by `evidence-extraction-checklist.md`; store per-repo analyses under `06-foundation-batch/` (foundation) or a future `07-repo-analyses/` area once created.
4. Execute work by `03-phase-runbooks/phases-1-20-runbook.md` respecting `04-dependency-manifests/*` ordering and invariants.
5. Keep decisions traceable (`adopt/adapt/reject/defer`) with source evidence; do not promote pending assumptions to facts.

## Key invariants (must remain true)

- Strict separation of **Android/Bionic** (`aarch64-linux-android`, Termux host) vs **Ubuntu/glibc** (`aarch64-unknown-linux-gnu`, PRoot guest) binaries/libs/configs/toolchains/artifacts.
- Build Android/Termux packages on **Termux host** (NDK/LLD), not in PRoot. Use **Mold** for supported Linux targets in Ubuntu.
- **No real systemd** in PRoot; no cgroups/namespace/kernel-module/Docker-daemon assumptions. Use custom foreground supervisor/runit tested in PRoot.
- GPU validation (KGSL/Vulkan/ICD/Turnip/Mesa/Zink/OpenCL/EGL as applicable) separated by layer.
- Resource-aware, on-device validation required. Document commands/outcomes when run; never claim unexecuted validation.
