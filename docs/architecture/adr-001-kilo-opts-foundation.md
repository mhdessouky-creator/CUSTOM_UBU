# ADR-001: kilo-opts Foundation — Identity, Governance, and Operating Structure

## Status
**Accepted** (foundation for this branch/workspace)

## Context
- **Problem:** The repository required a clear, strict, reusable environment for AI-agent work (via Kilo), where every session knows the project identity, goals, constraints, and the mandatory process (read instructions and use Kilo-Kit MCP/C4 gates before answering requests).
- **Prior state:** Mixed identity (`CUSTOM_UBU`), minimal template, and legacy artifacts (`termux-build/`, old plan) not aligned to the desired operating model.
- **Constraints:**
  - Current session branch: `kilo/cool-data-6ot` (cannot be renamed/switched in this environment).
  - Remote: `mhdessouky-creator/CUSTOM_UBU.git` (cannot be renamed externally from this workspace).
  - Kilo mobile cannot run local stdio MCP servers; Node-capable environments can.
  - User requested: do not delete legacy folders/files now (manual cleanup later); ensure future Kilo sessions loading this branch can load the architecture/instructions/config.

## Options Considered

| Option | Pros | Cons | Complexity | When valid |
|---|---|---|---|---|
| **A. Minimal strict template** | Fast, low churn, few files | Weak separation of concerns, ambiguous role/flow guidance, limited auditability | Low | Very small, short-lived setups |
| **B. Modular governance hub (chosen)** | Clear repo map and rules, explicit beehive roles/protocol, ADR/traceability, MCP-first with fallback, simple but rigorous | More initial documentation effort | Medium | Ongoing agent operations needing clarity and discipline |
| **C. Full framework scaffolding** | Maximum explicitness (many scripts/templates/roles) | Over-engineering (YAGNI), maintenance/drift risk, higher complexity now | High | Large teams/processes with proven need |

## Decision
Adopt **Option B: Modular governance hub** and establish project identity as **`kilo-opts`**.

### Implemented structure
- **Root:** `README.md`, `AGENTS.md` (authoritative contract), `CLAUDE.md`/`GEMINI.md` (aligned), `.gitignore`.
- **Config/skills:** `.kilo/kilo.json` (Kilo-Kit MCP), `.kilo/skills/` (project-local skills, e.g. `claukit`, `engineering/architecture`), `.kilo/plans/`.
- **Governance docs:** `docs/README.md`, `docs/operating-model.md`, `docs/agent-instructions.md`, `docs/workspace-constraints.md`, `docs/task-protocol.md`, `docs/mcp-kilo-kit.md`, `docs/architecture/adr-001-kilo-opts-foundation.md`.

### Mandatory operating rule
Before answering any request, agents must read required repo instructions and, when Kilo-Kit MCP is available, invoke `kilo_orchestrate_task` first and follow C4 gates/skills; when unavailable, follow the equivalent manual protocol and state the limitation.

## Rationale
1. **Clarity over guesswork:** explicit identity, map, constraints, and protocol remove ambiguity.
2. **Discipline without bloat:** modular docs/config provide rigor aligned with C4 and architecture-skill guidance without unnecessary scaffolding.
3. **Portability:** works as instruction-driven governance on mobile/limited environments and as full MCP-driven workflow in capable environments.
4. **Traceability:** ADR captures context, trade-offs, and consequences for future changes.

## Trade-offs Accepted
- More documentation to maintain in exchange for consistent agent behavior.
- Branch/remote external names may differ from `kilo-opts` identity; documented as constraints rather than forcibly changed.
- Legacy folders remain in place for now (per user direction), which may add noise until manually removed.

## Consequences
- **Positive:** predictable session startup behavior, shared operating model, easier onboarding for agents, auditable decisions.
- **Negative:** requires keeping instruction sources consistent; partial MCP capability on mobile.
- **Mitigation:** single authoritative contract in `AGENTS.md` with aligned mirrors and indexed docs; explicit fallback protocol; future ADRs for significant changes.

## Revisit Trigger
- When the GitHub repo/branch is renamed or migrated.
- When legacy artifacts are removed/restructured.
- When new tooling, CI, or runtime components require additional governance.
- When repeated agent confusion indicates missing or conflicting instructions.
