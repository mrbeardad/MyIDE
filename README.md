# The Best IDE Strategy for Myself

<!-- vim-markdown-toc GFM -->

- [The Best IDE Strategy for Myself](#the-best-ide-strategy-for-myself)
  - [Windows](#windows)
  - [WSL](#wsl)
  - [VSCode](#vscode)
  - [Others](#others)
  - [Language](#language)

<!-- vim-markdown-toc -->

## Windows

1. 安装[MyASUS 华硕管家](https://www.microsoft.com/zh-cn/p/myasus/9n7r5s6b0zzh?activetab=pivot:overviewtab)，自动安装驱动
2. 安装[Google Chrome 浏览器](https://www.google.cn/chrome/)
3. 登录 Google Chrome 账户并自动同步配置
4. 安装[Bandizip 压缩包工具](http://www.bandisoft.com/bandizip/old/6/)
5. 安装常用软件

   - [搜狗输入法](https://pinyin.sogou.com/)
   - [TIM](https://tim.qq.com)
   - [微信](https://pc.weixin.qq.com/?lang=zh_CN)
   - [腾讯会议](https://meeting.tencent.com/download-center.html)
   - [Listen1 音乐](https://www.zhyong.cn/posts/64cd/)
   - [Office 办公套件](https://www.office.com/)
   - [局域网 Http 服务器](http://iscute.cn/chfs)
   - [PowerToys 工具集](https://github.com/microsoft/PowerToys/releases)
   - [Listary 搜索工具](https://www.listarypro.com/download)
       <details>
           <summary><b>...</b></summary>

     ```txt
     产  品：Listary授权信息
     姓  名：准女婿
     邮  箱：welcome5201311@163.com
     注册码：
     DR6QRNJBSYB344AJ7NJA3EKZC9B2PMWV
     KF2HP9CAQSJMBZCJXM8KSH4H3XYPAKNS
     WRR6ZBJ3HQPPZGF8FL88VQSNZ27EAW8S
     AAV6TVFGLQZTHGJCAEMAKG74573ZTDDG
     8NMLXAMZVJ6546QZLE7VTYZRNFKMHUBB
     JNWC2T2FR3EKVUDA2JEL85RDHLVFBC4Q
     复制代码


     复制代码
     姓  名：准女婿
     邮  箱：welcome5201311@163.com
     注册码：
     AQUTK8NRYKGREDZMS68GPG9NPDYSYJJK
     FGQ2ZL8B6Z3STGXEST27EAS67F77HR6M
     CW7Y6YA85T75AQUX7W3CYBNJLCJE7GY9
     WA3HSDTA8YLT2FPF8YMXWWWFLT4NQK4F
     C3LUGRGZR5R29CYAUPZ4XUEXDLGFZNGV
     JNWC2T2FR3EKULSBLMG9NLPJWRW29WYH
     复制代码


     复制代码
     姓  名：准女婿
     邮  箱：welcome5201311@znx_52pojie.com
     注册码：
     JRWX9QN8GJYF9J3S27KYKY2F7UGCW9QD
     VUHQL8ZBERXM9KMY8UM8P23QKYDXHTCW
     VHD2WNSSP8CV755UFGALVG34XYEENR76
     YSKTDDH29DEVTYD9V5TV8HLMRVGEUVC5
     XKE62QZA7YH97CBBA5V7V53MC6XC89N6
     4YA4DWA2TZ4VU8VT8S3R89W6HBKG3J42
     ```

       </details>

6. <details>
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
       1. 安装[noMeiryoUI 字体设置](https://github.com/Tatsu-syo/noMeiryoUI/releases)
       2. 安装[MacType 字体渲染](https://github.com/snowie2000/mactype/releases)
       3. 安装[NerdCodePro 字体](fonts/)
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

  </details>

[**Windows 使用手册**](windows.md)

## WSL

1. 安装[Windows Terminal](https://www.microsoft.com/zh-cn/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)
2. 安装 wt 配置[settings.json](wt/settings.json)
3. 创建启动脚本`wt_quake.vbs`于文件夹`%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`实现开机自启 quake 模式

   ```vbs
   CreateObject("Wscript.Shell").Run "wt -w _quake", 0, True
   ```

4. 安装[dual-key-remap](https://github.com/ililim/dual-key-remap/releases)映射 CapsLock 键为“单击为 Esc，组合为 Ctrl”

   1. 解压文件夹到`%USERPROFILE%\AppData\Local`
   2. 按照[教程](https://winaero.com/create-elevated-shortcut-to-skip-uac-prompt-in-windows-10/)创建一个无 UAC 提示的应用程序快捷方式，并将快捷方式创建到 `%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`

      ```vbs
      CreateObject("Wscript.Shell").Run "schtasks /run /tn dual-key-remap-elevated", 0, True
      ```

   3. 当前手动启动即可，之后便开机自启

5. 安装[WSL2](https://docs.microsoft.com/en-us/windows/wsl/install)

   ```sh
   # in windows cmd on administrator mode
   wsl.exe --update
   wsl.exe --install
   ```

6. 限制 WSL2 [内存使用](https://github.com/microsoft/WSL/issues/4166#issuecomment-526725261)，`%USERPROFILE%\.wslconfig`

   ```ini
   [wsl2]
   memory=4GB
   swap=0
   ```

7. 配置 WSL 开发环境, [init.sh](init.sh)中包含我 linux 开发环境全套配置, 可以很方便的进行分发

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

[**wsl 使用手册**](wsl.md)

## VSCode

1. 下载并安装[VSCode](https://code.visualstudio.com/download)，登录账户并同步[配置](vscode/)。

2. 下载并安装[NeoVim](https://github.com/neovim/neovim/releases/)，然后
   1. 安装配置目录[vscode-neovim](vscode/vscode-neovim/)到`%USERPROFILE%\AppData\Local\vscode-neovim`
   2. vscode 配置 `init.vim` 路径为`%USERPROFILE%\AppData\Local\vscode-neovim\init.vim`
   3. vscode 配置 `nvim.exe` 安装路径

[**vscode 使用手册**](vscode.md)

## Others
- 安装[GitKraken](https://release.axocdn.com/win64/GitKrakenSetup-6.5.1.exe "破解工具GitCracken")

- 安装[SwitchHosts](https://github.com/oldj/SwitchHosts/releases)

- 安装[Postman](https://www.postman.com/downloads/)

- 安装[Navicat](## "祖安人自有祖安的方法搞到手")

- 安装[ARDM](https://github.com/qishibo/AnotherRedisDesktopManager/releases)

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
