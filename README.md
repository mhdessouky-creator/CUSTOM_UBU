# kilo-opts

**kilo-opts** is a strict, high-quality AI-agent operating environment for complex programming work through Kilo, built on **Kilo-Kit C4 + MCP**. It defines a clear, disciplined “beehive” workflow so every agent knows where we are, why we are here, what to read, and how to deliver.

> Legacy repository/remote name may still appear as `CUSTOM_UBU` (`origin: mhdessouky-creator/CUSTOM_UBU.git`) and the working branch is `kilo/cool-data-6ot`; the project identity and governance in this workspace are **kilo-opts** (see [workspace constraints](docs/workspace-constraints.md)).

## Purpose
- Provide an unambiguous, instruction-first environment for AI agents.
- Enforce a mandatory sequence: **read instructions → orchestrate/probe → reason → execute → verify → report**.
- Use **Kilo-Kit MCP** as the control plane when available, with a documented manual fallback when not (e.g. Kilo mobile).

## Mandatory: before answering any request
1. Read **[`AGENTS.md`](AGENTS.md)** (authoritative contract) and **[`docs/README.md`](docs/README.md)**.
2. Read task-relevant docs: [`docs/agent-instructions.md`](docs/agent-instructions.md), [`docs/task-protocol.md`](docs/task-protocol.md), [`docs/workspace-constraints.md`](docs/workspace-constraints.md), [`docs/mcp-kilo-kit.md`](docs/mcp-kilo-kit.md).
3. Establish context: project `kilo-opts`, branch `kilo/cool-data-6ot`, constraints, and request goal.
4. **If Kilo-Kit MCP is available:** call `kilo_orchestrate_task` first and follow C4 gates/skills.
5. **If MCP is unavailable:** state the limitation and follow the equivalent manual gate flow with evidence.

## Repository map

| Path | Role |
|---|---|
| [`AGENTS.md`](AGENTS.md) | Authoritative operating contract (C4 + kilo-opts rules) |
| [`CLAUDE.md`](CLAUDE.md), [`GEMINI.md`](GEMINI.md) | Aligned instruction mirrors for agent tooling |
| [`.kilo/kilo.json`](.kilo/kilo.json) | Kilo project config (Kilo-Kit MCP server) |
| [`.kilo/skills/`](.kilo/skills/) | Project-local installed skills (`claukit`, `engineering/architecture`) |
| [`docs/`](docs/README.md) | Governance hub: operating model, instructions, constraints, protocol, MCP, ADRs |
| [`docs/architecture/adr-001-kilo-opts-foundation.md`](docs/architecture/adr-001-kilo-opts-foundation.md) | Foundation architecture decision record |
| `termux-build/`, `.kilo/plans/1794...` | Legacy/out-of-scope artifacts (kept for manual removal later) |

## Kilo-Kit MCP (project config)
`.kilo/kilo.json` configures a local stdio MCP server (Node.js >= 20, Node-capable environments):

```json
{
  "mcp": {
    "servers": {
      "kilo-kit": {
        "type": "local",
        "command": ["npx", "-y", "@vodailocz/kilo-kit-mcp"]
      }
    }
  }
}
```

Setup/verification (when Node is available): `npm install -g @vodailocz/kilo-kit-mcp`, `kilo-kit-setup --local`, `kilo-kit-doctor`.  
**Note:** Kilo mobile cannot run local stdio MCP; rely on repo instructions and MCP-capable environments for full tool access.

## Beehive workflow (summary)
Intake → Grounded probe → Reason/plan (trade-offs, ADR when needed) → Execute (surgical) → Verify (evidence) → Report. Roles (Orchestrator, Researcher, Architect, Implementer, Verifier, Scribe) may be combined but must remain explicit. See [`docs/operating-model.md`](docs/operating-model.md) and [`docs/task-protocol.md`](docs/task-protocol.md).

## Documentation
Start at [`docs/README.md`](docs/README.md) for the full index and reading order.
