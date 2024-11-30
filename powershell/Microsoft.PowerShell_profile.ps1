# =============
# PSReadLine
# =============
# blinking underscore, and prompt command start, this will be used in prompt theme
$Global:PsReadLineViMode = "i"
$PsReadLineViInsertModeCursor = "`e[3 q" # blinking underline
$PsReadLineViNormalModeCursor = "`e[1 q" # blinking block
# Show different cursor shape in different vi mode
$OnViModeChange = {
  if ($args[0] -ne "Command") {
    Write-Host -NoNewLine $PsReadLineViInsertModeCursor
    $Global:PsReadLineViMode = "i"
  } else {
    Write-Host -NoNewLine $PsReadLineViNormalModeCursor
    $Global:PsReadLineViMode = "n"
  }
}
$env:EDITOR = "nvim"
Set-Alias v nvim
Set-PsReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $OnViModeChange
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
$PSStyle.Formatting.FormatAccent = "`e[92;1m"
$PSStyle.Formatting.ErrorAccent = "`e[91;1m"
Set-PSReadLineOption -Colors @{
  Comment="`e[90;3m" # italic bright black
  Keyword="`e[95;1m" # bold bright magenta
  Operator="`e[97;1m" # bright white
  Parameter="`e[97;1m" # bright white
  String="`e[36;3m" # italic cyan
  Type="`e[33m" # yellow
  Variable="`e[96m" # bright cyan
}
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+h -Function BackwardDeleteChar
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+w -Function BackwardKillWord
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+k -Function KillLine
Set-PSReadLineKeyHandler -ViMode Insert -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+n -Function HistorySearchForward

# =============
# PSFzf
# =============
$env:FZF_DEFAULT_OPTS = "--height=50% --min-height=8 --layout=reverse --info=right --scrollbar='▐'"
$env:FZF_CTRL_T_COMMAND = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
$env:FZF_ALT_C_COMMAND = "fd --type d --strip-cwd-prefix --hidden --follow --exclude .git"
# Refer to https://github.com/kelleyma49/PSFzf/issues/202#issuecomment-2495321758
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+t -ScriptBlock {
  $Global:CursorTopBeforePSFzf = [Console]::CursorTop
  Invoke-FzfPsReadlineHandlerProvider
}
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+r -ScriptBlock {
  $Global:CursorTopBeforePSFzf = [Console]::CursorTop
  Invoke-FzfPsReadlineHandlerHistory
}
Set-PSReadLineKeyHandler -ViMode Insert -Key Alt-c -ScriptBlock {
  $Global:CursorTopBeforePSFzf = [Console]::CursorTop
  Invoke-FzfPsReadlineHandlerSetLocation
}
Set-PSReadLineKeyHandler -ViMode Insert -Key Alt-a -ScriptBlock {
  $Global:CursorTopBeforePSFzf = [Console]::CursorTop
  Invoke-FzfPsReadlineHandlerHistoryArgs
}
Set-PSReadLineKeyHandler -ViMode Insert -Key Tab -ScriptBlock {
  $Global:CursorTopBeforePSFzf = [Console]::CursorTop
  Invoke-FzfTabCompletion
}
Set-Alias fs Invoke-FuzzyScoop

