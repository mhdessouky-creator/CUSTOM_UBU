# Workspace Constraints

This document records environment and repository constraints that agents must respect.

## Project identity
- **Project/environment name:** `kilo-opts` (repository content and governance identity).
- **Git remote:** `origin` = `https://github.com/mhdessouky-creator/CUSTOM_UBU.git` (external repository name may still be `CUSTOM_UBU`; changing it on GitHub is outside this workspace).
- **Current working branch (this session):** `kilo/cool-data-6ot`.

## Git and branch constraints (Cloud environment)
- Stay on the branch the session started on. Do **not** create or switch branches unless explicitly requested and permitted.
- Do not rename branches or rewrite history implicitly.
- Commit/push only when requested or clearly part of the approved task; when committing/pushing, keep work on the session branch so history/PRs stay linked.
- This environment is a sandboxed cloud container; filesystem changes outside committed/pushed repo state may not persist across sessions.

## Repository boundaries
- Treat the following as **legacy/out-of-scope unless explicitly requested** (user may remove manually later): `termux-build/`, `.kilo/plans/1794629698409-termux-ubuntu-milestone-a-bootstrap-plan.md`.
- Do not delete, rewrite, or “clean up” legacy/out-of-scope paths implicitly.
- Prefer additive, scoped changes aligned to the `kilo-opts` governance structure.

## Platform and tooling constraints
- **Kilo mobile app:** cannot spawn/run local stdio MCP servers (no local `npx`/Node process from the app). Mobile sessions should rely on repo instructions (`AGENTS.md`, `docs/`) and any capabilities provided by the active environment; full local Kilo-Kit MCP tooling requires a Node-capable environment (desktop CLI/TUI or compatible cloud/workspace).
- **Kilo-Kit MCP (local stdio):** configured in `.kilo/kilo.json` as `npx -y @vodailocz/kilo-kit-mcp`; requires Node.js >= 20 and network access on first fetch in environments that run it.
- **Verification in this environment:** may be limited to structural/document checks and available commands; report what was and was not verified.

## Configuration and instruction files
- **Kilo project config:** `.kilo/kilo.json` (and `kilo.json`/`kilo.jsonc` if present) — keep valid and minimal.
- **Authoritative agent contract:** `AGENTS.md` (Kilo reads `AGENTS.md` as project instructions).
- **Aligned mirrors:** `CLAUDE.md`, `GEMINI.md` must remain consistent with `AGENTS.md`.
- **Governance docs:** `docs/` defines operating model, instructions, protocol, and architecture decisions.

## Safety
- Do not invent evidence, command results, or external state.
- Do not expose or commit secrets/credentials.
- Prefer reversible, well-documented changes; surface risks and manual follow-ups clearly.
