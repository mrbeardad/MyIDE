oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/powerlevel10k_rainbow.omp.json" | Invoke-Expression

Import-Module PSReadLine
Set-PsReadLineOption -EditMode Vi
$OnViModeChange = [scriptblock]{
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $OnViModeChange
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+w -Function BackwardKillWord
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+k -Function KillLine
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+y -Function Undo
Set-PSReadLineKeyHandler -ViMode Insert -Key Ctrl+v -Function Paste
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key Ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Ctrl+n -Function HistorySearchForward

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r' -PSReadlineChordSetLocation 'Alt+c'
Set-Alias j Set-ZLocation
Function d {Set-Location -Path -}
Function .. {Set-Location -Path ..}
Function ... {Set-Location -Path ..\..}
Function l {lsd -lah --group-dirs first $args}
Function l. {lsd -lhd --group-dirs first .*}
Function ll {lsd -lh --group-dirs first}

Import-Module git-aliases -DisableNameChecking
Import-Module posh-git
Function gmv {git mv $args}
Function grm {git rm $args}
Function grss {git restore --staged $args}
Function gdi {git diff-index --name-status $args}
Function gds {git diff --staged $args}
Function gdt {git difftool --tool=vimdiff $args}
Function gdts {git difftool --tool=vimdiff --staged $args}
Function grev {git revert $args}
Function gt {git tag $args}
Function gbv {git branch -a -vv $args}
Function gbsup {git branch --set-upstream-to $args}
Function gbd {git branch --delete $args}
Function gco {git checkout --recurse-submodules $args}
Function gmt {git mergetool --tool=vimdiff $args}
Function gma {git merge --abort $args}
Function gmc {git merge --continue $args}
Function glr {git pull --rebase $args}
Function glra {git pull --rebase --auto-stash $args}
Function gsa {git submodule add $args}
Function gsu {git submodule update --init --recursive $args}
Function gsrm {
  git submodule deinit -f $args
  git rm -f $args
}

Set-Alias vi nvim

Function ProxyEnable {
  $env:HTTPS_PROXY="http://127.0.0.1:7890"
  $env:HTTP_PROXY="http://127.0.0.1:7890"
  $env:ALL_PROXY="socks5://127.0.0.1:7890"
}
Function ProxyDisanable {
  $env:HTTPS_PROXY=""
  $env:HTTP_PROXY=""
  $env:ALL_PROXY=""
}
