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

1. 更新驱动程序
2. 安装[Chrome 浏览器](https://www.google.cn/chrome/)，并登录 Google 账户以同步配置
3. 安装[7-Zip 压缩包工具](https://www.7-zip.org/)
4. 安装常用软件

   - [搜狗输入法](https://pinyin.sogou.com/)
   - [TIM](https://tim.qq.com)
   - [微信](https://pc.weixin.qq.com/?lang=zh_CN)
   - [腾讯会议](https://meeting.tencent.com/download-center.html)
   - [QQ 音乐](https://y.qq.com/download/index.html)
   - [Office 办公套件](https://www.office.com/)
   - [PowerToys 工具集](https://github.com/microsoft/PowerToys/releases)

5. <details>
    <summary><b>系统设置</b></summary>

   - Acount
     - Your info: 登录账户
     - Your info: 登录账户
     - Sync your srttings: 同步配置
   - System
     - Display: 夜间暖色
     - Clipboard: 启用剪切板
     - About: 更改主机名
   - Devices
     - Bluetooth & other devices: 关闭蓝牙
     - Touchpad: 设置触摸板手势
     - Typing
       - Advanced Keyboard Settings
         - Input Language hot keys: 设置系统输入法热键
   - Personalization
     - Theme
       - Background: 设置桌面壁纸
       - Colors: 设置主题颜色
       - Mouse Cursor: 设置[鼠标主题](https://zhutix.com/tag/cursors/)
     - Fonts: 设置字体
       1. 安装[NerdCodePro 字体](fonts/)
     - Start: 设置开始界面
       1. 开启所有选项
       2. 排版磁条
     - Taskbar: 设置任务栏界面
       1. 安装[TranslucentTB 透明任务栏](https://www.microsoft.com/zh-cn/p/translucenttb/9pf4kz2vn4w9?activetab=pivot:overviewtab)
       2. 安装[XMeters 资源监测器](https://entropy6.com/xmeters/)
       3. 居中任务栏图标
       4. 隐藏桌面图标
   - Apps
     - Apps & features: 卸载多余软件
     - Startup: 管理开机自启软件
   - Time & Language: 自动同步时间与时区，并显示农历
   - Region: 设置所在地区与日期时间显示格式
   - Language: 设置系统显示语言为英语，并下载中文包
     - Administrative language settings
       - Change system locale: 选择中文语系并取消勾选 Beta 设置
   - Ease of Access
     - Mouse pointer: 更改鼠标大小
     - [鼠标主题](https://zhutix.com/tag/cursors/)

  </details>

## [WSL](wsl.md)

1. 安装[Windows Terminal](https://www.microsoft.com/zh-cn/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)及其配置[settings.json](wt/settings.json)
2. 安装[PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.3)
2. 创建启动脚本`%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\wt_quake.vbs`从而开机即可使用快捷键`` win+` ``来开启或关闭终端

   ```vbs
   CreateObject("Wscript.Shell").Run "pwsh -c Start-Process wt.exe -WindowStyle Hidden", 0, True
   ```

3. 安装[dual-key-remap](https://github.com/ililim/dual-key-remap/releases)以映射 CapsLock 键为“单击时为 Esc，组合时为 Ctrl”

4. 安装[WSL2](https://docs.microsoft.com/en-us/windows/wsl/install)

   ```sh
   # in windows cmd on administrator mode
   wsl.exe --install
   wsl.exe --update
   ```

5. 配置 WSL2 [内存使用](https://github.com/microsoft/WSL/issues/4166#issuecomment-526725261)，`%USERPROFILE%\.wslconfig`

   ```ini
   [wsl2]
   memory=6GB
   swap=0
   ```

6. 配置 WSL 开发环境, [init.sh](init.sh)中包含我 linux 开发环境全套配置, 可以很方便的进行分发

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

1. 安装[VSCode](https://code.visualstudio.com/download)，登录账户并同步[配置](vscode/)。

2. 安装[NeoVim](https://github.com/neovim/neovim/releases/)到`C:\Program Files\Neovim\`，然后
   1. 安装配置目录[vscode-neovim](vscode/vscode-neovim/)到`C:\Program Files\Neovim\vscode-neovim`
   2. vscode 配置 `init.vim` 路径
   3. vscode 配置 `nvim.exe` 路径

## Others

- 安装[Fork](https://git-fork.com/)

- 安装[Postman](https://www.postman.com/downloads/)

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
