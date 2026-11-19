# kilo-opts — Agent Operating Contract (Authoritative)

> **Project:** `kilo-opts` — a strict, high-quality AI-agent operating environment (beehive model) for complex programming work through Kilo, governed by **Kilo-Kit C4 + MCP**.  
> **Branch:** `kilo/cool-data-6ot` (stay on this branch unless explicitly requested and permitted).  
> **Remote:** `origin` = `https://github.com/mhdessouky-creator/CUSTOM_UBU.git` (external name may differ; this workspace identity is `kilo-opts`).  
> **Authority:** This file is the source of truth for agent behavior in this repository. `CLAUDE.md` and `GEMINI.md` must remain aligned with it.

## Mandatory: before answering any user request
1. **Read required instructions:** this `AGENTS.md` and [`docs/README.md`](docs/README.md), then task-relevant docs ([`docs/agent-instructions.md`](docs/agent-instructions.md), [`docs/task-protocol.md`](docs/task-protocol.md), [`docs/workspace-constraints.md`](docs/workspace-constraints.md), [`docs/mcp-kilo-kit.md`](docs/mcp-kilo-kit.md), [`docs/operating-model.md`](docs/operating-model.md)).
2. **Establish context:** confirm project (`kilo-opts`), branch/remote constraints, request goal, scope, and acceptance criteria.
3. **MCP-first (when available):** call `kilo_orchestrate_task` as the **first action** and follow C4 gates (probe → reason → approve/skills → implement → verify/reflect). Use `kilo_read_file`/`kilo_search_files`/`kilo_grep_code`, `kilo_think_step`/`kilo_grill_plan` or `kilo_trace_root_cause`, `kilo_get_skill`, and verification/reflection tools as required.
4. **Fallback (when MCP unavailable, e.g. Kilo mobile):** state the limitation and execute the equivalent manual flow with the same discipline (grounded probe, explicit reasoning/plan, required skill/doc guidance, careful execution, evidence-based verification).
5. **Never guess:** do not answer substantively or modify files without grounded context and a clear plan/sequence.

## Repository map (where to find what)
| Path | Purpose |
|---|---|
| `README.md` | Project entry point and quick orientation |
| `AGENTS.md` / `CLAUDE.md` / `GEMINI.md` | Authoritative and aligned agent instructions |
| `.kilo/kilo.json` | Kilo project config (Kilo-Kit MCP server) |
| `.kilo/skills/` | Project-local installed skills (e.g. `claukit`, `engineering/architecture`) |
| `docs/README.md` | Documentation index and reading order |
| `docs/operating-model.md` | Beehive roles and operating rhythm |
| `docs/agent-instructions.md` | Mandatory pre-response checklist |
| `docs/task-protocol.md` | Request lifecycle aligned to C4 |
| `docs/workspace-constraints.md` | Branch/remote/platform/legacy constraints |
| `docs/mcp-kilo-kit.md` | Kilo-Kit setup and MCP usage |
| `docs/architecture/adr-001-kilo-opts-foundation.md` | Foundation architecture decision (ADR) |
| `instructions/hooks.instructions.md` | Agent-agnostic hook authoring/configuration guidelines (Kilo-compatible) |
| `.github/hooks/` | Configured hook examples and scripts (portable, observe-first defaults) |
| `termux-build/`, `.kilo/plans/1794...` | **Legacy/out-of-scope** (kept for manual removal later; do not modify/delete unless explicitly requested) |

## Operating principles (beehive)
- **Instruction-first, MCP-first, evidence-first.**
- **One mission, explicit roles:** Orchestrator, Researcher, Architect, Implementer, Verifier, Scribe (roles may be combined, steps must be explicit).
- **Sequence over chaos:** Intake → Probe → Reason → Execute → Verify → Report.
- **Consistency:** keep governance docs and instruction files aligned; document non-obvious decisions.
- **Respect constraints:** do not switch/rename branches, do not assume remote renamed, do not touch legacy paths implicitly, do not invent results.

<!-- KILO-KIT:C4:START -->
## Kilo-Kit C4 v3.0 Cognitive Protocol

Applies to: OpenAI Codex, Antigravity, Gemini CLI, Claude Code, Kilo

### 🧠 DIVISION OF LABOR (VỎ NÃO & CHÂN TAY):
- **Kilo-Kit MCP (Cortex):** High-level cognitive reasoning, 5-Whys root cause tracing, Tree-of-Thoughts DAG planning, adversarial red-teaming, context compaction, skill delivery, and SQLite learning memory.
- **Execution Limbs:** Perform surgical changes with defense-in-depth using your native tools or Kilo-Kit tools with Kilo-Sentinel supervision.

### 🏛️ MANDATORY 5-GATE COGNITIVE PROTOCOL:

1. **Gate 1 (Hard-Gate & Grounded Probe):** 
   - Call MCP tool `kilo_orchestrate_task` with the user's request as your FIRST action.
   - Perform read-only exploratory probing (`view_file`, `grep_search`, or `kilo_read_file`) to build a Grounded Diagnostic Model.

2. **Gate 2 (Substantive Cognitive Reasoning & Benchmarking):**
   - **For Features / Architecture:** MUST call `kilo_think_step` (DAG with 3 trade-off options) and `kilo_grill_plan` (Adversarial Red-Team stress test). Call `kilo_benchmark_solution` to audit against industry standards.
   - **For Bugs / Errors:** MUST call `kilo_trace_root_cause` with `{ errorLog, failingFile }` to extract the 5-Whys causal chain before writing any fix.
   - **For Context Overload (>4 files read):** Call `kilo_compact_context` to lock invariants and prevent attention degradation.

3. **Gate 3 (Approval & Skill Delivery):** 
   - Call `kilo_orchestrate_task` with `brainstormingApproved=true`.
   - Load required workflow skills using `kilo_get_skill` (supports aliases like `brainstorming`, `diagnose`, `playwright`, `tdd`, `clean-code`).
   - (Optional) Check supervisor status via `kilo_sentinel_status`.

4. **Gate 4 (Surgical Implementation & Defense-in-Depth):** 
   - Apply `problem-solving/defense-in-depth` (validation at input, logic, and persistence layers).
   - Maintain `engineering/clean-code` standards with zero bloat.

5. **Gate 5 (4D Quality Assurance & Reflection):**
   - **Dimension 1 (Spec Fidelity):** Verify against user requirements using Given-When-Then acceptance criteria (`productivity/spec-driven-development`).
   - **Dimension 2 (Clean Code):** Verify deep module interfaces and zero dead code (`engineering/clean-code`).
   - **Dimension 3 (UX & Aesthetics):** Verify responsive layout and mobile touch safety (`design/aesthetic`, `design/mobile-design`).
   - **Dimension 4 (Empirical & Playwright):** Run compile/build commands AND execute tests before claiming completion.
   - **Continuous Reflection:** Call `kilo_record_reflection` with sessionId to persist lessons learned into SQLite memory.

### 📢 MANDATORY INTER-TOOL NARRATION (ZERO SILENT CHAINS):
- **Iron Law:** NEVER execute consecutive tool calls without printing a 1-2 sentence intermediate update directly to the user. The terminal user CANNOT inspect internal MCP return payloads.
- **Micro-Narration Protocol before issuing next tool call:**
  - `[DECISION]:` State what you just concluded, selected, or verified cụ thể.
  - `[NEXT]:` State what tool you are calling next and for what purpose.
<!-- KILO-KIT:C4:END -->
