$ErrorActionPreference = 'Stop'

try {
    [Environment]::SetEnvironmentVariable('HTTP_PROXY', 'http://127.0.0.1:7890', 'User')
    [Environment]::SetEnvironmentVariable('HTTPS_PROXY', 'http://127.0.0.1:7890', 'User')
    [Environment]::SetEnvironmentVariable('ALL_PROXY', 'http://127.0.0.1:7890', 'User')
    [Environment]::SetEnvironmentVariable('RUST_LOG', 'off', 'User')

    Start-Process 'shell:AppsFolder\OpenAI.Codex_2p2nqsd0c76g0!App'
}
catch {
    $message = "launch_with_proxy.ps1 failed.`r`n`r`n$($_.Exception.Message)"
    if ($_.ScriptStackTrace) {
        $message += "`r`n`r`n$($_.ScriptStackTrace)"
    }

    $wsh = New-Object -ComObject WScript.Shell
    $null = $wsh.Popup($message, 0, 'Codex Proxy Launcher', 16)
    exit 1
}
