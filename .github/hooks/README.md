# Hooks (`.github/hooks`)

Portable hook configuration for this repository, intended to work with Kilo and other agents/hosts that support lifecycle hooks when loading this GitHub repo/branch.

## Contents
- `block-dangerous-commands.json` — `preToolUse` guardrail example (Bash/PowerShell scripts).
- `scripts/block-dangerous-commands.sh` / `.ps1` — cross-platform script pair.
- See [`../instructions/hooks.instructions.md`](../instructions/hooks.instructions.md) for full authoring guidelines, payload schemas, and examples.

## Default behavior
`BLOCK_MODE` is set to `log` (observe-first). To enforce blocking, change it to `deny` in the hook config `env`.

## Requirements
- Bash script requires `jq` and a Bash-compatible shell.
- PowerShell script requires PowerShell (`pwsh` or Windows PowerShell).
- Host/agent must support loading hooks from this location and the events/fields used.

## Notes
- Hooks run in the agent/tool critical path: keep them fast, deterministic, and non-interactive.
- Do not mutate git state or perform hidden network operations by default.
- Validate behavior in your target agent environment (Kilo/CLI/IDE/cloud) before relying on enforcement.
