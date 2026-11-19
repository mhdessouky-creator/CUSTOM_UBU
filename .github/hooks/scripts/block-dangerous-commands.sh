#!/usr/bin/env bash
set -euo pipefail

# Dependency check
if ! command -v jq >/dev/null 2>&1; then
  echo "block-dangerous-commands: jq is required but not installed" >&2
  exit 1
fi

payload="$(cat)"
block_mode="${BLOCK_MODE:-log}"
tool_name="$(printf '%s' "$payload" | jq -r '.toolName // empty')"

# Only inspect shell/bash tool calls (in-script filter for portability)
[[ "$tool_name" != "bash" && "$tool_name" != "shell" ]] && exit 0

tool_args_raw="$(printf '%s' "$payload" | jq -r '.toolArgs // "{}"')"
command=""
if printf '%s' "$tool_args_raw" | jq -e . >/dev/null 2>&1; then
  command="$(printf '%s' "$tool_args_raw" | jq -r '.command // ""')"
else
  command="$tool_args_raw"
fi

if printf '%s' "$command" | grep -qE 'rm -rf /($|[[:space:]])|git reset --hard|git clean -fdx?|git push.*--force(-with-lease)?|git checkout -- \.|git restore \.'; then
  # Truncate command to avoid leaking secrets in deny reason or logs
  short_cmd="$(printf '%.120s' "$command")"
  if [[ "$block_mode" == "deny" ]]; then
    jq -cn --arg reason "Destructive command blocked: ${short_cmd}" \
      '{permissionDecision:"deny",permissionDecisionReason:$reason}'
  else
    echo "HOOK[log]: would block destructive command: ${short_cmd}" >&2
  fi
fi
exit 0
