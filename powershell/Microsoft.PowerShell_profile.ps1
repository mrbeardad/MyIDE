# =============
# PSReadLine
# =============
# Show different cursor shape in different vi mode
$env:PoshDefaultCursorShape = "`e[3 q" # blinking underscore, used in prompt theme
$OnViModeChange = {
  if ($args[0] -eq "Command") {
    Write-Host -NoNewLine "`e[1 q" # blinking block
  } else {
    Write-Host -NoNewLine $env:PoshDefaultCursorShape 
  }
}
$env:EDITOR = "nvim"
Set-Alias vi nvim
Set-PsReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $OnViModeChange
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+w -Function BackwardKillWord
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+k -Function KillLine
Set-PSReadlineKeyHandler -ViMode Insert -Key Tab -Function MenuComplete
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+n -Function HistorySearchForward
Set-PSReadLineKeyHandler -ViMode Insert -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -ViMode Insert -Key DownArrow -Function HistorySearchForward

# =============
# posh-git
# =============
function RegisterGit {
  Invoke-Expression -Command "function global:$($args[0]) { git $($args[1]) @args }"
  $tab = [Scriptblock]::Create("
    param(`$wordToComplete, `$commandAst, `$cursorPosition)
    `$cmdline = `$commandAst.ToString().Replace(`"$($args[0])`", `"`")
    if (`$wordToComplete.Length -ne 0) { `$tail = '' } else { `$tail = ' ' }
    Expand-GitCommand `"git $($args[1]) `$cmdline`$tail`"
  ")
  Register-ArgumentCompleter -CommandName $args[0] -ScriptBlock $tab
}

Set-Alias g git
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

# Import posh-git after aliases
Import-Module posh-git

# Remove aliases after import posh-git
Remove-Alias gc -Force -ErrorAction SilentlyContinue
Remove-Alias gcb -Force -ErrorAction SilentlyContinue
Remove-Alias gl -Force -ErrorAction SilentlyContinue
Remove-Alias gm -Force -ErrorAction SilentlyContinue
Remove-Alias gp -Force -ErrorAction SilentlyContinue

# =============
# PSFzf
# =============
$env:FZF_CTRL_T_COMMAND = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
$env:FZF_ALT_C_COMMAND = "fd --type d --strip-cwd-prefix --hidden --follow --exclude .git"
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-Alias f Invoke-PsFzfRipgrep

# =============
# Utils
# =============
function .. { Set-Location -Path .. }
function ... { Set-Location -Path ..\.. }
function l { lsd -lAg --group-directories-first @args }
function tree { lsd -A --tree --group-directories-first -I .git @args }
function du { gdu @args }
function ch { cht -Q @args }
Set-Alias lg lazygit

$env:DefaultProxyAddress = "127.0.0.1:7890"
function proxy {
  if (-not $args[0]) {
    echo "HTTPS_PROXY: $env:HTTPS_PROXY"
    echo "HTTP_PROXY: $env:HTTP_PROXY"
    echo "ALL_PROXY: $env:ALL_PROXY"
  } elseif ($args[0] -eq "enable") {
    if ($env:DefaultProxyAddress) {
      $env:HTTPS_PROXY=$env:DefaultProxyAddress
      $env:HTTP_PROXY=$env:DefaultProxyAddress
      $env:ALL_PROXY=$env:DefaultProxyAddress
      echo "set proxy to $env:DefaultProxyAddress"
    } else {
      echo "`$env:DefaultProxyAddress is empty"
    }
  } elseif ($args[0] -eq "disable") {
    $env:HTTPS_PROXY=""
    $env:HTTP_PROXY=""
    $env:ALL_PROXY=""
    echo "disabled proxy"
  } else {
    $env:HTTPS_PROXY=$args[0]
    $env:HTTP_PROXY=$args[0]
    $env:ALL_PROXY=$args[0]
    echo "set proxy to $($args[0])"
  }
}

# =============
# Oh My Posh
# =============
# Import oh-my-posh after PSReadline to ensure transient_prompt works properly in vi mode
oh-my-posh init pwsh --config "$HOME\Documents\PowerShell\base16_bear.omp.json" | Invoke-Expression
# The integrated terminal in neovim and vscode has bug with unicode
if ($env:NVIM -or $env:VSCODE_INJECTION) {
  oh-my-posh toggle sysinfo
  oh-my-posh toggle time
}
