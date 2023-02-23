# 开发环境搭建

<!-- vim-markdown-toc GFM -->

- [开发环境搭建](#开发环境搭建)
  - [Windows](#windows)
  - [WSL](#wsl)
  - [VSCode](#vscode)
  - [Others](#others)
  - [Language](#language)

<!-- vim-markdown-toc -->

## [Windows](windows.md)

1. 安装[Chocolatey 包管理器](https://chocolatey.org/install)
2. 使用包管理器安装：
   ```pwsh
   # in admin cmd
   choco install -y make rust go python3 nodejs flutter androidstudio
   ```
3. 使用微软商店安装
   - Windows Terminal
   - PowerShell
   - oh-my-posh
   - Microsoft PowerToys
4. 使用浏览器安装
   - [Google Chrome](https://www.google.cn/chrome/)
   - [7-Zip](https://www.7-zip.org/)
   - [Sogou IME](https://pinyin.sogou.com/)
   - [TIM](https://tim.qq.com)
   - [WeChat](https://pc.weixin.qq.com/?lang=zh_CN)
   - [WeMeeting](https://meeting.tencent.com/download-center.html)
   - [QQ Music](https://y.qq.com/download/index.html)
   - [Office](https://www.office.com/)
   - [Fork](https://git-fork.com/)
   - [Postman](https://www.postman.com/downloads/)
   - [VSCode](https://code.visualstudio.com/download)
   - [Neovim](https://github.com/neovim/neovim/releases/)
5. 系统设置
6. 安装[NerdCodePro 字体](fonts/)
7. 安装[鼠标主题](https://zhutix.com/tag/cursors/)
8. [配置 Windows Terminal](wt/settings.json)
9. 配置 PowerShell
   ```pwsh
   # nvim $PROFILE
   oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/powerlevel10k_rainbow.omp.json" | Invoke-Expression
   ```
10. 创建启动脚本`%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\wt_quake.vbs`从而开机即可使用快捷键`` win+` ``来开启或关闭终端
   ```vbs
   CreateObject("Wscript.Shell").Run "pwsh -c Start-Process wt.exe -WindowStyle Hidden", 0, True
   ```
11. 安装[dual-key-remap](https://github.com/ililim/dual-key-remap/releases)以映射 CapsLock 键为“单击时为 Esc，组合时为 Ctrl”

## [WSL](wsl.md)

1. 安装 WSL2

   ```sh
   # in windows cmd on administrator mode
   wsl.exe --install
   wsl.exe --update
   ```

2. 配置 WSL2 [内存使用](https://github.com/microsoft/WSL/issues/4166#issuecomment-526725261)，`%USERPROFILE%\.wslconfig`

   ```ini
   [wsl2]
   memory=6GB
   swap=0
   ```

3. 配置 WSL 开发环境, [init.sh](init.sh)中包含我 linux 开发环境全套配置, 可以很方便的进行分发

   ```sh
   # in wsl
   curl -Lo init.sh https://github.com/mrbeardad/MyIDE/raw/master/init.sh
   ./init.sh # 直接执行，不要`bash init.sh`
   ```

> TIPS:
>
> WSL2 访问 Windows 宿主机的代理软件，需要：
>
> 1. 添加防火墙规则，允许宿主机某端口可被访问
> 2. 设置代理软件可接受局域网代理请求
> 3. Windows IP 由/etc/resolv.conf 可知

## [VSCode](vscode.md)

1. [配置 VSCode](vscode/)

2. 安装[NeoVim](https://github.com/neovim/neovim/releases/)到`C:\Program Files\Neovim\`，然后
   1. 安装配置目录[vscode-neovim](vscode/vscode-neovim/)到`C:\Program Files\Neovim\vscode-neovim`
   2. vscode 配置 `init.vim` 路径
   3. vscode 配置 `nvim.exe` 路径

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
