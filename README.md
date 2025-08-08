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

- [TranslucentTB](https://apps.microsoft.com/detail/9PF4KZ2VN4W9) : A lightweight utility that makes the Windows taskbar translucent/transparent on Windows 10 and Windows 11.

- [PowerToys](https://apps.microsoft.com/detail/XP89DCGQ3K6VLD) : A set of utilities for power users to tune and streamline their Windows experience for greater productivity. There's some [Third-Party plugins for PowerToy Run](https://github.com/microsoft/PowerToys/blob/main/doc/thirdPartyRunPlugins.md).

- [Sysinternals](https://apps.microsoft.com/detail/9p7knl5rwt25) : A bundle of the Sysinternals utilities including Process Explorer, Process Monitor, Sysmon, Autoruns, ProcDump, all of the PsTools, and many more. Here's my [Process Explorer Column Set](./sysinternals/ProcessExplorerColumnSet.reg)

- [PixPin](https://apps.microsoft.com/detail/xp89f3cgsrzhc7) : A series of functions related to screenshot textures, including screenshots, long screenshots, cropped images, textures, OCR, etc

- [Nerd Font](https://www.nerdfonts.com/font-downloads) : A series of fonts that been pathed with high number of icons. My choice is [Source Code Pro](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SourceCodePro).

- Install a [Cursor Theme](https://zhutix.com/tag/cursors/) you'd like.

- Press `Win`+`I` and check if there are any settings that need to be changed.

### Desktop Usage

| Shortcut          | Descript              |
| ----------------- | --------------------- |
| `Win`+`E`         | Explorer              |
| `Win`+`{num}`     | Launch app on taskbar |
| `Win`+`↑`         | Maximize window       |
| `Win`+`↓`         | Minimize window       |
| `Win`+`←`         | Snap window left      |
| `Win`+`→`         | Snap window right     |
| `Alt`+`Tab`       | Switch window         |
| `Alt`+`F4`        | Close window          |
| `Win`+`D`         | Show/Hide desktop     |
| `Win`+`,`         | Peek desktop          |
| `Win`+`L`         | Lock desktop          |
| `Win`+`Ctrl`+`D`  | New virtual desktop   |
| `Win`+`Ctrl`+`→`  | Right virtual desktop |
| `Win`+`Ctrl`+`←`  | Left virtual desktop  |
| `Win`+`;`         | Emoji                 |
| `Win`+`+`         | Zoom in               |
| `Win`+`-`         | Zoom out              |
| `Win`+`Shift`+`?` | Shortcut help         |

## Terminal

<div align="center">

![desktop](images/terminal.png)

</div>

### Terminal Installation

- Install [Windows Terminal](https://apps.microsoft.com/detail/9N0DX20HK701)

- Configure Windows Terminal by pressing `Ctrl`+`Shift`+`,` in terminal window, you could refer to my [**settings.json**](./wt/settings.json).

> Tips:
>
> - All colorschemes are adjusted to fit both light and dark theme of system.
> - The font family is set to `SauceCodePro Nerd Font`

### Terminal Usage

| Shortcut               | Description                    |
| ---------------------- | ------------------------------ |
| `Win`+`` ` ``          | Toggle quake (dropdown) window |
| `Ctrl`+`Shift`+`{num}` | New tab with profile `{num}`   |
| `Ctrl`+`Shift`+`D`     | Duplication current tab        |
| `Ctrl`+`Shift`+`W`     | Close tab                      |
| `Alt`+`Shift`+`S`      | Horizontally split the pane    |
| `Alt`+`Shift`+`V`      | Vertically split the pane      |
| `Alt`+`Shift`+`Z`      | Toggle the pane zoom           |
| `Alt`+`Left`           | Move focus left                |
| `Alt`+`Right`          | Move focus right               |
| `Alt`+`Up`             | Move focus up                  |
| `Alt`+`Down`           | Move focus down                |
| `MouseSelect`          | Copy                           |
| `Shift`+`MouseSelect`  | Incremental Copy               |
| `Alt`+`MouseSelect`    | Copy block area                |
| `Ctrl`+`Shift`+`V`     | Paste                          |
| `Ctrl`+`Shift`+`F`     | Search                         |

## PowerShell

<div align="center">

![desktop](images/powershell.png)

</div>

### PowerShell Installation

- Install [PowerShell](https://apps.microsoft.com/detail/9MZ1SNWT0N5D)

- Install [Scoop](https://scoop.sh/): A package manager to install apps in command line.

- Install the required tools and PowerShell modules

  ```ps1
  # Required
  scoop install 7zip git # aria2
  scoop install oh-my-posh zoxide lsd bat ripgrep fd fzf
  Install-Module posh-git
  Install-Module PSFzf

  # Optional but recommended
  scoop install fastfetch cht tokei lazygit everything
  cp .\bat\config ~\AppData\Roaming\bat\config
  cp .\lazygit\config.yml ~\AppData\Local\lazygit\config.yml
  ~\scoop\apps\7zip\current\install-context.reg
  ~\scoop\apps\everything\current\install-context.reg
  # Adding %USERPROFILE%\scoop\apps\git\current\user\bin to PATH is useful
  ```

- Configure PowerShell by executing `notepad $PROFILE` in PowerShell command line,
  you could refer to my [**profile.ps1**](./ps/Microsoft.PowerShell_profile.ps1)

- Copy the theme file [**base16_bear.omp.json**](./powershell/base16_bear.omp.json) into `%USERPROFILE%\Documents\PowerShell`

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

> You could find the document for WSL configuration section [here](https://github.com/mrbeardad/MyIDE/tree/d0302ad521fb73f6d099e46bdc4a65ab0626d564?tab=readme-ov-file#wsl), the dotfiles for WSL/Linux is still in the repository.

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

| Utils         | Description                                                                |
| ------------- | -------------------------------------------------------------------------- |
| `l`           | List files (requrie lsd)                                                   |
| `tree`        | List files as tree (require lsd)                                           |
| `z`           | Change to directory by fuzzy name (require zoxide)                         |
| `zi`          | Change to directory by fuzzy name interactively (require zoxide)           |
| `zoxide edit` | Adjust priority of directories                                             |
| `tokei`       | Count code                                                                 |
| `cht`         | Search for a cheat sheet on [cheat.sh](https://github.com/chubin/cheat.sh) |
| `px`          | Show/Set/Enable/Disable proxy address                                      |
| `notify`      | Show Windows notification popup, e.g. `notify "Title" "Body"`              |

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
| `gig`       |                | Create a .gitignore template for you, .e.g `gig c++ windows`                                             |

> Tips:
>
> - You don't need to remenber all the git aliases, use your favorite git UI tool instead, such as lazygit, fork or gitkraken. The git aliases list above is just to tell you the basic git operations you should know.
> - Highly recommended for this [blog post](https://nvie.com/posts/a-successful-git-branching-model/) about git flow.

## VSCode-Neovim

<div align="center">

![neovim](images/neovim.png)

</div>

1. Install Neovim and C/C++ toolchains

   ```ps1
   scoop install neovim mingw-mstorsjo-llvm-ucrt cmake
   ```

2. Configure Neovim

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

3. Install [VSCode](https://apps.microsoft.com/detail/XP9KHM4BK9FZ7Q)

4. Configure VSCode

   1. This is my [settings.json](vscode/settings.json) and [keybindings.json](vscode/keybindings.json), you could copy them to `%APPDATA%\Code\User` optionally
   2. This is my [lastSyncextensions.json](vscode/lastSyncextensions.json), you could copy it to `%APPDATA%\Code\User\sync\extensions\`

5. **For more detail about configuration and usage of vscode and neovim, refer to [mrbeardad/nvim](https://github.com/mrbeardad/nvim)**
