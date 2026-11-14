# Conductor / KB / `task.md` Alignment Checklist (DRAFT)

**Purpose:** Align Milestone A artifacts to the conductor workflow, knowledge base, and `task.md` once mirrored into the repo.  
**Status:** Blocked on intake — Drive bodies not accessible from this sandbox.

## Preconditions (intake)

- [ ] Mirror `task.md` (authoritative Drive `1eiNS5o...`, 33 KB, shared 13 Nov) into repo (suggested: `termux-build/conductor/task.md`). **TODO:** confirm canonical path from conductor.
- [ ] Mirror `knowledge-base/` into `termux-build/knowledge_base/`. **TODO:** index contents and record authoritative docs relevant to phases 1–20.
- [ ] Mirror `agents/`, `commands/`, `skills/`, `templates/`, ops `README.md`, `composio-mcp` into `termux-build/conductor/` (or paths mandated by conductor). **TODO:** resolve vs existing in-repo layout.
- [ ] Reconcile prior KB ref `1yEsEzqNjl1WDpAt8ou7_rTiFg6Kkc4_A` if any materials differ from authoritative folder.

## Alignment fields to complete (populate from mirrored sources)

### Required gates
| Gate / checkpoint | Source (`task.md`/conductor ref) | Applies to phase(s)/artifact(s) | Pass criteria | Evidence required | Status |
|---|---|---|---|---|---|
| TODO | TODO | TODO | TODO | TODO | pending |

**TODO (task.md):** extract explicit gates, approvals, Definition-of-Done, and stop/go criteria for phases 1–20 and foundation batch.

### Naming and layout
| Topic | Conductor/task.md requirement | Current DRAFT choice | Action (keep/rename/move) | Status |
|---|---|---|---|---|
| DRAFT artifact root | TODO | `termux-build/OPTS/DRAFT/` | Confirm upload/sync path under Drive `DRAFT/` | pending |
| KB mirror path | TODO | `termux-build/knowledge_base/` | Confirm | pending |
| Conductor mirror path | TODO | `termux-build/conductor/` | Confirm | pending |
| Per-repo analysis storage | TODO | `06-foundation-batch/*.md` (foundation) | Confirm pattern for non-foundation repos | pending |
| Report/manifest naming | TODO | kebab-case `.md` under numbered dirs | Confirm | pending |

### Templates
| Template need | Canonical source (Drive/in-repo) | DRAFT artifact | Reconciliation action | Status |
|---|---|---|---|---|
| Repo analysis | TODO (`templates/`?) | `02-analysis-templates/repo-analysis-template.md` | Merge/replace with conductor canonical; keep evidence fields | pending |
| Evidence checklist | TODO | `02-analysis-templates/evidence-extraction-checklist.md` | Align | pending |
| Phase/runbook format | TODO (`task.md`?) | `03-phase-runbooks/phases-1-20-runbook.md` | Align gates/sections | pending |
| Intake/report format | TODO | `00-intake/*`, `reports/sync-manifest.md` | Align | pending |

### Agent / command / skill usage
| Capability | Source definition | Intended use in CUSTOM_UBU workflow | Constraints/approvals | Status |
|---|---|---|---|---|
| Agents | `agents/` (TODO mirror) | TODO (e.g. intake, evidence mining, validation reporting) | TODO | pending |
| Commands | `commands/` (TODO mirror) | TODO | TODO | pending |
| Skills | `skills/` (TODO mirror) | TODO | TODO | pending |
| MCP/tools | `composio-mcp` (TODO inspect) | TODO | Must respect sandbox limits (no Drive/network-heavy fetch/on-device exec from here) | pending |

## Artifact-to-source traceability updates required

- [ ] Map each tatata phase (1–20) and section (1–20) to `task.md` paragraphs/headings once mirrored; update `03-phase-runbooks/phases-1-20-runbook.md`.
- [ ] Validate canonical repo list/priorities against `task.md` and KB; record any additions/removals/merges in `01-repo-matrix/repo-matrix.md` change notes.
- [ ] Propagate conductor-required fields into `repo-analysis-template.md` and foundation stubs.
- [ ] Record mirror commit/revision and sync date in `reports/sync-manifest.md`.

## Completion criteria for this checklist

- All TODOs resolved or explicitly deferred with owner/rationale.
- Required gates enumerated with pass/fail evidence.
- Naming/layout matches conductor (or deviations documented and accepted).
- DRAFT artifacts reconciled and re-synced to Drive `DRAFT/`.
