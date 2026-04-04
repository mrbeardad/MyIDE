$ErrorActionPreference = 'Stop'

try {
  $env:HTTP_PROXY='http://127.0.0.1:7890'
  $env:HTTPS_PROXY='http://127.0.0.1:7890'
  $env:ALL_PROXY='http://127.0.0.1:7890'
  $env:RUST_LOG='off'

  & (Get-ChildItem "C:\Program Files\WindowsApps\OpenAI.Codex_*\app\Codex.exe" | Select-Object -Last 1 -ExpandProperty FullName)
} catch {
  $message = "launch_with_proxy.ps1 failed.`r`n`r`n$($_.Exception.Message)"
  if ($_.ScriptStackTrace) {
    $message += "`r`n`r`n$($_.ScriptStackTrace)"
  }

  $wsh = New-Object -ComObject WScript.Shell
  $null = $wsh.Popup($message, 0, 'Codex Proxy Launcher', 16)
  exit 1
}