# =============
# posh-git
# =============
function RegisterGit {
  Invoke-Expression -Command "function global:Invoke-Git_$($args[0]) { git $($args[1]) @args }"
  Invoke-Expression -Command "Set-Alias -Force -Scope Global $($args[0]) Invoke-Git_$($args[0])"
  $tab = [Scriptblock]::Create("
    param(`$wordToComplete, `$commandAst, `$cursorPosition)
    `$cmdline = `$commandAst.ToString().Replace(`"$($args[0])`", `"`")
    if (`$wordToComplete.Length -ne 0) { `$tail = '' } else { `$tail = ' ' }
    Expand-GitCommand `"git $($args[1]) `$cmdline`$tail`"
  ")
  Register-ArgumentCompleter -CommandName $args[0] -ScriptBlock $tab
}

Register-ArgumentCompleter -CommandName git -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  Expand-GitCommand "$commandAst.ToString()"
}
RegisterGit gst "status --short --branch --show-stash --ahead-behind"
RegisterGit ga "add"
RegisterGit gaa "add --all"
RegisterGit gau "add --update"
RegisterGit gcln "clean"
RegisterGit grs "restore"
RegisterGit gsta "stash push"
RegisterGit gstl "stash list"
RegisterGit gstp "stash pop"
RegisterGit gstaa "stash apply"
RegisterGit gstd "stash drop"
RegisterGit gc "commit -v"
RegisterGit gc! "commit -v --amend"
RegisterGit glg "log"
RegisterGit grlg "reflog"
RegisterGit gd "diff"
RegisterGit gdt "difftool --tool=nvimdiff"
RegisterGit gmt "mergetool --tool=nvimdiff"
RegisterGit gm "merge --no-ff"
RegisterGit gmc "merge --continue"
RegisterGit gms "merge --skip"
RegisterGit gma "merge --abort"
RegisterGit grb "rebase"
RegisterGit grbc "rebase --continue"
RegisterGit grbs "rebase --skip"
RegisterGit grba "rebase --abort"
RegisterGit gcp "cherry-pick"
RegisterGit gcpc "cherry-pick --continue"
RegisterGit gcps "cherry-pick --skip"
RegisterGit gcpa "cherry-pick --abort"
RegisterGit grv "revert"
RegisterGit grvc "revert --continue"
RegisterGit grvs "revert --skip"
RegisterGit grva "revert --abort"
RegisterGit grh "reset"
RegisterGit grhh "reset --hard"
RegisterGit gbl "branch --list --all -vv"
RegisterGit gb "branch"
RegisterGit gcb "checkout -b"
RegisterGit gcb! "checkout -B"
RegisterGit gbu "branch --set-upstream-to"
RegisterGit gbrn "branch -m"
RegisterGit gbrn! "branch -M"
RegisterGit gbd "branch -d"
RegisterGit gbd! "branch -D"
RegisterGit gco "checkout"
RegisterGit gcor "checkout --recurse-submodules"
RegisterGit gr "remote"
RegisterGit grl "remote -v"
RegisterGit gra "remote add"
RegisterGit grrn "remote rename"
RegisterGit gru "remote set-url"
RegisterGit grd "remote remove"
RegisterGit gf "fetch"
RegisterGit gl "pull --rebase --autostash"
RegisterGit gp "push"
RegisterGit gp! "push --force-with-lease"
RegisterGit gp!! "push --force"
RegisterGit gcl "clone"
RegisterGit gclr "clone --recurse-submodules"
RegisterGit gsa "submodule add"
RegisterGit gsu "submodule update --init --recursive"
RegisterGit gsd "submodule deinit"

# =============
# Utils
# =============
function l { lsd -lAg --group-directories-first @args }
function tree { lsd -A --tree --group-directories-first -I .git @args }
function .. { Set-Location -Path .. }
function ... { Set-Location -Path ..\.. }
function .... { Set-Location -Path ..\..\.. }
Set-Alias lg lazygit
Set-Alias gmm Get-Member

# Get .gitignore template, e.g.: `gig cpp,windows` write a template to ./.gitignore
function gig {
  $params = ($args | ForEach-Object { [uri]::EscapeDataString($_) }) -join ","
  Invoke-WebRequest -Uri "https://www.toptal.com/developers/gitignore/api/$params" |
    Select-Object -ExpandProperty content |
    Out-File -FilePath $(Join-Path -path $pwd -ChildPath ".gitignore") -Encoding ascii
}

function Set-Proxy {
  param(
    [uri]$proxyAddress
  )

  if ($proxyAddress -ne $null) {
    $env:HTTP_PROXY=$proxyAddress
    $env:HTTPS_PROXY=$proxyAddress
    $env:ALL_PROXY=$proxyAddress
  } elseif ($env:HTTP_PROXY.Length -gt 0) {
    $env:HTTP_PROXY=''
    $env:HTTPS_PROXY=''
    $env:ALL_PROXY=''
  } else {
    $env:HTTP_PROXY='http://127.0.0.1:7890'
    $env:HTTPS_PROXY='http://127.0.0.1:7890'
    $env:ALL_PROXY='http://127.0.0.1:7890'
  }
}
Set-Alias px Set-Proxy

# =============
# Oh My Posh
# =============
# Import oh-my-posh after PSReadline to ensure transient_prompt works properly in vi mode
oh-my-posh init pwsh --config "$HOME\Documents\PowerShell\base16_bear.omp.json" | Invoke-Expression
# Shell integration https://learn.microsoft.com/en-us/windows/terminal/tutorials/shell-integration#how-does-this-work
$Global:__OriginalPrompt = $function:Prompt
function prompt {
  # Place at beginning of function to avoid oh-my-posh get the wrong last error code
  $out = $Global:__OriginalPrompt.Invoke()[0];

  # Transient prompt
  if ($out[-1] -eq "`b") {
    return $out
  }

  # Reset the cursor to the correct shape
  if ($Global:PsReadLineViMode -eq "i") {
    $out += $PsReadLineViInsertModeCursor
  } else {
    $out += $PsReadLineViNormalModeCursor
  }

  # Repair the cursor position and console mode after PSFzf
  # $Global:CursorTopBeforePSFzfInvokePromptHack = [Console]::CursorTop
  # $Global:CursorTopBeforePSFzfInvokePromptHack = $null
  if ($null -ne $Global:CursorTopBeforePSFzfInvokePromptHack) {
    [Console]::SetCursorPosition(0, $Global:CursorTopBeforePSFzfInvokePromptHack - ($Global:CursorTopBeforePSFzf - [Console]::CursorTop))
    $Global:Kernel32 ??= Add-Type -Name 'Kernel32' -Namespace 'Win32' -PassThru -MemberDefinition '[DllImport("kernel32.dll", SetLastError = true)] public static extern IntPtr GetStdHandle(int nStdHandle); [DllImport("kernel32.dll", SetLastError = true)] public static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode); [DllImport("kernel32.dll", SetLastError = true)] public static extern bool SetConsoleMode(IntPtr hConsoleHandle, uint lpMode);'
    $Global:Kernel32::SetConsoleMode($Global:Kernel32::GetStdHandle(-11), 0x7) | Out-Null
  }

  return $out
}

# =============
# Zoxide
# =============
# Import after oh-my-posh
function z {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
  & $Function:__zoxide_z @args
}
function zi {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
  & $Function:__zoxide_zi @args
}
