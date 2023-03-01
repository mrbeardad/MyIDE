<div align="center">

# MyIDE

✨ A guideline for configuring your IDE (vscode and vim/neovim) and your development environment on Windows (WindowsTerminal, PowerShell) and Linux (wsl, tmux, zsh).

![open_issues](https://img.shields.io/github/issues/mrbeardad/MyIDE?style=for-the-badge)
![lisence](https://img.shields.io/github/license/mrbeardad/MyIDE?style=for-the-badge)
![stars](https://img.shields.io/github/stars/mrbeardad/MyIDE?style=for-the-badge)
![tag](https://img.shields.io/gitlab/v/tag/mrbeardad/MyIDE?style=for-the-badge)
![last_commit](https://img.shields.io/github/last-commit/mrbeardad/MyIDE?style=for-the-badge)

:page_facing_up:[中文文档](README-zh.md)

</div>

---

- [MyIDE](#myide)
  - [Windows](#windows)
  - [WSL](#wsl)
  - [VSCode-Neovim](#vscode-neovim)
  - [Language Tools](#language-tools)

## Windows

<div align="center">

ScreenShots

![desktop](images/desktop.png)
![wt_and_ps](images/wt_and_ps.png)

</div>

> [Windows Keybindings](windows.md)

1. Install apps by [Chocolatey](https://chocolatey.org/install)

   ```cmd
   :: in admin
   choco install -y 7zip googlechrome git-fork llvm rust go java python3 nodejs flutter
   ```

   > Tips: This is my choice, choose your preferred apps

2. Install apps by Microsoft Store
   1. Windows Terminal
   2. PowerShell
   3. PowerToys
3. Install [NerdCodeProPlus font](./fonts/)
4. Configure `%USERPROFILE%\.gitconfig`

   ```toml
   [user]
     name = Your Name
     email = user@email.com
   [merge]
     tool = vimdiff
   [mergetool "vimdiff"]
     path = nvim
   ```

5. Configure `%USERPROFILE%\.ssh\config`

   ```conf
   Host github.com
      HostName github.com
      Port 22
      User git
      IdentitiesOnly yes
      IdentityFile ~/.ssh/github.key
   ```

6. Configure Windows Terminal [settings.json](wt/settings.json)
7. Configure PowerShell [$PROFILE](ps/Microsoft.PowerShell_profile.ps1)

   ```pwsh
   # install dependencies before copy config file
   choco install fzf
   cargo install lsd
   Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
   Install-Module PSReadLine
   Install-Module PSFzf
   Install-Module ZLocation
   Install-Module posh-git
   Install-Module git-aliases -AllowClobber
   ```

   > Tips: You can refer to the usage of [zsh](wsl.md)

8. Install [dual-key-remap](https://github.com/ililim/dual-key-remap) to remap CapsLock to Escape when pressed alone and Ctrl when pressed with other keys.

   > Tips: Don't forget to [enable administrator access](https://github.com/ililim/dual-key-remap#administrator-access) or else it doesn't work on administrator applications.

9. Set your system by press `Win`+`I`

10. Install the [cursor theme](https://zhutix.com/tag/cursors/) you like

## WSL

<div align="center">

ScreenShots

![tmux](images/tmux.png)
![zsh_tig](images/zsh_tig.png)
![zsh_ranger](images/zsh_ranger.png)
![btop](images/btop.png)

</div>

> [WSL Keybindings](wsl.md)

1. Install WSL2

   ```cmd
   :: in admin
   wsl --install
   wsl --update
   ```

2. Install [ArchWSL](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/)

   > Tips: ArchWSL is optional, if you like ArchLinux, you can set it as the default distro for wsl by `wsl -s Arch`, or you can just use ubuntu.

3. Limit the [memory usage](https://github.com/microsoft/WSL/issues/4166#issuecomment-526725261) of WSL2, create file `%UserProfile%\.wslconfig` with following content

   ```toml
   [wsl2]
   memory=6GB
   swap=0
   ```

4. Execute the shell script in wsl to configure all the things

   ```sh
   curl -Lo init.sh https://github.com/mrbeardad/MyIDE/raw/master/init.sh
   # execute it directly, don't `bash ./init.sh`
   ./init.sh
   ```

   > Tips: You can open [init.sh](init.sh) to have a look, all configuretion is at the end of script, You can extract thme alone.

## VSCode-Neovim

<div align="center">

ScreenShots

![vim_home](images/vim_home.png)
![vim_plugins](images/vim_plugins.png)
![vim_ide](images/vim_ide.png)
![vsc_ide](images/vsc_ide.png)

</div>

> [VSCode-Neovim Keybindings](vscode-neovim.md)

1. Install VSCode and Neovim

   ```cmd
   choco install neovim --pre
   choco install vscode make
   cargo install ripgrep
   ```

2. Install [Visual Studio](https://visualstudio.microsoft.com/vs/)

   > Tips: VS is optional, for myself, I just want to get the git, cmake and llvm-clang within it, don't forget to add CMake/bin and Llvm/**x64**/bin to system %PATH%

3. Configure Neovim

   1. Install [LunarVim](https://www.lunarvim.org/docs/master/installation)
   2. Copy [config.lua](./neovim/config.lua) to `%LOCALAPPDATA%\lvim\`
   3. Copy [init.vim](./neovim/init.vim) to `%LOCALAPPDATA%\nvim\`
   4. Run `nvim.exe` to install plugins automatically

4. Configure VSCode

   1. Copy [lastSyncextensions.json](vscode/lastSyncextensions.json) to `%APPDATA%\Code\User\sync\extensions\`
   2. Copy [settings.json](vscode/settings.json) and [keybindings.json](vscode/keybindings.json) to `%APPDATA%\Code\User`
   3. Launch VSCode to install plugins automatically

   > Tips: VSCode's config is depend on Neovim's config

## Language Tools

| Lang     | Language Server | Linter         | Formatter    | Syntax | Snippets | Debugger | Build    | Doc     | Test    | Prof       |
| -------- | --------------- | -------------- | ------------ | ------ | -------- | -------- | -------- | ------- | ------- | ---------- |
| C++      | clangd          | clang-tidy     | clang-format | -      | -        | lldb     | CMake    | Doxygen | gtest   | gperftools |
| Go       | gopls           | golangci-lint  | gofmt        | -      | -        | delve    | go-build | swag    | testify | go-prof    |
| Python   | pyright         | pylint, flake8 | yapf         | -      | -        | -        | -        | -       | -       | -          |
| JS       | tsserver        | eslint         | eslint       | -      | -        | -        | -        | -       | -       | -          |
| HTML     | -               | tidy           | prettier     | -      | -        | -        | -        | -       | -       | -          |
| CSS      | -               | stylelint      | prettier     | -      | -        | -        | -        | -       | -       | -          |
| Markdown | -               | markdownlint   | prettier     | -      | -        | -        | -        | -       | -       | -          |

Other references:

- [Language Server](https://microsoft.github.io/language-server-protocol/implementors/servers/)
- [Awesome Linters](https://github.com/caramelomartins/awesome-linters)
