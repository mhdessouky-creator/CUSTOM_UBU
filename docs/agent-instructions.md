# Agent Instructions (Mandatory)

These instructions apply to **every agent/session** working in this repository. Follow them **before answering any user request**.

## 1. Mandatory pre-response protocol
1. **Read governance (required):**
   - `AGENTS.md` (authoritative contract)
   - `docs/README.md` (index and reading order)
   - Task-relevant docs: `docs/task-protocol.md`, `docs/workspace-constraints.md`, `docs/operating-model.md`, and `docs/mcp-kilo-kit.md` when MCP/setup is involved.
2. **Establish context:**
   - Project: **kilo-opts** (not `CUSTOM_UBU`).
   - Branch: `kilo/cool-data-6ot` (current session branch; do not switch/rename unless explicitly instructed and permitted).
   - Remote: `origin` → `mhdessouky-creator/CUSTOM_UBU.git` (external name may differ; document, do not assume renamed).
   - Identify the user’s goal, scope, constraints, and acceptance criteria.
3. **Start control flow:**
   - **If Kilo-Kit MCP is available:** call `kilo_orchestrate_task` as the **first action**, then follow returned gates/skills (probe → reason → approve/skills → implement → verify/reflect).
   - **If Kilo-Kit MCP is not available:** state the limitation and execute the equivalent manual flow: grounded probe, explicit reasoning/plan, load/apply relevant repo skills/docs, implement carefully, and verify with evidence.
4. **Ground before acting:** read/search relevant files; do not guess. Base decisions on repository evidence.
5. **Respond/execute in sequence:** plan before non-trivial changes, keep updates clear, and report evidence.

## 2. Required behavior by task type
- **Features / architecture:** analyze requirements and trade-offs, compare options, document decisions (ADR when significant), then implement.
- **Bugs / errors:** reproduce/trace from evidence, identify root cause before fixing, verify the fix.
- **Configuration/docs/setup:** keep sources consistent (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `docs/`), preserve constraints, and validate structure.

## 3. Kilo-Kit C4 gates (when MCP available)
1. **Gate 1:** `kilo_orchestrate_task` + grounded probe (`kilo_read_file` / search / grep).
2. **Gate 2:** `kilo_think_step` + `kilo_grill_plan` for features/architecture, or `kilo_trace_root_cause` for bugs; use `kilo_compact_context` if context becomes noisy.
3. **Gate 3:** `kilo_orchestrate_task` with `brainstormingApproved=true` and load skills via `kilo_get_skill`.
4. **Gate 4:** surgical implementation with defense-in-depth and clean standards.
5. **Gate 5:** verify with evidence and record reflection when appropriate (`kilo_record_reflection`).

## 4. Delivery rules
- Keep changes minimal, correct, and traceable.
- Do not invent evidence, paths, or results.
- Do not create/switch branches or rewrite git history unless explicitly requested and permitted.
- Treat legacy/unrelated folders as out-of-scope unless requested; do not modify or delete them implicitly.
- End with a clear report: what was read/decided, what changed, verification performed, constraints, and next steps.

## 5. “No ambiguity” checklist
Before finalizing any response, confirm:
- [ ] I identified project (`kilo-opts`), branch, and constraints.
- [ ] I followed required reads and (if available) MCP-first orchestration.
- [ ] I can point to evidence for key claims.
- [ ] Instructions/docs/config I touched are consistent.
- [ ] Risks, limitations, and manual follow-ups (if any) are stated.
