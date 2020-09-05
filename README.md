# Windows10配置

这篇文档做为个我的个人日志，方便下次重装。读者请酌情参考。

## 首先
* 登录Windows账户

## 驱动程序
* 下载并安装[MyASUS](https://www.microsoft.com/zh-cn/p/myasus/9n7r5s6b0zzh?activetab=pivot:overviewtab)

## 下载准备
* 下载并安装[Google Chrome](https://www.google.cn/chrome/)

* 设置Chrome的下载目录为`C:\Users\UserName\Downloads\GoogleChrome-Downloads`

* 下载并安装[Bandizip压缩包工具](https://www.bandizip.com/)

* 下载并安装[Google Access Helper](https://gitee.com/mrbeardad/DotFiles/tree/master/chrome)

* 登录Google账户并同步Chrome配置（包括手动同步TampMonkey脚本）

* 设置Chrome语言与字体，以及设置Google搜索引擎的语言

* 修改`C:\Windows\System32\drivers\etc\hosts`解决DNS污染
```txt
104.77.75.97        aka.ms
13.250.177.223      github.com
151.101.76.133      raw.githubusercontent.com
185.199.108.154     github.githubassets.com
31.13.82.52         github.global.ssl.fastly.net
203.208.39.104      assets-cdn.github.com
243.185.187.39      gist.github.com
151.101.108.133     gist.githubusercontent.com
```

## 下载软件
* [Microsoft Edge](https://www.microsoft.com/zh-cn/edge)

* [RIME输入法](https://rime.im/download/)，
[下载配置与词库](https://gitee.com/mrbeardad/rime-dict)并解压后安装到`C:\Users\mrbea\AppData\Roaming\Rime`

* [TIM 通讯](https://tim.qq.com)

* [百度网盘](https://pan.baidu.com/downloads)

* [Listen1 音乐](https://www.zhyong.cn/posts/64cd/)

* [万彩办公大师](http://www.wofficebox.com/)

* [CHFS 文件共享服务器](http://iscute.cn/chfs)

* [Dism++ 系统清理与优化](https://www.chuyu.me/zh-Hans/)

* [Geek 卸载工具](https://geekuninstaller.com/)

* [Listary 搜索工具](https://www.listarypro.com/download)

* [PowerToys 工具集](https://github.com/microsoft/PowerToys/releases)

* [TranslucentTB 任务栏美化](https://www.microsoft.com/zh-cn/p/translucenttb/9pf4kz2vn4w9?activetab=pivot:overviewtab)

* [XMeters 资源监测器](https://entropy6.com/xmeters/)

* [Rainmeter 桌面美化](https://www.rainmeter.net/)与[Elegance-2皮肤](https://visualskins.com/skin/elegance-2)

* [noMeiryoUI 字体设置](https://github.com/Tatsu-syo/noMeiryoUI/releases)

* [MacType 字体渲染](https://github.com/snowie2000/mactype/releases)

* Office 办公套件

## 个性化设置
* 夜间暖色模式
    > Setting -> System -> Display -> Nignt light settings

* 更改主机名
    > Settings -> System -> About -> Rename your PC

* 更改鼠标大小
    > Settings -> Ease of Access -> Mouse pointer -> change pointer size

* 大小写提示音
    > Settings -> Ease of Access -> Keyboard -> Use Toggle Keys

* 关闭蓝牙
    > Settings -> Devices -> Bluetooth & other devices

* 更改主题颜色
    > Settings -> Personalization -> Colors

* 更改鼠标主题
    > Settings -> Personalization -> Themes -> Mouse cursor  
    > 需要将[鼠标主题](win10/cursor)解压并安装到`C:\Windows\Cursors`

* 安装字体
    > Settings -> Personalization -> Fonts  
    > [Source Code Pro Nerd字体](https://mirrors.cloud.tencent.com/archlinuxcn/x86_64/nerd-fonts-source-code-pro-2.1.0-4-any.pkg.tar.zst)、
    > [Space Mono Nerd字体](https://mirrors.cloud.tencent.com/archlinuxcn/x86_64/nerd-fonts-space-mono-2.1.0-4-any.pkg.tar.zst)、
    > [IBM Plex Mono Nerd字体](https://mirrors.cloud.tencent.com/archlinuxcn/x86_64/nerd-fonts-ibm-plex-mono-2.1.0-4-any.pkg.tar.zst)  
    > 注意：Windows下的应用一般无法选择style，故只安装好看的style而不全装  
    > 注意：Windows Terminal字体不要使用Mono版本，会导致图标字体太小

* 设置StartMenu
    > Settings -> Personalization -> Start -> Choose which folders appear on Start
    > * 全屏开始菜单
    > * 简化开始菜单显示内容
    > * 固定所有用户安装软件
    > * 磁贴的排列摆放
    > * 侧栏文件夹快速访问

* 设置TaskBar
    > Settings -> Personalization -> Taskbar  
    > * 任务栏位置
    > * 任务栏图标位置
    > * 任务栏图标大小

* 自动同时时间与设置时区
    > Settings -> Time & Language -> Date & time

* 更改系统语言
    > Settings -> Time & Language -> Language

* 所在地区与时间显示格式
    > Settings -> Time & Language -> Region

* 关闭或卸载不必要的应用
    > Settings -> Apps -> Apps & features  
    > 可以用Geek卸载

* 设置打开文件的默认应用
    > Settings -> Apps -> Default apps

* 设置开机自启应用
    > Settings -> Apps -> Startup

* 设置输入法按键
    > Settings -> Devices -> Typing -> Advanced Keyboard Settings -> Input Language hot keys

## 开发工具：
* 下载[Windows Terminal](https://www.microsoft.com/zh-cn/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)，
并安装配置：
<details>
    <summary><b>setting.json</b></summary>

```json
// Official Documents: https://docs.microsoft.com/en-us/windows/terminal/customize-settings
{
    "$schema": "https://aka.ms/terminal-profiles-schema",

    "defaultProfile": "{96be24fd-152c-5812-90bb-b4bd046f9785}",

    "disabledProfileSources": [],

    "theme": "system",

    "useTabSwitcher": false,

    "alwaysShowTabs": false,

    "tabWidthMode": "compact",

    "confirmCloseAllTabs": true,

    "startOnUserLogin": false,

    "launchMode": "default",

    "initialPosition": ",",

    "initialCols": 120,

    "initialRows": 30,

    "alwaysOnTop": false,

    "showTabsInTitlebar": true,

    "showTerminalTitleInTitlebar": false,

    "copyOnSelect": true,

    "copyFormatting": false,

    "wordDelimiters": " /\\()\"'-.,:;<>~!@#$%^&*|+=[]{}~?\u2502",

    "largePasteWarning": true,

    "multiLinePasteWarning": true,

    "rowsToScroll": "system",

    "snapToGridOnResize": true,

    "experimental.rendering.forceFullRepaint": false,

    "experimental.rendering.software": false,

    "profiles":
    {
        "defaults":
        {
            "fontFace": "SauceCodePro Nerd Font",
            "fontWeight": "normal",
            "fontSize": 9,
            "padding": "0, 0, 0, 0",
            "antialiasingMode": "grayscale",
            "cursorShape": "filledBox",
            "altGrAliasing": true,
            "colorScheme": "Atom",
            "useAcrylic": true,
            "acrylicOpacity": 0.3,
            "selectionBackground": "#00dfd7",
            "scrollbarState": "hidden",
            "snapOnInput": true,
            "historySize": 9001,
            "closeOnExit": "graceful",
            "experimental.retroTerminalEffect": false
            //"backgroundImage": "%LOCALAPPDATA%\\Packages\\Microsoft.WindowsTerminal_8wekyb3d8bbwe\\RoamingState\\DNA.png",
            //"backgroundImageStretchMode": "uniformToFill",
            //"backgroundImageAlignment": "center",
            //"backgroundImageOpacity": 0.6
        },
        "list":
        [
            {
                "name": "Windows PowerShell",
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "commandline": "powershell.exe",
                "hidden": false
            },
            {
                "name": "Azure Cloud Shell",
                "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}",
                "source": "Windows.Terminal.Azure",
                "hidden": false
            },
            {
                "name": "熊海成爸爸的Ubuntu-20.04",
                "guid": "{07b52e3e-de2c-5db4-bd2d-ba144ed6c273}",
                "source": "Windows.Terminal.Wsl",
                "commandline": "wsl ~ ",
                "icon": "%USERPROFILE%\\OneDrive\\图片\\Saved Pictures\\ubuntu.png",
                "hidden": false
            },
            {
                "name": "熊海成爸爸的ArchLinux2",
                "guid": "{96be24fd-152c-5812-90bb-b4bd046f9785}",
                "source": "Windows.Terminal.Wsl",
                "commandline": "wsl -d Arch2",
                "icon": "%USERPROFILE%\\OneDrive\\图片\\Saved Pictures\\arch.webp",
                "hidden": false
            }
        ]
    },

   //https://github.com/mbadolato/iTerm2-Color-Schemes
   "schemes":
   [
        {
            "name": "BlueBerryPie",
            "black": "#0a4c62",
            "red": "#99246e",
            "green": "#5cb1b3",
            "yellow": "#eab9a8",
            "blue": "#90a5bd",
            "purple": "#9d54a7",
            "cyan": "#7e83cc",
            "white": "#f0e8d6",
            "brightBlack": "#201637",
            "brightRed": "#c87272",
            "brightGreen": "#0a6c7e",
            "brightYellow": "#7a3188",
            "brightBlue": "#39173d",
            "brightPurple": "#bc94b7",
            "brightCyan": "#5e6071",
            "brightWhite": "#0a6c7e",
            "background": "#1c0c28",
            "foreground": "#babab9"
        },
        {
            "name": "AdventureTime",
            "black": "#050404",
            "red": "#bd0013",
            "green": "#4ab118",
            "yellow": "#e7741e",
            "blue": "#0f4ac6",
            "purple": "#665993",
            "cyan": "#70a598",
            "white": "#f8dcc0",
            "brightBlack": "#4e7cbf",
            "brightRed": "#fc5f5a",
            "brightGreen": "#9eff6e",
            "brightYellow": "#efc11a",
            "brightBlue": "#1997c6",
            "brightPurple": "#9b5953",
            "brightCyan": "#c8faf4",
            "brightWhite": "#f6f5fb",
            "background": "#1f1d45",
            "foreground": "#f8dcc0"
        },
        {
            "name": "Atom",
            "black": "#000000",
            "red": "#fd5ff1",
            "green": "#87c38a",
            "yellow": "#ffd7b1",
            "blue": "#85befd",
            "purple": "#b9b6fc",
            "cyan": "#85befd",
            "white": "#e0e0e0",
            "brightBlack": "#000000",
            "brightRed": "#fd5ff1",
            "brightGreen": "#94fa36",
            "brightYellow": "#f5ffa8",
            "brightBlue": "#96cbfe",
            "brightPurple": "#b9b6fc",
            "brightCyan": "#85befd",
            "brightWhite": "#e0e0e0",
            "background": "#161719",
            "foreground": "#c5c8c6"
        }
    ],

    "keybindings":
    [
        { "command": {"action": "copy", "singleLine": false }, "keys": "ctrl+shift+c" },
        { "command": "paste", "keys": "ctrl+shift+v" },
        { "command": "find", "keys": "ctrl+shift+f" },
        { "command": "openNewTabDropdown", "keys": "ctrl+shift+space" },
        { "command": "openSettings", "keys": "ctrl+," },
        { "command": { "action": "openSettings", "target": "defaultsFile" }, "keys": "ctrl+alt+," },
        { "command": "toggleFullscreen", "keys": "alt+enter" },
        { "command": "toggleFullscreen", "keys": "f11" },
        { "command": "unbound", "keys": "ctrl+shift+down"},
        { "command": "unbound", "keys": "ctrl+shift+up"},
        { "command": "toggleFocusMode", "keys": "Alt+t"}
    ]
}
```
</details>

* 下载[WSL](https://www.microsoft.com/zh-cn/p/ubuntu-2004-lts/9n6svws3rx71?activetab=pivot:overviewtab)
    1. 管理员权限运行`wt`：
        * `dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart`
        * `dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`
        * `Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`
    2. 上述最后一步重启后，再启动WSL进行初始化
    3. 升级WSL2：
        1. 下载[WSL2升级包](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)
        2. 执行`wsl --set-version <Distro> 2`

* 下载并安装[ArchWSL2](https://github.com/yuk7/ArchWSL2/releases/)

* 下载[VSCode](https://code.visualstudio.com/download)，并安装插件与配置
    * Remote-WSL
    * Vim
    * C/C++
    * C++ Intellisense
    * Code Runner
<details>
    <summary><b>setting.json</b></summary>

```json
{
    "workbench.colorCustomizations": {
        "terminal.foreground": "#c5c8c6",
        "terminal.background": "#161719",
        "terminal.ansiBlack": "#000000",
        "terminal.ansiBlue": "#85befd",
        "terminal.ansiCyan": "#85befd",
        "terminal.ansiGreen": "#87c38a",
        "terminal.ansiMagenta": "#b9b6fc",
        "terminal.ansiRed": "#fd5ff1",
        "terminal.ansiWhite": "#e0e0e0",
        "terminal.ansiYellow": "#ffd7b1",
        "terminal.ansiBrightBlack": "#000000",
        "terminal.ansiBrightBlue": "#96cbfe",
        "terminal.ansiBrightCyan": "#85befd",
        "terminal.ansiBrightGreen": "#94fa36",
        "terminal.ansiBrightMagenta": "#b9b6fc",
        "terminal.ansiBrightRed": "#fd5ff1",
        "terminal.ansiBrightWhite": "#e0e0e0",
        "terminal.ansiBrightYellow": "#f5ffa8",
        "statusBar.background": "#8FBCBB",
        "statusBar.noFolderBackground": "#8FBCBB",
        "statusBar.debuggingBackground": "#8FBCBB",
        "statusBar.foreground": "#434C5E"
    },
    "C_Cpp.updateChannel": "Insiders",
    "http.proxySupport": "off",
    "[jsonc]": {
        "editor.quickSuggestions": {
            "strings": true
        },
        "editor.suggest.insertMode": "replace"
    },
    "editor.fontSize": 12,
    "editor.fontFamily": "SauceCodePro NF",
    "editor.renderWhitespace": "all",
    "editor.cursorSmoothCaretAnimation": true,
    "editor.lineNumbers": "relative",
    "code-runner.temporaryFileName": "${fileBasenameNoExtension}.exe",
    "code-runner.saveFileBeforeRun": true,
    "code-runner.executorMap": {

        "javascript": "node",
        "java": "cd $dir && javac $fileName && java $fileNameWithoutExt",
        "c": "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
        "cpp": "cd $dir && cl /nologo $fileName > $null && $dir$fileNameWithoutExt",
        "objective-c": "cd $dir && gcc -framework Cocoa $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
        "php": "php",
        "python": "python -u",
        "perl": "perl",
        "perl6": "perl6",
        "ruby": "ruby",
        "go": "go run",
        "lua": "lua",
        "groovy": "groovy",
        "powershell": "powershell -ExecutionPolicy ByPass -File",
        "bat": "cmd /c",
        "shellscript": "bash",
        "fsharp": "fsi",
        "csharp": "scriptcs",
        "vbscript": "cscript //Nologo",
        "typescript": "ts-node",
        "coffeescript": "coffee",
        "scala": "scala",
        "swift": "swift",
        "julia": "julia",
        "crystal": "crystal",
        "ocaml": "ocaml",
        "r": "Rscript",
        "applescript": "osascript",
        "clojure": "lein exec",
        "haxe": "haxe --cwd $dirWithoutTrailingSlash --run $fileNameWithoutExt",
        "rust": "cd $dir && rustc $fileName && $dir$fileNameWithoutExt",
        "racket": "racket",
        "scheme": "csi -script",
        "ahk": "autohotkey",
        "autoit": "autoit3",
        "dart": "dart",
        "pascal": "cd $dir && fpc $fileName && $dir$fileNameWithoutExt",
        "d": "cd $dir && dmd $fileName && $dir$fileNameWithoutExt",
        "haskell": "runhaskell",
        "nim": "nim compile --verbosity:0 --hints:off --run",
        "lisp": "sbcl --script",
        "kit": "kitc --run",
        "v": "v run",
        "sass": "sass --style expanded",
        "scss": "scss --style expanded",
        "less": "cd $dir && lessc $fileName $fileNameWithoutExt.css"
    },
    "C_Cpp.inactiveRegionOpacity": null,
    "code-runner.clearPreviousOutput": true,
    "code-runner.runInTerminal": false,
    "vim.easymotion": true,
    "vim.statusBarColorControl": true,
    "vim.statusBarColors.normal": ["#8FBCBB", "#434C5E"],
    "vim.statusBarColors.insert": "#BF616A",
    "vim.statusBarColors.visual": "#B48EAD",
    "vim.statusBarColors.visualline": "#B48EAD",
    "vim.statusBarColors.visualblock": "#A3BE8C",
    "vim.statusBarColors.replace": "#D08770",
    "vim.statusBarColors.commandlineinprogress": "#007ACC",
    "vim.statusBarColors.searchinprogressmode": "#007ACC",
    "vim.statusBarColors.easymotionmode": "#007ACC",
    "vim.statusBarColors.easymotioninputmode": "#007ACC",
    "vim.statusBarColors.surroundinputmode": "#007ACC",
    "vim.leader": "<space>",
    "vim.insertModeKeyBindingsNonRecursive": [
        {
            "before": ["<c-a>"],
            "after": ["<esc>", "0", "i"]
        },
        {
            "before": ["<c-e>"],
            "after": ["<esc>", "$", "a"]
        },
        {
            "before": ["<c-k>"],
            "after": ["<esc>", "d", "$", "a"]
        },
        {
            "before": ["<c-y>"],
            "after": ["\"", "\"", "p"]
        },
    ],
    "vim.normalModeKeyBindingsNonRecursive": [
        {
            "before": ["<c-a>"],
            "after": ["0"]
        },
        {
            "before": ["<c-e>"],
            "after": ["$"]
        },
        {
            "before": ["\\\\", "y"],
            "after": ["\"", "+", "y"]
        },
        {
            "before": ["Y"],
            "after": ["y", "$"]
        },
        {
            "before": ["\\\\", "Y"],
            "after": ["\"", "+", "y", "$"]
        },
        {
            "before": ["\\\\", "p"],
            "after": ["\"", "+", "p"]
        },
        {
            "before": [";"],
            "after": ["\\\\", "\\\\", "2", "s"]
        },
        {
            "before": ["<space>", "c", "l"],
            "after": ["g", "c", "c"]
        },
        {
            "before": ["<"],
            "after": ["<", "<"]
        },
        {
            "before": [">"],
            "after": [">", ">"]
        },
    ],
    "vim.visualModeKeyBindingsNonRecursive": [
        {
            "before": ["\\\\", "y"],
            "after": ["\"", "+", "y"]
        },
        {
            "before": ["\\\\", "p"],
            "after": ["\"", "+", "p"]
        }
    ],
    "vim.easymotionMarkerForegroundColorOneChar": "#ff0000",
    "vim.easymotionMarkerForegroundColorTwoChar": "#ff0000",
    "launch": {
    
        "configurations": [],
        "compounds": []
    },
    "editor.renderLineHighlightOnlyWhenFocus": true,
    "vim.highlightedyank.color": "rgb(250, 215, 0)",
    "vim.searchHighlightTextColor": "rgb(250, 215, 0)"
}
```
</details>

* 下载[VS](https://visualstudio.microsoft.com/downloads/#other)并设置工具链的环境变量
    > 控制面板》系统与安全》系统》高级系统设置》环境变量》PATH、LIB、INCLUDE  
    * PATH： ![path](PATH.png)  
    * LIB： ![lib](LIB.png)  
    * INCLUDE： ![include](INCLUDE.png)

* 下载[Docker](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.docker.com%2Fproducts%2Fdocker-desktop)
并更换docker源为`http://hub-mirror.c.163.com`，然后设置**WSL集成**

> * [mingw编译套件下载](https://pan.baidu.com/s/17JPRFzeZEhqxceWUTXTAog)，密码`c8uc`  
>
> * Alacritty终端，[下载](https://github.com/alacritty/alacritty/releases)，
>     [配置](https://github.com/mrbeardad/Windows10/blob/master/alacritty/alacritty.yml)
>     安装到`C:\Users\mrbea\AppData\Roaming\alacritty\alacritty.yml`

## WSL
启动WSL，然后安装Linux环境配置
```sh
git clone https://gitee.com/mrbeardad/Windows10/ ~/.Windows10
cd ~/.Windows10
./init.sh
```

# 快捷键

| 文件管理器或文件编辑器快捷键                  | 功能      |
|-----------------------------------------------|-----------|
| <kbd>Ctrl</kbd>+<kbd>A</kbd>                  | 全选      |
| <kbd>Ctrl</kbd>+<kbd>C</kbd>                  | 复制      |
| <kbd>Ctrl</kbd>+<kbd>X</kbd>                  | 剪切      |
| <kbd>Del</kbd>                                | 删除      |
| <kbd>Ctrl</kbd>+<kbd>V</kbd>                  | 粘贴      |
| <kbd>Ctrl</kbd>+<kbd>Z</kbd>                  | 撤销      |
| <kbd>Ctrl</kbd>+<kbd>F</kbd>                  | 搜索      |
| <kbd>Ctrl</kbd>+<kbd>O</kbd>                  | 打开      |
| <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>N</kbd> | 新建目录  |
| <kbd>BackSpace</kbd>                          | 返回/删除 |

| Win快捷键                                    | 功能              |
|----------------------------------------------|-------------------|
| <kbd>Win</kbd>+<kbd>num</kbd>                | 任务栏第num个软件 |
| <kbd>Win</kbd>+<kbd>E</kbd>                  | 文件管理器        |
| <kbd>Win</kbd>+<kbd>I</kbd>                  | 设置中心          |
| <kbd>Win</kbd>+<kbd>A</kbd>                  | 通知与操作中心    |
| <kbd>Win</kbd>+<kbd>G</kbd>                  | 游戏与多媒体中心  |
| <kbd>Win</kbd>+<kbd>.</kbd>                  | emoji面板         |
| <kbd>Win</kbd>+<kbd>V</kbd>                  | 粘贴板            |
| <kbd>Win</kbd>+<kbd>+</kbd>                  | 放大镜            |
| <kbd>Win</kbd>+<kbd>shift</kbd>+<kbd>c</kbd> | 捕色器            |

| 桌面快捷键                                    | 功能           |
|-----------------------------------------------|----------------|
| <kbd>Win</kbd>+<kbd>D</kbd>                   | 显示桌面       |
| <kbd>Win</kbd>+<kbd>,</kbd>                   | 预览桌面       |
| <kbd>Win</kbd>+<kbd>M</kbd>                   | 最小化所有桌面 |
| <kbd>Win</kbd>+<kbd>L</kbd>                   | 锁定桌面       |
| <kbd>Win</kbd>+<kbd>R</kbd>                   | 运行对话框     |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>D</kbd>   | 新建虚拟桌面   |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>F4</kbd>  | 关闭虚拟桌面   |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>←/→</kbd> | 切换虚拟桌面   |
| <kbd>Win</kbd>+<kbd>Tab</kbd>                 | 多任务视图     |

| 窗口快捷键                        | 功能                   |
|-----------------------------------|------------------------|
| <kbd>Win</kbd>+<kbd>↑/↓/←/→</kbd> | 最大化/最小化/左右分屏 |
| <kbd>Alt</kbd>+<kbd>Tab</kbd>     | 切换窗口               |
| <kbd>Alt</kbd>+<kbd>F4</kbd>      | 关闭窗口               |

