# Task Protocol (C4-Aligned)

This protocol defines the required lifecycle for handling any user request in **kilo-opts**.

## Lifecycle

| Phase | Purpose | Required actions | Outputs |
|---|---|---|---|
| **1. Intake & Align** | Understand request and context | Read `AGENTS.md` + `docs/README.md` + relevant docs; identify goal, scope, constraints, acceptance criteria | Clear task framing |
| **2. Orchestrate (Gate 1)** | Initialize controlled workflow | If MCP available: `kilo_orchestrate_task` first. If not: state limitation and follow manual gates | Session/route or explicit manual plan |
| **3. Grounded Probe** | Build evidence-based model | Read/search/inspect relevant repo files and configs; do not guess | Findings, evidence, open questions |
| **4. Reason (Gate 2)** | Decide correctly before acting | Features/architecture: options + trade-offs (`kilo_think_step`), stress-test (`kilo_grill_plan`), benchmark if useful. Bugs: root-cause trace (`kilo_trace_root_cause`). Compact noisy context if needed | Chosen approach, rationale, risks |
| **5. Approve & Skill Load (Gate 3)** | Lock direction and load guidance | `kilo_orchestrate_task` with `brainstormingApproved=true` (MCP path), load required skills (`kilo_get_skill`) | Approved plan, loaded skills |
| **6. Execute (Gate 4)** | Implement changes | Surgical, minimal, standards-compliant edits; defense-in-depth; respect constraints | Changes applied |
| **7. Verify (Gate 5)** | Prove outcomes | Check requirements/consistency; run available validations/tests; report what was/wasn’t verified | Evidence, verification report |
| **8. Report & Handoff** | Make state unambiguous | Summarize context, decisions, changes, evidence, risks/limits, and next steps | Final report |

## Mandatory pre-response rule
**Before answering any request:** complete Phase 1 and start Phase 2 (MCP-first when available). Do not provide a substantive answer or make changes without this alignment/probe discipline.

## Decision rules
- **Read before write:** inspect target files/state before editing.
- **Evidence before claims:** never claim success without verification evidence.
- **Scope control:** solve the requested task; avoid unrelated refactors/cleanup.
- **Constraint compliance:** follow `docs/workspace-constraints.md` (branch, remote, legacy paths, platform limits).
- **Consistency:** keep `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `docs/` aligned.

## MCP-unavailable fallback (e.g. mobile/local limitations)
When Kilo-Kit MCP tools cannot run:
1. State that MCP is unavailable in the current environment.
2. Manually perform the same phases: read governance, probe repo, reason/trade-offs, plan, execute carefully, verify.
3. Reference the relevant docs/skills by path and provide clear evidence in the report.
4. Recommend running in a Node-capable Kilo environment for full MCP/C4 tool support when needed.
