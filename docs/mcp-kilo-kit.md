# Kilo-Kit MCP — Setup and Usage (kilo-opts)

Kilo-Kit MCP is the preferred control plane for disciplined agent work in **kilo-opts**. Use it as **mandatory tooling** when available.

## What it provides
- **C4 orchestration & gates:** `kilo_orchestrate_task`, reasoning/trace/grill/compact tools.
- **Skill system:** `kilo_get_skill`, `kilo_search_skills`, workflow routing.
- **Safe execution & probes:** read/search/grep and guarded edit/write/run tools (session-gated).
- **Memory & quality:** memory/reflection/validation/sentinel tools.

## Project configuration (this repo)
Kilo project config: `.kilo/kilo.json`

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

- Runs in environments that can spawn local stdio MCP servers (Node.js >= 20, `npx`/Node available).
- First run may download the package (network required).
- If installed globally, command may be changed to `["kilo-kit-mcp"]`.

## Install / verify (Node-capable environment)
```bash
npm install -g @vodailocz/kilo-kit-mcp
kilo-kit-setup --local   # or: kilo-kit-init global
kilo-kit-doctor          # health check
```

Bootstrap protocol files (if needed): `kilo-kit-init init --client all`

## How agents must use Kilo-Kit (strict)
1. **First action on a substantive request:** `kilo_orchestrate_task` with request/message and relevant context.
2. **Grounded probe:** `kilo_read_file`, `kilo_search_files`, `kilo_grep_code` (and other read-only inspection) before changes.
3. **Reasoning:** `kilo_think_step` + `kilo_grill_plan` (features/architecture) or `kilo_trace_root_cause` (bugs); `kilo_compact_context` when noisy.
4. **Approval & skills:** `kilo_orchestrate_task` with `brainstormingApproved=true`, then `kilo_get_skill` for required skills.
5. **Implementation/verification:** follow C4 gates; use guarded tools as appropriate; verify with evidence; `kilo_record_reflection` when useful.

Treat MCP tool calls and gate requirements as **operational commands**, not optional suggestions.

## Availability and fallback
- **Kilo mobile app:** cannot run local stdio MCP servers directly. The repo’s `AGENTS.md` and `docs/` still define the mandatory process; agents must follow the manual equivalent and state MCP unavailability.
- **Cloud/desktop/CLI environments with Node:** enable the MCP server via project/global config and confirm in the client (e.g. `/mcps` in Kilo TUI).
- If MCP is unavailable, do **not** skip the underlying discipline: read instructions, probe, reason, plan, execute carefully, and verify.
