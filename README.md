# 开发环境搭建

<!-- vim-markdown-toc GFM -->

- [开发环境搭建](#开发环境搭建)
  - [Windows](#windows)
  - [WSL](#wsl)
  - [VSCode-Neovim](#vscode-neovim)
  - [Language](#language)

<!-- vim-markdown-toc -->

## Windows

> [Windows 操作手册](windows.md)

1. 安装[Chocolatey 包管理器](https://chocolatey.org/install)
2. 使用包管理器安装：

   ```pwsh
   # in admin
   choco install -y sudo 7zip make rust go python3 nodejs flutter
   ```

   > Tips: 国内 choco 安装大型软件会很慢（如 go 等编程语言），建议用浏览器去官网下载安装包

3. 使用微软商店安装
   - Windows Terminal
   - PowerShell
   - Microsoft PowerToys
4. 使用浏览器安装
   - [Google Chrome](https://www.google.cn/chrome/)
   - [Sogou IME](https://pinyin.sogou.com/)
   - [TIM](https://tim.qq.com)
   - [WeChat](https://pc.weixin.qq.com/?lang=zh_CN)
   - [WeMeeting](https://meeting.tencent.com/download-center.html)
   - [QQ Music](https://y.qq.com/download/index.html)
   - [Office](https://www.office.com/)
   - [Fork](https://git-fork.com/)
   - [Postman](https://www.postman.com/downloads/)
5. 安装[NerdCodeProPlus font](fonts/)
6. 配置 .gitconfig

   ```conf
   [user]
     name = Heache Bear
     email = mrbeardad@qq.com
   [merge]
     tool = vimdiff
   [mergetool "vimdiff"]
     path = nvim
   ```

7. 配置 .ssh
8. [配置 Windows Terminal](wt/settings.json)
9. [配置 PowerShell](ps/Microsoft.PowerShell_profile.ps1)

   ```pwsh
   # install dependencies before copy config file
   choco install fzf
   Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
   Install-Module PSReadLine
   Install-Module PSFzf
   Install-Module ZLocation
   Install-Module posh-git
   Install-Module git-aliases -AllowClobber
   ```

10. 安装[dual-key-remap](https://github.com/ililim/dual-key-remap/releases)以映射 CapsLock 键为“单击时为 Esc，组合时为 Ctrl”，注意根据文档[设置管理员权限](https://github.com/ililim/dual-key-remap#administrator-access)，否则在提权窗口中无法使用
11. 创建启动脚本`%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\wt_quake.vbs`从而开机即可使用快捷键`` win+` ``来开启或关闭终端

    ```vbs
    CreateObject("Wscript.Shell").Run "pwsh -c Start-Process wt.exe -WindowStyle Hidden", 0, True
    ```

12. 系统设置
13. 安装[鼠标主题](https://zhutix.com/tag/cursors/)

## WSL

> [WSL 操作手册](wsl.md)

1. 安装 WSL2

   ```pwsh
   wsl.exe --install
   wsl.exe --update
   ```

2. 安装 [ArchWSL](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/)

3. 配置 WSL2 [内存使用](https://github.com/microsoft/WSL/issues/4166#issuecomment-526725261)，`%USERPROFILE%\.wslconfig`

   ```ini
   [wsl2]
   memory=6GB
   swap=0
   ```

4. 配置 WSL 开发环境, [init.sh](init.sh)中包含我 linux 开发环境全套配置, 可以很方便的进行分发

   ```sh
   # in wsl
   curl -Lo init.sh https://github.com/mrbeardad/MyIDE/raw/master/init.sh
   ./init.sh # 直接执行，不要`bash init.sh`
   ```

> TIPS: WSL2 访问 Windows 宿主机的代理软件，需要：
>
> 1. 添加防火墙规则，允许宿主机某端口可被访问
> 2. 设置代理软件可接受局域网代理请求
> 3. Windows Host IP 由/etc/resolv.conf 可知

## VSCode-Neovim

> [VSCode 与 Neovim 操作手册](vscode-neovim.md)

1. 安装[Visual Studio](https://visualstudio.microsoft.com/vs/)

   > Tips: 安装时勾选 git 和 clang 选项 ，安装完成后将 CMake/bin 与 Llvm/x64/bin （注意是 64 位版本）加入环境变量，后续会需要。

2. 安装[Neovim](https://github.com/neovim/neovim/releases/)与[配置](./neovim/)

   1. 安装[LunarVim](https://www.lunarvim.org/docs/master/installation)
   2. 复制[config.lua](./neovim/config.lua)到`%LOCALAPPDATA%\lvim\`下
   3. 复制[init.vim](./neovim/init.vim)到`%LOCALAPPDATA%\nvim\`下
   4. 启动`nvim`自动安装插件

   > Tips: 安装插件需要访问 github

3. 安装[VSCode](https://code.visualstudio.com/download)与[配置](./vscode/)

   1. 复制[lastSyncextensions.json](vscode/lastSyncextensions.json)到`%APPDATA%\Code\User\sync\extensions\`下
   2. 复制[settings.json](vscode/settings.json)与[keybindings.json](vscode/keybindings.json)到`%APPDATA%\Code\User`下

   > Tips: VSCode 的配置依赖 Neovim 的配置

## Language

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
