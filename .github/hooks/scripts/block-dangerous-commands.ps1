Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-HookLog([string]$Message) {
  [Console]::Error.WriteLine($Message)
}

try {
  $raw = [Console]::In.ReadToEnd()
  if ([string]::IsNullOrWhiteSpace($raw)) { exit 0 }

  $payload = $raw | ConvertFrom-Json
  $blockMode = if ($env:BLOCK_MODE) { $env:BLOCK_MODE } else { 'log' }
  $toolName = [string]$payload.toolName

  # Only inspect shell/bash tool calls (in-script filter for portability)
  if ($toolName -ne 'bash' -and $toolName -ne 'shell') { exit 0 }

  $toolArgsRaw = $payload.toolArgs
  $command = ''
  if ($null -eq $toolArgsRaw) {
    $command = ''
  } elseif ($toolArgsRaw -is [string]) {
    try {
      $toolArgsObj = $toolArgsRaw | ConvertFrom-Json
      if ($toolArgsObj.PSObject.Properties.Name -contains 'command') { $command = [string]$toolArgsObj.command } else { $command = [string]$toolArgsRaw }
    } catch {
      $command = [string]$toolArgsRaw
    }
  } else {
    if ($toolArgsRaw.PSObject.Properties.Name -contains 'command') { $command = [string]$toolArgsRaw.command } else { $command = [string]($toolArgsRaw | ConvertTo-Json -Compress) }
  }

  $pattern = 'rm -rf /($|\s)|git reset --hard|git clean -fdx?|git push.*--force(-with-lease)?|git checkout -- \.|git restore \.'
  if ($command -match $pattern) {
    $short = if ($command.Length -gt 120) { $command.Substring(0,120) } else { $command }
    if ($blockMode -eq 'deny') {
      @{ permissionDecision = 'deny'; permissionDecisionReason = "Destructive command blocked: $short" } | ConvertTo-Json -Compress
    } else {
      Write-HookLog "HOOK[log]: would block destructive command: $short"
    }
  }
  exit 0
} catch {
  Write-HookLog "block-dangerous-commands hook error: $($_.Exception.Message)"
  exit 1
}
