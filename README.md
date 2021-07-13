# Windows10配置
这篇文档做为个我的个人日志，方便下次重装，读者请酌情参考。

## 首先
* 登录Windows个人账户

## 驱动程序
* 下载并安装[MyASUS](https://www.microsoft.com/zh-cn/p/myasus/9n7r5s6b0zzh?activetab=pivot:overviewtab)

## 下载准备
* 下载并安装[Google Chrome](https://www.google.cn/chrome/)

* 设置Chrome的下载目录为`C:\Users\UserName\Downloads\GoogleChrome-Downloads`

* 下载并安装[Bandizip压缩包工具](https://www.bandizip.com/)

* 登录Google账户并同步Chrome配置（包括手动同步TampMonkey脚本）

* 修改`C:\Windows\System32\drivers\etc\hosts`解决DNS污染
```txt
#*********************github 2021-07-12 update********************
#******* get latest hosts: http://blog.yoqi.me/lyq/16489.html
151.101.65.194	github.global.ssl.fastly.net
185.199.108.153	assets-cdn.github.com
185.199.108.153	documentcloud.github.com
140.82.112.4	gist.github.com
185.199.108.133	gist.githubusercontent.com
185.199.108.154	github.githubassets.com
185.199.111.154	help.github.com
140.82.112.10	nodeload.github.com
185.199.108.133	raw.github.com
140.82.113.18	status.github.com
185.199.110.153	training.github.com
185.199.111.133	avatars.githubusercontent.com
185.199.109.133	avatars0.githubusercontent.com
185.199.108.133	avatars1.githubusercontent.com
185.199.108.133	avatars2.githubusercontent.com
185.199.108.133	avatars3.githubusercontent.com
185.199.109.133	avatars4.githubusercontent.com
185.199.108.133	avatars5.githubusercontent.com
185.199.108.133	avatars6.githubusercontent.com
185.199.110.133	avatars7.githubusercontent.com
185.199.109.133	avatars8.githubusercontent.com
185.199.108.133	favicons.githubusercontent.com
140.82.114.10	codeload.github.com
52.217.91.132	github-cloud.s3.amazonaws.com
52.216.28.148	github-com.s3.amazonaws.com
52.217.64.68	github-production-release-asset-2e65be.s3.amazonaws.com
52.217.87.164	github-production-user-asset-6210df.s3.amazonaws.com
52.216.97.155	github-production-repository-file-5c1aeb.s3.amazonaws.com
185.199.111.153	githubstatus.com
64.71.168.201	github.community
185.199.111.133	media.githubusercontent.com
185.199.108.133	camo.githubusercontent.com
185.199.111.133	raw.githubusercontent.com
185.199.111.133	cloud.githubusercontent.com
185.199.109.133	user-images.githubusercontent.com
185.199.109.153	customer-stories-feed.github.com
185.199.110.153	pages.github.com
140.82.112.6	api.github.com
140.82.112.26	live.github.com
140.82.114.29	githubapp.com
140.82.113.3	github.com
```

## 下载软件
* [Microsoft Edge](https://www.microsoft.com/zh-cn/edge)

* [QQ输入法](http://qq.pinyin.cn/)

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
    > 需要将[鼠标主题](cursor)解压并安装到`C:\Windows\Cursors`

* 安装字体
    > Settings -> Personalization -> Fonts  
    > [NerdCodePro Font](windows10/fonts/)

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

* 下载中文包
    > Setting -> Time&Language -> Language


## 开发工具：
* 下载[Windows Terminal](https://www.microsoft.com/zh-cn/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)，
    并安装配置[settings.json](windows10/wt/settings.json)

* 下载[WSL](https://www.microsoft.com/zh-cn/p/ubuntu-2004-lts/9n6svws3rx71?activetab=pivot:overviewtab)
    1. 管理员权限运行`wt`：
        ```sh
        dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
        ```
    2. 重启后，再启动WSL与Ubuntu进行初始化
    3. 升级WSL2：下载[WSL2升级包](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)

* 下载[ArchWSL](https://github.com/yuk7/ArchWSL)或[ManjaroWSL](https://github.com/sileshn/ManjaroWSL)，
* 执行`wsl --set-version <Distro> 2`与`wsl --set-default <Distro>`
* 进入WSL并克隆该仓库然后执行`init.sh`

* 下载[VSCode](https://code.visualstudio.com/download)，并安装插件与配置
    * Remote-WSL
    * Vim
    * C/C++
    * C++ Intellisense
    * Code Runner
<details>
    <summary><b>setting.json for vscode</b></summary>

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
        }
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
        }
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

<br>

* 下载[VS](https://visualstudio.microsoft.com/downloads/#other)并设置工具链的环境变量
    > 控制面板》系统与安全》系统》高级系统设置》环境变量》PATH、LIB、INCLUDE
    * PATH：
        > `C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.27.29110\bin\Hostx64\x64`
    * LIB：
        > `C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.27.29110\lib\x64`  
        > `C:\Program Files (x86)\Windows Kits\10\Lib\10.0.18362.0\ucrt\x64`  
        > `C:\Program Files (x86)\Windows Kits\10\Lib\10.0.18362.0\um\x64`
    * INCLUDE：
        > `C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.27.29110\include`  
        > `C:\Program Files (x86)\Windows Kits\10\Include\10.0.18362.0\ucrt`


# 快捷键

| 文件管理器或文件编辑器快捷键                  | 功能      |
|-----------------------------------------------|-----------|
| <kbd>Ctrl</kbd>+<kbd>A</kbd>                  | 全选      |
| <kbd>Ctrl</kbd>+<kbd>C</kbd>                  | 复制      |
| <kbd>Ctrl</kbd>+<kbd>X</kbd>                  | 剪切      |
| <kbd>Ctrl</kbd>+<kbd>V</kbd>                  | 粘贴      |
| <kbd>Ctrl</kbd>+<kbd>Z</kbd>                  | 撤销      |
| <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Z</kbd> | 撤销      |
| <kbd>Ctrl</kbd>+<kbd>F</kbd>                  | 搜索      |
| <kbd>Ctrl</kbd>+<kbd>O</kbd>                  | 打开      |

| Win快捷键                                    | 功能              |
|----------------------------------------------|-------------------|
| <kbd>Win</kbd>+<kbd>num</kbd>                | 任务栏第num个软件 |
| <kbd>Win</kbd>+<kbd>E</kbd>                  | 文件管理器        |
| <kbd>Win</kbd>+<kbd>R</kbd>                  | 运行对话框        |
| <kbd>Win</kbd>+<kbd>I</kbd>                  | 设置中心          |
| <kbd>Win</kbd>+<kbd>A</kbd>                  | 通知与操作中心    |
| <kbd>Win</kbd>+<kbd>G</kbd>                  | 游戏与多媒体中心  |
| <kbd>Win</kbd>+<kbd>+</kbd>                  | 放大镜            |
| <kbd>Win</kbd>+<kbd>shift</kbd>+<kbd>c</kbd> | 捕色器            |

| 桌面快捷键                                    | 功能           |
|-----------------------------------------------|----------------|
| <kbd>Win</kbd>+<kbd>D</kbd>                   | 显示桌面       |
| <kbd>Win</kbd>+<kbd>,</kbd>                   | 预览桌面       |
| <kbd>Win</kbd>+<kbd>M</kbd>                   | 最小化所有桌面 |
| <kbd>Win</kbd>+<kbd>L</kbd>                   | 锁定桌面       |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>D</kbd>   | 新建虚拟桌面   |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>F4</kbd>  | 关闭虚拟桌面   |
| <kbd>Ctrl</kbd>+<kbd>Win</kbd>+<kbd>←/→</kbd> | 切换虚拟桌面   |
| <kbd>Win</kbd>+<kbd>Tab</kbd>                 | 多任务视图     |

| 窗口快捷键                        | 功能                   |
|-----------------------------------|------------------------|
| <kbd>Win</kbd>+<kbd>↑/↓/←/→</kbd> | 最大化/最小化/左右分屏 |
| <kbd>Alt</kbd>+<kbd>Tab</kbd>     | 切换窗口               |
| <kbd>Win</kbd>+<kbd>Q</kbd>       | 关闭窗口               |

| 输入法相关                                    | 功能         |
|-----------------------------------------------|--------------|
| <kbd>Ctrl</kbd>+<kbd>.</kbd>                  | 切换全角半角 |
| <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>F</kbd> | 切换繁/简体  |
| <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>E</kbd> | 切换中/英文  |
| <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> | 切换全/双拼  |
| <kbd>Win</kbd>+<kbd>V</kbd>                   | 系统剪切板   |
| <kbd>Win</kbd>+<kbd>.</kbd>                   | emoji表情    |
