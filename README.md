<div align="center">

# MyIDE

✨ A guideline for configuring lots of tools to build your whole development environment on windows, such as desktop, terminal, shell and editor.

![lisence](https://img.shields.io/github/license/mrbeardad/MyIDE?style=for-the-badge&color=brightgreen)
![stars](https://img.shields.io/github/stars/mrbeardad/MyIDE?style=for-the-badge&color=yellow)
![open_issues](https://img.shields.io/github/issues/mrbeardad/MyIDE?style=for-the-badge&color=orange)
![tag](https://img.shields.io/github/v/tag/mrbeardad/MyIDE?style=for-the-badge)
![last_commit](https://img.shields.io/github/last-commit/mrbeardad/MyIDE?style=for-the-badge&color=blueviolet)

📄[中文文档](README-zh.md)

</div>

---

- [MyIDE](#myide)
  - [Desktop](#desktop)
    - [Installation](#installation)
    - [Usage](#usage)
  - [Terminal](#terminal)
    - [Installation](#installation-1)
    - [Usage](#usage-1)
  - [PowerShell](#powershell)
    - [Installation](#installation-2)
    - [Usage](#usage-2)
  - [WSL](#wsl)
  - [VSCode-Neovim](#vscode-neovim)
  - [Language Tools](#language-tools)

## Desktop

<div align="center">

![desktop](images/desktop.png)

</div>

### Installation

- Install [TranslucentTB](https://apps.microsoft.com/detail/9PF4KZ2VN4W9?hl=en-US&gl=US) : A lightweight utility that makes the Windows taskbar transparent.

- Install [PowerToys](https://apps.microsoft.com/detail/XP89DCGQ3K6VLD?hl=en-us&gl=US) : A set of utilities for power users to tune and streamline their Windows experience for greater productivity.

- Install [Snipaste](https://apps.microsoft.com/detail/9P1WXPKB68KX?hl=en-us&gl=US) : Offers powerful yet easy-to-use snipping, pasting and image annotating functionalities.

- Install [Captura](https://github.com/MathewSachin/Captura) : Capture screen, audio, cursor, mouse clicks and keystrokes.

- Install [dual-key-remap](https://github.com/ililim/dual-key-remap) : Remap CapsLock to Escape when pressed alone and Ctrl when pressed with other keys. Don't forget to [enable administrator access](https://github.com/ililim/dual-key-remap#administrator-access) or else it doesn't work on administrator applications.

- Install a [nerd font](https://www.nerdfonts.com/font-downloads) : A patched font within high number of icons. I've merged two font families into one called [NerdCodePro](./fonts/), so font engines will use different font on regular and italic style.

- Install a [cursor theme](https://zhutix.com/tag/cursors/) you'd like.

- Press `Win`+`I` and check if there are any settings that need to be changed.

### Usage

| Shortcut      | Descript                        |
| ------------- | ------------------------------- |
| `Win`+`E`     | Explorer                        |
| `Win`+`{num}` | Launch app on taskbar           |
| `Win`+`Up`    | Maximize window                 |
| `Win`+`Down`  | Minimize window                 |
| `Win`+`Left`  | Snap window left                |
| `Win`+`Right` | Snap window right               |
| `Alt`+`Tab`   | Switch window                   |
| `Alt`+`F4`    | Close window                    |
| `Alt`+`Space` | Search somthing (PowerToys Run) |

## Terminal

<div align="center">

![desktop](images/terminal.png)

</div>

### Installation

- Install [Windows Terminal](https://apps.microsoft.com/detail/9N0DX20HK701?hl=en-us&gl=US)

- Configure Windows Terminal by pressing `Ctrl`+`Shift`+`,` in terminal window, then overwrite the settings with the [settings.json](./wt/settings.json).

> Tips:
>
> 1. All colorschemes are adjusted to fit both light and dark theme of system.
> 2. The font is set to NerdCodePro that mentioned above, change it if you don't want to use it.

### Usage

| Shortcut            | Description                                               |
| ------------------- | --------------------------------------------------------- |
| `Win`+`` ` ``       | Toggle quake (dropdown) window                            |
| `Alt`+`S`           | Horizontally split the pane                               |
| `Alt`+`V`           | Vertically split the pane                                 |
| `Alt`+`Left`        | Move focus left                                           |
| `Alt`+`Right`       | Move focus right                                          |
| `Alt`+`Up`          | Move focus up                                             |
| `Alt`+`Down`        | Move focus down                                           |
| `MouseSelect`       | Copy                                                      |
| `Alt`+`MouseSelect` | Copy block area                                           |
| `Ctrl`+`Shift`+`V`  | Paste                                                     |
| `Alt`+`T`           | New tab with [btop](https://github.com/aristocratos/btop) |

## PowerShell

<div align="center">

![desktop](images/powershell.png)

</div>

### Installation

- Install [PowerShell](https://apps.microsoft.com/detail/9MZ1SNWT0N5D?hl=en-us&gl=US)

- Install [Scoop](https://scoop.sh/): A package manager to install apps in command line.

- Install the required tools via scoop

  ```pwsh
  scoop install 7zip git aria2 fzf fd ripgrep bat lsd lazygit btop cht tokei
  ```

- Insall PowerShell modules

  ```pwsh
  scoop install oh-my-posh
  Install-Module posh-git
  Install-Module PSFzf
  Install-Module ZLocation
  ```

- Configure PowerShell [`$PROFILE`](ps/Microsoft.PowerShell_profile.ps1) by execute `notepad $PROFILE` in PowerShell command line,
  then overwrite the profile with the [profile.ps1](./ps/Microsoft.PowerShell_profile.ps1)

- Put the [base16_bear theme](./powershell/base16_bear.omp.json) to `%USERPROFILE%\Documents\PowerShell\base16_bear.omp.json`

- Configure `%USERPROFILE%\.gitconfig`

  ```toml
  [user]
    name = Your Name
    email = username@email.com
  [core]
    editor = nvim
  ```

- Configure `%USERPROFILE%\.ssh\config`, thus you can push and pull from github via ssh with url `git@github.com:user/repo`.

  ```conf
  Host github.com
     HostName github.com
     Port 22
     User git
     IdentitiesOnly yes
     IdentityFile ~/.ssh/key.pem
  ```

### Usage

| Shortcut   | Description                                                                |
| ---------- | -------------------------------------------------------------------------- |
| `Esc`      | Vi mode, `v` in vi mode means open `$EDITOR` to edit command               |
| `Ctrl`+`A` | Move to the start of the line                                              |
| `Ctrl`+`E` | Move to the end of the line                                                |
| `Ctrl`+`H` | Delete character left                                                      |
| `Ctrl`+`W` | Delete word left                                                           |
| `Ctrl`+`U` | Delete all left                                                            |
| `Ctrl`+`K` | Delete all right                                                           |
| `Ctrl`+`Z` | Undo                                                                       |
| `Ctrl`+`Y` | Redo                                                                       |
| `Tab`      | Complete command or arguments                                              |
| `Ctrl`+`P` | Last command history with current prefix                                   |
| `Ctrl`+`N` | Next command history with current prefix                                   |
| `Ctrl`+`R` | Fuzzy search command history                                               |
| `Alt`+`A`  | Fuzzy search command argument history                                      |
| `Ctrl`+`T` | Fuzzy search files in current directory                                    |
| `Alt`+`C`  | Fuzzy search directories in current directory                              |
| `z` `name` | Jump to a rencently worked directory whose path contaion `name`            |
| `f`        | Fuzzy search text of files in current directory an open `$EDITOR`          |
| `l`        | List files                                                                 |
| `ch`       | Search for a cheat sheet on [cheat.sh](https://github.com/chubin/cheat.sh) |
| `tokei`    | Count code                                                                 |

| Git Aliases | Git subcommand | Description                                                                                              |
| ----------- | -------------- | -------------------------------------------------------------------------------------------------------- |
| `gst`       | `status`       | Show all changes in workspace and index                                                                  |
| `ga`        | `add`          | Update changes from workspace to index                                                                   |
| `gaa`       | `add`          | Update all changes from workspace to index                                                               |
| `gau`       | `add`          | Update all changes from workspace to index exclude untracked files                                       |
| `grs`       | `restore`      | Restore workspace from index **(default)** or a commit                                                   |
| `gstl`      | `stash`        | Show stashes                                                                                             |
| `gsta`      | `stash`        | Stash all changes in workspace and index                                                                 |
| `gstp`      | `stash`        | Restore the changes from stash and delete it **(default last)**                                          |
| `gstaa`     | `stash`        | Restore the changes from stash **(default last)**                                                        |
| `gstd`      | `stash`        | Delete stash **(default last)**                                                                          |
| `gc`        | `commit`       | Add a new commit from index                                                                              |
| `gc!`       | `commit`       | Add a new commit base on grandparent commit and move HEAD to it (like overwrite but keep history commit) |
| `glg`       | `log`          | Show commit and its ancestry, revision form like `HEAD^`                                                 |
| `grlg`      | `reflog`       | Show commits of HEAD history, revision form like `@{1}`                                                  |
| `gd`        | `diff`         | Show changes **(default between workspace and index)**                                                   |
| `gdt`       | `difftool`     | Show changes **(default between workspace and index)** by `nvim`                                         |
| `gmt`       | `mergetool`    | Resolve conflicts by `nvim`                                                                              |
| `gm`        | `merge`        | Merge a commit to HEAD, and do not allow fast forward                                                    |
| `gmc`       | `merge`        | Continue merge                                                                                           |
| `gms`       | `merge`        | Skip current patch and continue merge                                                                    |
| `gma`       | `merge`        | Abort merge                                                                                              |
| `grb`       | `rebase`       | Rebase HEAD **(default)** or commit onto a commit                                                        |
| `grbc`      | `rebase`       | Continue rebase                                                                                          |
| `grbs`      | `rebase`       | Skip current patch and continue rebase                                                                   |
| `grba`      | `rebase`       | Abort rebase                                                                                             |
| `gcp`       | `cherry-pick`  | Apply change in a commit to HEAD                                                                         |
| `gcpc`      | `cherry-pick`  | Continue cherry pick                                                                                     |
| `gcps`      | `cherry-pick`  | Skip current patch and continue cherry pick                                                              |
| `gcpa`      | `cherry-pick`  | Abort cherry pick                                                                                        |
| `grv`       | `revert`       | Revert a commit to HEAD                                                                                  |
| `grvc`      | `revert`       | Continue revert                                                                                          |
| `grvs`      | `revert`       | Skip current patch and continue revert                                                                   |
| `grva`      | `revert`       | Abort revert                                                                                             |
| `grh`       | `reset`        | Reset HEAD to a commit and keep all the changes in workspace and index                                   |
| `grhh`      | `reset`        | Reset HEAD to a commit and do not keep the changes                                                       |
| `gbl`       | `branch`       | Show branches                                                                                            |
| `gb`        | `branch`       | Add new branch at HEAD **(default)** or commit                                                           |
| `gcb`       | `checkout`     | Add new branch at HEAD **(default)** or commit and checkout it                                           |
| `gcb!`      | `checkout`     | Add new branch at HEAD **(default)** or commit (overwrite exist) and checkout it                         |
| `gbu`       | `branch`       | Set upstream of HEAD                                                                                     |
| `gbrn`      | `branch`       | Rename branch at HEAD **(default)** or commit                                                            |
| `gbrn!`     | `branch`       | Rename branch at HEAD **(default)** or commit (overwrite exist)                                          |
| `gbd`       | `branch`       | Delete merged branch                                                                                     |
| `gbd!`      | `branch`       | Delete branch even if not merged                                                                         |
| `gco`       | `checkout`     | Checkout target commit                                                                                   |
| `gcor`      | `checkout`     | Checkout target commit recursively                                                                       |
| `gr`        | `remote`       | Remote                                                                                                   |
| `grl`       | `remote`       | List remotes                                                                                             |
| `gra`       | `remote`       | Add remote                                                                                               |
| `grrn`      | `remote`       | Rename remote                                                                                            |
| `gru`       | `remote`       | Set thr url of remote                                                                                    |
| `grd`       | `remote`       | Delete remote                                                                                            |
| `gf`        | `fetch`        | Fetch remotes                                                                                            |
| `gl`        | `pull`         | Pull remotes and rebase, and automatically stash push and pop before and after                           |
| `gp`        | `push`         | Push a ref to remote                                                                                     |
| `gp!`       | `push`         | Push a ref to remote (`--force-with-lease`)                                                              |
| `gp!!`      | `push`         | Push a ref to remote (`--force`)                                                                         |
| `gcl`       | `clone`        | Clone remote                                                                                             |
| `gclr`      | `clone`        | Clone remote recursively                                                                                 |
| `gsa`       | `submodule`    | Add a submodule                                                                                          |
| `gsu`       | `submodule`    | Init and update submodules to expected version. To modify submodule,                                     |
| `gsd`       | `submodule`    | Delete a submodule                                                                                       |
| `lg`        |                | Open [Lazygit](https://github.com/jesseduffield/lazygit)                                                 |

> Tips:
>
> 1. You don't need to remenber all the git aliases, use your favorite git UI tool instead, such as lazygit, fork or gitkraken. The git aliases list above is just to tell you the basic git operations you should know.
> 2. You could use my [config.yml](./lazygit/config.yml) if you choose lazygit, put it to `%APPDATA%\lazygit\config.yml`
> 3. Highly recommended for this [blog post](https://nvie.com/posts/a-successful-git-branching-model/) about git flow.

<!-- TODO: zellij -->

## WSL

<div align="center">

ScreenShots

![tmux](images/tmux.png)
![zsh_tig](images/zsh_tig.png)
![zsh_ranger](images/zsh_ranger.png)
![btop](images/btop.png)

</div>

1. Install WSL2

   ```pwsh
   # in admin
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
   # in wsl
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

1. Install Neovim and dependencies

   ```cmd
   scoop install neovim-nightly ripgrep make python nodejs rustup go flutter
   ```

   > Tips: The packages after rustup (include) are optional.

2. Install [Visual Studio](https://visualstudio.microsoft.com/vs/)

   > Tips: Check the option of clang and cmake and add
   > `C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\Llvm\x64\bin` and
   > `C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin`
   > to environment variable `PATH`

3. Configure Neovim

   1. Install nightly version of [LunarVim](https://www.lunarvim.org/docs/master/installation)
   2. Copy [config.lua](./neovim/config.lua) to `%LOCALAPPDATA%\lvim\`
   3. Copy [init.vim](./neovim/init.vim) to `%LOCALAPPDATA%\nvim\`
   4. Run `nvim.exe` to install plugins automatically

4. Configure VSCode

   1. Copy [lastSyncextensions.json](vscode/lastSyncextensions.json) to `%APPDATA%\Code\User\sync\extensions\`
   2. Copy [settings.json](vscode/settings.json) and [keybindings.json](vscode/keybindings.json) to `%APPDATA%\Code\User`
   3. Launch VSCode to install plugins automatically

   > Tips: VSCode's config is depend on Neovim's config

## Language Tools

| Lang       | Language Server | Linter        | Formatter    | Syntax | Snippets | Debugger | Build    | Doc     | Test    | Prof       |
| ---------- | --------------- | ------------- | ------------ | ------ | -------- | -------- | -------- | ------- | ------- | ---------- |
| C++        | clangd          | clang-tidy    | clang-format | -      | -        | lldb     | CMake    | Doxygen | gtest   | gperftools |
| Go         | gopls           | golangci-lint | gofmt        | -      | -        | delve    | go-build | swag    | testify | go-prof    |
| Python     | pyright         | ruff          | black        | -      | -        | -        | -        | -       | -       | -          |
| JavaScript | tsserver        | eslint        | prettier     | -      | -        | -        | -        | -       | -       | -          |
| HTML       | -               | tidy          | prettier     | -      | -        | -        | -        | -       | -       | -          |
| CSS        | -               | stylelint     | prettier     | -      | -        | -        | -        | -       | -       | -          |
| Markdown   | -               | markdownlint  | prettier     | -      | -        | -        | -        | -       | -       | -          |

Other references:

- [Language Server](https://microsoft.github.io/language-server-protocol/implementors/servers/)
- [Awesome Linters](https://github.com/caramelomartins/awesome-linters)
