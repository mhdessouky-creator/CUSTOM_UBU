# kilo-opts Documentation Index

This directory is the governance hub for **kilo-opts**: a strict, high-quality AI-agent operating environment built around Kilo-Kit C4 + MCP.

## Mandatory reading order (before answering any user request)

1. **[`/AGENTS.md`](../AGENTS.md)** — authoritative operating contract (identity, goals, C4 gates, mandatory pre-response protocol, repo map).
2. **This index** — locate the right governance document for the task.
3. **Task-relevant docs:**
   - [`agent-instructions.md`](agent-instructions.md) — strict step-by-step instructions for every request.
   - [`task-protocol.md`](task-protocol.md) — request lifecycle and gate flow.
   - [`workspace-constraints.md`](workspace-constraints.md) — environment, branch/remote, and platform limits.
   - [`mcp-kilo-kit.md`](mcp-kilo-kit.md) — Kilo-Kit/MCP setup and required tool usage.
   - [`operating-model.md`](operating-model.md) — beehive roles, coordination, and delivery standards.
4. **Architecture decisions:** [`architecture/adr-001-kilo-opts-foundation.md`](architecture/adr-001-kilo-opts-foundation.md).

## Document map

| Document | Purpose | Read when |
|---|---|---|
| [`operating-model.md`](operating-model.md) | Beehive operating model: mission, roles, handoffs, quality bar | Starting any task; coordinating work |
| [`agent-instructions.md`](agent-instructions.md) | Mandatory pre-response checklist and execution rules | Before answering or implementing any request |
| [`workspace-constraints.md`](workspace-constraints.md) | Branch/remote, Cloud/mobile limits, repo boundaries | Planning, git operations, environment assumptions |
| [`task-protocol.md`](task-protocol.md) | Intake → Probe → Reason → Execute → Verify → Report flow (C4-aligned) | Running or reviewing any task |
| [`mcp-kilo-kit.md`](mcp-kilo-kit.md) | Kilo-Kit install/setup/doctor and MCP tool protocol | Configuring or using Kilo-Kit/MCP |
| [`architecture/adr-001-kilo-opts-foundation.md`](architecture/adr-001-kilo-opts-foundation.md) | Foundation decision, trade-offs, and consequences | Understanding why the environment is structured this way |
| [`../instructions/hooks.instructions.md`](../instructions/hooks.instructions.md) | Portable, agent-agnostic hook authoring/configuration guidance (Kilo-compatible) | Configuring hooks in `.github/hooks/` or `hooks/` |

## Project-local skills

Installed in `.kilo/skills/` for in-repo governance and reference:
- `agent-frameworks/claukit` — mission briefs, guardrails, integration hints.
- `engineering/architecture` — context discovery, trade-offs, ADRs, pattern selection.

When Kilo-Kit MCP is available, also use `kilo_get_skill` / `kilo_search_skills` for the bundled skill library.
