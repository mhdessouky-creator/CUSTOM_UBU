# Drive Inventory & Intake Status (DRAFT)

## Authoritative ops folder (user-designated)

- **URL:** https://drive.google.com/drive/folders/1eiNS5oHkLiyuufAo4YH83SL9BodL_yta
- **Role:** Authoritative operations folder for CUSTOM_UBU. Upload target for bootstrap artifacts: subfolder `DRAFT/`.
- **Access from this sandbox:** **Not possible** (no Drive read/write). Listing below reflects user-provided web-fetch observation.

### Observed top-level items (contents not accessible)

| Item | Type | Size (reported) | Shared (reported) | Notes |
|---|---|---:|---|---|
| `agents/` | folder | — | — | Conductor/agent definitions; mirror candidate. |
| `commands/` | folder | — | — | Command specs; mirror candidate. |
| `DRAFT/` | folder | — | — | **Upload target** for `termux-build/OPTS/DRAFT/`. |
| `knowledge-base/` | folder | — | — | KB materials; mirror to `termux-build/knowledge_base/`. |
| `OPTS/` | folder | — | — | Optimization/ops materials; reconcile with in-repo `OPTS/DRAFT`. |
| `skills/` | folder | — | — | Skill definitions; mirror candidate. |
| `templates/` | folder | — | — | Templates; reconcile with `02-analysis-templates/`. |
| `composio-mcp` | file | 4 KB | — | MCP/config artifact; inspect after mirror. |
| `README.md` | file | 5 KB | 8 Nov | Ops overview; mirror candidate. |
| `task.md` | file | 33 KB | 13 Nov | Primary task/conductor input; high-priority mirror. |

## Prior KB reference (tatata.md)

- **URL:** https://drive.google.com/drive/folders/1yEsEzqNjl1WDpAt8ou7_rTiFg6Kkc4_A
- **Role:** Prior knowledge-base reference cited in tatata.md. Retained for traceability only.
- **Authority:** **Not authoritative** relative to `1eiNS5o...` for ops/DRAFT uploads and current workflow. Reconcile contents if mirrored.

## Intake status

| Area | Status | Action required |
|---|---|---|
| Drive folder bodies | **Unmirrored / unreadable** | User must mirror into repo (see suggested paths). |
| `task.md` (33 KB) | **Unmirrored** | Mirror and align runbooks/matrix/gates; resolve open naming/layout decisions. |
| Conductor workflow docs | **Unmirrored** | Mirror `agents/`, `commands/`, `skills/`, `templates/`, README/conductor docs; complete alignment checklist. |
| KB materials | **Unmirrored** | Mirror `knowledge-base/` to `termux-build/knowledge_base/`. |
| External repos (25 canonical) | **Unfetched** | Perform evidence extraction in a networked/on-device context; update `evidence_status`. |
| In-repo DRAFT scaffold | **Created (this Milestone A pass)** | Upload to Drive `DRAFT/`; keep DRAFT until reconciled. |

## Exact items to mirror and suggested target paths in repo

| Drive item (authoritative) | Suggested in-repo target | Priority | Notes |
|---|---|---|---|
| `task.md` | `termux-build/conductor/task.md` (or conductor-mandated path) | P0 | Drives gates, phases, naming; reconcile with phases 1–20 runbook. |
| `knowledge-base/` (contents) | `termux-build/knowledge_base/` | P0 | Preserve internal structure; index if large. |
| `agents/` | `termux-build/conductor/agents/` | P1 | Align agent usage in `conductor-alignment.md`. |
| `commands/` | `termux-build/conductor/commands/` | P1 | Align command/gate usage. |
| `skills/` | `termux-build/conductor/skills/` | P1 | Align skill usage. |
| `templates/` | `termux-build/conductor/templates/` and/or reconcile into `02-analysis-templates/` | P1 | Avoid duplicate divergent templates; record canonical source. |
| `README.md` (ops) | `termux-build/conductor/README.md` (or `docs/ops-README.md`) | P1 | Capture workflow overview and folder conventions. |
| `composio-mcp` | `termux-build/conductor/composio-mcp` (inspect format) | P2 | Determine if config, doc, or pointer. |
| `OPTS/` | Reconcile with `termux-build/OPTS/` | P2 | Merge carefully; DRAFT artifacts live under `OPTS/DRAFT/`. |
| `DRAFT/` (Drive) | Mirror back into `termux-build/OPTS/DRAFT/` after review | P1 | Two-way sync risk; prefer timestamped/reviewed merges. |

**Open decision:** finalize mirror layout once conductor/`task.md` specify required paths and naming (see `.kilo/plans/1794629698409-termux-ubuntu-milestone-a-bootstrap-plan.md`).
