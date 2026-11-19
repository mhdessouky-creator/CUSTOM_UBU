# Operating Model — kilo-opts (Beehive)

## Mission
**kilo-opts** is a strict, high-quality operating environment for AI agents working on complex programming tasks (typically driven through Kilo). Every session behaves like a beehive: clear roles, shared rules, evidence-based work, and disciplined handoffs toward one goal.

## Core principles
1. **Instruction-first:** Read repo instructions before answering any request.
2. **MCP-first when available:** Use Kilo-Kit MCP (`kilo_orchestrate_task`, probing, reasoning, skills, verification tools) as the mandatory control plane; if unavailable, follow the equivalent manual gate flow and state the limitation.
3. **Grounded action:** Probe/read before changing; do not guess repository state.
4. **Disciplined sequence:** Follow C4 gates and the task protocol; no silent jumps from request to implementation.
5. **Evidence over claims:** Verify outputs and report what was actually checked.
6. **Simplicity and clarity:** Prefer the simplest structure that enforces rigor (modular governance, no unnecessary scaffolding).

## Beehive roles
A single agent may hold multiple roles, but each role’s responsibilities must be executed explicitly.

| Role | Responsibility | Primary outputs |
|---|---|---|
| **Orchestrator** | Intake request, set goal/scope, route to gates/skills, coordinate sequence | Task framing, plan/order of work |
| **Researcher** | Grounded probe: read/search/inspect files and constraints | Evidence, findings, unknowns |
| **Architect** | Analyze options/trade-offs, define structure/decisions (ADR) | Design, ADRs, rationale |
| **Implementer** | Apply surgical, standards-compliant changes | Code/config/docs changes |
| **Verifier/Reviewer** | Check correctness, constraints, quality, and completeness | Verification results, issues/risks |
| **Scribe** | Keep instructions/docs accurate and traceable | Updated docs, clear reports/handoffs |

## Standard operating rhythm
1. **Align:** Read `AGENTS.md` and relevant docs; confirm where we are, why, and constraints.
2. **Orchestrate:** Start with `kilo_orchestrate_task` (MCP) and load required skills.
3. **Probe:** Build a grounded model of the repo/task.
4. **Reason:** Compare options, stress-test plans, or trace root causes as appropriate.
5. **Execute:** Implement minimal, correct, well-scoped changes.
6. **Verify:** Validate against requirements/constraints; run available checks.
7. **Report:** Deliver a clear summary: what changed, evidence, risks, and next steps.

## Quality bar
- **Spec fidelity:** Meets the stated request and constraints.
- **Clarity:** Repo purpose, rules, and paths are unambiguous.
- **Consistency:** `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `docs/` do not conflict.
- **Traceability:** Decisions and non-obvious choices are documented (ADR/docs).
- **Safety:** Respect workspace/git/platform constraints; no destructive surprises.

## Definition of “ready environment”
- Identity and purpose (`kilo-opts`) are explicit.
- Mandatory pre-response protocol and C4/MCP rules are documented and discoverable.
- Repo map, constraints, and task flow leave no ambiguity for agents.
- Kilo project config (`.kilo/kilo.json`) and governance docs are present and consistent.
- Any unavailable capability (e.g. local MCP on mobile) has a documented fallback.
