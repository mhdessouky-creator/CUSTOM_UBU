# Sync Manifest — `termux-build/OPTS/DRAFT/` (DRAFT)

**Generated:** 2026-11-14 (Milestone A bootstrap)  
**Purpose:** List artifacts to upload to authoritative Drive `DRAFT/` and items blocked on mirroring/evidence.

## Authoritative upload target

- **Drive folder:** https://drive.google.com/drive/folders/1eiNS5oHkLiyuufAo4YH83SL9BodL_yta
- **Subfolder:** `DRAFT/`
- **Upload scope:** contents of `termux-build/OPTS/DRAFT/` (preserve relative paths).

## Files/dirs to upload (created in this pass)

| Path (relative to `termux-build/OPTS/DRAFT/`) | Type | Purpose | Readiness |
|---|---|---|---|
| `README.md` | doc | Scope, provenance, Drive sync instructions, limitations | DRAFT-ready |
| `00-intake/drive-inventory.md` | doc | Observed Drive listing, authority, intake status, mirror targets | DRAFT-ready |
| `00-intake/conductor-alignment.md` | doc | Checklist for conductor/KB/task.md alignment (TODOs) | DRAFT (blocked on mirrors) |
| `01-repo-matrix/repo-matrix.md` | doc | Deduplicated canonical 25-repo matrix with priorities/layers/fields | DRAFT-ready (evidence pending) |
| `02-analysis-templates/repo-analysis-template.md` | template | Reusable per-repo analysis template | DRAFT-ready |
| `02-analysis-templates/evidence-extraction-checklist.md` | checklist | Evidence mining checklist | DRAFT-ready |
| `03-phase-runbooks/phases-1-20-runbook.md` | runbook | Phases 1–20 actionable runbook with gates/rollback/invariants | DRAFT (reconcile with task.md) |
| `04-dependency-manifests/global-dependency-dag.md` | manifest | Phase/repo/toolchain DAG and do-not-mix rules | DRAFT-ready |
| `04-dependency-manifests/termux-host-manifest.md` | manifest | Termux host core/build/services ordering | DRAFT-ready |
| `04-dependency-manifests/ubuntu-guest-manifest.md` | manifest | Ubuntu guest bootstrap/layout/supervision/runtime | DRAFT-ready |
| `04-dependency-manifests/toolchain-manifest.md` | manifest | bootstrap Rust → mise → final Rust/Cargo → mold/linkers | DRAFT-ready |
| `05-category-docs/termux/README.md` | doc | Termux category skeleton | DRAFT-ready |
| `05-category-docs/ubuntu/README.md` | doc | Ubuntu category skeleton | DRAFT-ready |
| `05-category-docs/cross/README.md` | doc | Cross-layer integration skeleton | DRAFT-ready |
| `06-foundation-batch/README.md` | doc | Foundation-batch deep-analysis plan and sequencing | DRAFT-ready |
| `06-foundation-batch/termux-packages.md` | stub | R01 analysis stub (pending-unfetched) | DRAFT stub |
| `06-foundation-batch/termux-tools.md` | stub | R02 analysis stub (pending-unfetched) | DRAFT stub |
| `06-foundation-batch/termux-exec-package.md` | stub | R03 analysis stub (pending-unfetched) | DRAFT stub |
| `06-foundation-batch/termux-core-package.md` | stub | R04 analysis stub (pending-unfetched) | DRAFT stub |
| `06-foundation-batch/proot-distro.md` | stub | R06 analysis stub (pending-unfetched) | DRAFT stub |
| `06-foundation-batch/glibc-packages.md` | stub | R05 analysis stub (pending-unfetched) | DRAFT stub |
| `06-foundation-batch/mold.md` | stub | R07 analysis stub (pending-unfetched) | DRAFT stub |
| `06-foundation-batch/termux-llvm-rust-mold.md` | stub | R08 analysis stub (pending-unfetched) | DRAFT stub |
| `06-foundation-batch/cargo_toolchain.md` | stub | R09 analysis stub (pending-unfetched) | DRAFT stub |
| `06-foundation-batch/ubuntu-mise.md` | stub | R10 analysis stub (pending-unfetched) | DRAFT stub |
| `reports/sync-manifest.md` | report | This manifest | DRAFT-ready |

## Supporting in-repo intake targets (not under DRAFT/ upload tree, but relevant)

| Path | Purpose | Status |
|---|---|---|
| `termux-build/knowledge_base/.gitkeep` | Intake target for mirrored KB | placeholder |
| `termux-build/conductor/.gitkeep` | Intake target for mirrored conductor/task materials | placeholder |
| `.kilo/plans/1794629698409-termux-ubuntu-milestone-a-bootstrap-plan.md` | Milestone A plan | created (consider mirroring per conductor) |

## Blocked / pending items (must be resolved after sync/mirror)

| Item | Blocker | Owner/action | Impact |
|---|---|---|---|
| `task.md` body (Drive, 33 KB, shared 13 Nov) | Drive read not possible from sandbox; not mirrored | User mirrors to repo (suggested `termux-build/conductor/task.md`) and reconciles runbooks/gates/naming | Conductor alignment incomplete; phase/gate text may diverge |
| `knowledge-base/` contents | Not mirrored | User mirrors to `termux-build/knowledge_base/` | Evidence/context gaps |
| `agents/`, `commands/`, `skills/`, `templates/`, ops README, `composio-mcp` | Not mirrored/inspected | User mirrors to `termux-build/conductor/` or mandated paths; complete alignment checklist | Template/gate/usage alignment pending |
| Prior KB folder `1yEsEzqNjl1WDpAt8ou7_rTiFg6Kkc4_A` | Not reconciled | User compares against authoritative `1eiNS5o...` if needed | Possible stale references |
| External repo evidence (R01-R25) | No network-heavy fetch/clone; no local sources | User performs pinned-clone or mirrored evidence extraction; update stubs/matrix | All repo analyses pending-unfetched |
| On-device validation | Not executable in sandbox | User executes phase gates on target device and records results | No runtime/build/GPU claims validated |
| Final mirror layout decision | Conductor/task.md not inspected | Resolve open decision in plan + `conductor-alignment.md` | Paths may need rename/move |

## Post-sync verification checklist

- [ ] All listed DRAFT files visible in Drive `DRAFT/` under authoritative folder.
- [ ] Inbound mirrors completed (`task.md`, KB, conductor materials) and recorded with date/revision.
- [ ] `00-intake/drive-inventory.md` and this manifest updated with sync timestamp and any path adjustments.
- [ ] `00-intake/conductor-alignment.md` TODOs triaged against mirrored sources.
- [ ] Foundation-batch stubs begin evidence updates with citations.

## Notes

- Do not treat DRAFT artifacts as validated implementation guidance until evidence and on-device gates are completed.
- If Drive `DRAFT/` already contains files, merge carefully to avoid clobbering reviewed content; prefer reviewed diffs.
