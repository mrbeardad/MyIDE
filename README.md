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
    - [Desktop Installation](#desktop-installation)
    - [Desktop Usage](#desktop-usage)
  - [Terminal](#terminal)
    - [Terminal Installation](#terminal-installation)
    - [Terminal Usage](#terminal-usage)
  - [PowerShell](#powershell)
    - [PowerShell Installation](#powershell-installation)
    - [PowerShell Usage](#powershell-usage)
  - [VSCode-Neovim](#vscode-neovim)

## Desktop

<div align="center">

![desktop](images/desktop.png)

</div>

### Desktop Installation

- Install [TranslucentTB](https://apps.microsoft.com/detail/9PF4KZ2VN4W9?hl=en-US&gl=US) : A lightweight utility that makes the Windows taskbar transparent.

- Install [PowerToys](https://apps.microsoft.com/detail/XP89DCGQ3K6VLD?hl=en-us&gl=US) : A set of utilities for power users to tune and streamline their Windows experience for greater productivity.

- Install [Snipaste](https://apps.microsoft.com/detail/9P1WXPKB68KX?hl=en-us&gl=US) : Offers powerful yet easy-to-use snipping, pasting and image annotating functionalities.

- Install [Captura](https://github.com/MathewSachin/Captura) : Capture screen, audio, cursor, mouse clicks and keystrokes.

- Install [dual-key-remap](https://github.com/ililim/dual-key-remap) : Remap CapsLock to Escape when pressed alone and Ctrl when pressed with other keys. Don't forget to [enable administrator access](https://github.com/ililim/dual-key-remap#administrator-access) or else it doesn't work on administrator applications.

- Install a [nerd font](https://www.nerdfonts.com/font-downloads) : A patched font within high number of icons. I've merged two font families into one called [NerdCodePro](./fonts/), so font engines will use different font on regular and italic style.

- Install a [cursor theme](https://zhutix.com/tag/cursors/) you'd like.

- Press `Win`+`I` and check if there are any settings that need to be changed.

### Desktop Usage

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
| `Win`+`D`     | Show/Hide desktop               |
| `Win`+`,`     | Peek desktop                    |
| `Win`+`L`     | Lock desktop                    |
| `Win`+`;`     | Emoji                           |
| `Alt`+`Space` | Search somthing (PowerToys Run) |

## Terminal

<div align="center">

![desktop](images/terminal.png)

</div>

### Terminal Installation

- Install [Windows Terminal](https://apps.microsoft.com/detail/9N0DX20HK701?hl=en-us&gl=US)

- Configure Windows Terminal by pressing `Ctrl`+`Shift`+`,` in terminal window, you could refer to my [settings.json](./wt/settings.json).

- (Optional) Set Windows Terminal to high performance graphics usage.

> Tips:
>
> 1. All colorschemes are adjusted to fit both light and dark theme of system.
> 2. The font is set to NerdCodePro that mentioned above, change it if you don't want to use it.

### Terminal Usage

| Shortcut               | Description                                               |
| ---------------------- | --------------------------------------------------------- |
| `Win`+`` ` ``          | Toggle quake (dropdown) window                            |
| `Ctrl`+`Shift`+`{num}` | New tab with profile `{num}`                              |
| `Ctrl`+`Shift`+`T`     | New tab with [btop](https://github.com/aristocratos/btop) |
| `Ctrl`+`Shift`+`W`     | Close tab                                                 |
| `Alt`+`Shift`+`s`      | Horizontally split the pane                               |
| `Alt`+`Shift`+`v`      | Vertically split the pane                                 |
| `Alt`+`Left`           | Move focus left                                           |
| `Alt`+`Right`          | Move focus right                                          |
| `Alt`+`Up`             | Move focus up                                             |
| `Alt`+`Down`           | Move focus down                                           |
| `MouseSelect`          | Copy                                                      |
| `Shift`+`MouseSelect`  | Incremental Copy                                          |
| `Alt`+`MouseSelect`    | Copy block area                                           |
| `Ctrl`+`Shift`+`V`     | Paste                                                     |
| `Ctrl`+`Shift`+`F`     | Search                                                    |

## PowerShell

<div align="center">

![desktop](images/powershell.png)

</div>

### PowerShell Installation

- Install [PowerShell](https://apps.microsoft.com/detail/9MZ1SNWT0N5D?hl=en-us&gl=US)

- Install [Scoop](https://scoop.sh/): A package manager to install apps in command line.

- Install the required tools via scoop

  ```ps1
  scoop install 7zip git aria2
  scoop install lsd fzf fd ripgrep bat sed gawk lazygit btop cht tokei gdu everything sysinternals
  ```

- Insall PowerShell modules

  ```ps1
  scoop install oh-my-posh
  Install-Module posh-git
  Install-Module PSFzf
  Install-Module ZLocation
  ```

- Configure PowerShell [`$PROFILE`](ps/Microsoft.PowerShell_profile.ps1) by execute `notepad $PROFILE` in PowerShell command line,
  then overwrite the profile with the [profile.ps1](./ps/Microsoft.PowerShell_profile.ps1)

- Copy the [prompt theme](./powershell/base16_bear.omp.json) to `%USERPROFILE%\Documents\PowerShell\base16_bear.omp.json`

- Configure `%USERPROFILE%\.gitconfig`

  ```toml
  [user]
    name = Your Name
    email = username@email.com
  [core]
    editor = nvim
  [diff]
    tool = nvimdiff
  ```

- Configure `%USERPROFILE%\.ssh\config`, thus you can push and pull from github via ssh with url `git@github.com:user/repo`. Of course, you need to add your own ssh public key to github first

  ```txt
  Host github.com
     Hostname ssh.github.com
     Port 443
     User git
     IdentitiesOnly yes
     IdentityFile ~/.ssh/key.pem
  ```

- You could find the document for wsl configuration section at [here](https://github.com/mrbeardad/MyIDE/tree/d0302ad521fb73f6d099e46bdc4a65ab0626d564?tab=readme-ov-file#wsl), the dotfiles in wsl/linux is still in the repo.

### PowerShell Usage

| Shortcut   | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| `Esc`      | Vi mode, `v` in vi mode means open `$EDITOR` to edit command |
| `Ctrl`+`A` | Move to the start of the line                                |
| `Ctrl`+`E` | Move to the end of the line                                  |
| `Ctrl`+`H` | Delete character left                                        |
| `Ctrl`+`W` | Delete word left                                             |
| `Ctrl`+`U` | Delete all left                                              |
| `Ctrl`+`K` | Delete all right                                             |
| `Ctrl`+`Z` | Undo                                                         |
| `Ctrl`+`Y` | Redo                                                         |
| `Tab`      | Complete command or arguments                                |
| `Ctrl`+`P` | Previous command history with current prefix                 |
| `Ctrl`+`N` | Next command history with current prefix                     |
| `Ctrl`+`R` | Fuzzy search command history                                 |
| `Alt`+`A`  | Fuzzy search command argument history                        |
| `Ctrl`+`T` | Fuzzy search files in current directory                      |
| `Alt`+`C`  | Fuzzy search directories in current directory                |

| Utils   | Description                                                                |
| ------- | -------------------------------------------------------------------------- |
| `z`     | Jump to a rencently worked directory whose path contaion the search key    |
| `f`     | Fuzzy search text of files in current directory an open `$EDITOR`          |
| `l`     | List files                                                                 |
| `tree`  | List files as tree                                                         |
| `gdu`   | Disk usage analysis                                                        |
| `cht`   | Search for a cheat sheet on [cheat.sh](https://github.com/chubin/cheat.sh) |
| `tokei` | Count code                                                                 |
| `proxy` | Show/Set/Enable/Disable proxy address                                      |

| Git Aliases | Git subcommand | Description                                                                                              |
| ----------- | -------------- | -------------------------------------------------------------------------------------------------------- |
| `gst`       | `status`       | Show all changes in workspace and index                                                                  |
| `ga`        | `add`          | Update changes from workspace to index                                                                   |
| `gaa`       | `add`          | Update all changes from workspace to index                                                               |
| `gau`       | `add`          | Update all changes from workspace to index exclude untracked files                                       |
| `gcln`      | `clean`        | Clean all untracked files                                                                                |
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
| `gmt`       | `mergetool`    | Resolve conflicts by `nvim`, or you can use `gco --ours` or `gco --theirs`                               |
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

## VSCode-Neovim

<div align="center">

![neovim](images/neovim.png)

</div>

1. Install C/C++ compiler

   ```ps1
   scoop install mingw-mstorsjo-llvm-ucrt cmake
   ```

2. Install Neovim

   ```ps1
   # use --skip to skip hash check since there is some problem in scoop's neovim-nightly package
   scoop install neovim-nightly --skip
   ```

3. Configure Neovim

   ```ps1
   # required
   Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
   # optional but recommended
   Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak
   # clone
   git clone https://github.com/mrbeardad/nvim $env:LOCALAPPDATA\nvim
   # start and install plugins
   nvim
   ```

4. Install [VSCode](https://apps.microsoft.com/detail/XP9KHM4BK9FZ7Q?hl=en-US&gl=US)

5. Configure VSCode

   1. This is my [settings.json](vscode/settings.json) and [keybindings.json](vscode/keybindings.json), you could copy them to `%APPDATA%\Code\User` optionally
   2. This is my [lastSyncextensions.json](vscode/lastSyncextensions.json), you could copy it to `%APPDATA%\Code\User\sync\extensions\`

6. **For more detail about configuration and usage of vscode and neovim, see [mrbeardad/nvim](https://github.com/mrbeardad/nvim)**
