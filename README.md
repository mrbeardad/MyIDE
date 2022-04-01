# 目录
- [目录](#目录)
- [Windows](#windows)
- [WSL](#wsl)
- [VSCode](#vscode)
- [Others](#others)

# Windows
1. 下载并安装[MyASUS 华硕管家](https://www.microsoft.com/zh-cn/p/myasus/9n7r5s6b0zzh?activetab=pivot:overviewtab)，自动安装驱动
2. 下载并安装[Google Chrome浏览器](https://www.google.cn/chrome/)
3. 登录Google Chrome账户，自动同步Chrome配置并手动同步TampMonkey配置
4. 下载并安装[Bandizip压缩包工具](https://www.bandizip.com/)
5. 下载常用软件
    * [QQ 输入法](http://qq.pinyin.cn/)
    * [TIM 聊天通讯](https://tim.qq.com)
    * [WeChat 微信](https://pc.weixin.qq.com/?lang=zh_CN)
    * [百度网盘](https://pan.baidu.com/downloads)
    * [Listen1 音乐](https://www.zhyong.cn/posts/64cd/)
    * [Office 办公套件](https://www.office.com/)
    * [CHFS 局域网Http服务器](http://iscute.cn/chfs)
    * [PowerToys 工具集](https://github.com/microsoft/PowerToys/releases)
    * [Listary 搜索工具](https://www.listarypro.com/download)
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
    
    * Acount
       * Your info: 登录账户
       * Sync your srttings: 同步配置
    * System
      * Display: 夜间暖色
      * Clipboard: 启用剪切板
      * About: 更改主机名
    * Devices
      * Bluetooth & other devices: 关闭蓝牙
      * Touchpad: 设置触摸板手势
      * Typing
        * Advanced Keyboard Settings
          * Input Language hot keys: 设置系统输入法热键
    * Personalization
      * Theme
        * Background: 设置桌面壁纸
        * Colors: 设置主题颜色
        * Mouse Cursor: 设置[鼠标主题](https://zhutix.com/tag/cursors/)
      * Fonts: 设置字体
        1. 安装[noMeiryoUI 字体设置](https://github.com/Tatsu-syo/noMeiryoUI/releases)
        2. 安装[MacType 字体渲染](https://github.com/snowie2000/mactype/releases)
        3. 安装[NerdCodePro字体](fonts/)
      * Start: 设置开始界面
        1. 开启所有选项
        2. 排版磁条
      * Taskbar: 设置任务栏界面
        1. 安装[TranslucentTB 透明任务栏](https://www.microsoft.com/zh-cn/p/translucenttb/9pf4kz2vn4w9?activetab=pivot:overviewtab)
        2. 安装[XMeters 资源监测器](https://entropy6.com/xmeters/)
        3. 居中任务栏图标
        4. 隐藏桌面图标
    * Apps
      * Apps & features: 卸载多余软件
      * Startup: 管理开机自启软件
    * Time & Language: 自动同步时间与时区，并显示农历
    * Region: 设置所在地区与日期时间显示格式
    * Language: 设置系统显示语言为英语，并下载中文包
      * Administrative language settings
        * Change system locale: 选择中文语系并取消勾选Beta设置
    * Ease of Access
      * Mouse pointer: 更改鼠标大小
      * Keyboard: 键盘锁按键提示音
</details>

[**Windows使用手册**](windows.md)

# WSL
1. 安装[Windows Terminal](https://www.microsoft.com/zh-cn/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)
2. 安装wt配置[settings.json](WindowsTerminal/settings.json)
3. 将[WindowsTerminalQuakeModeStartup.bat](WindowsTerminal/WindowsTerminalQuakeModeStartup.bat)复制到*%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup*
3. 安装[Ubuntu WSL](https://www.microsoft.com/zh-cn/p/ubuntu-2004-lts/9n6svws3rx71?activetab=pivot:overviewtab)
4. 启用WSL2：控制面板》程序》开关Windows特性》开启"Virtual Machine Platform"与"Windows Subsystem for Linux"
5. 限制WSL2内存使用
  ```conf
  # %USERPROFILE%\.wslconfig
  [wsl2]
  memory=4GB
  swap=0
  ```
6. 设置WSL2为默认并初始化Ubuntu20.04
    ```sh
    # in powershell
    wsl --list --all -v
    wsl --set-version Ubuntu20.04 2
    wsl --set-default Ubuntu20.04
    wsl # 进入wsl
    ```
7. 配置Ubuntu20.04 WSL
    ```sh
    # in wsl
    mkdir ~/.local
    git clone https://github.com/mrbeardad/My-IDE .local/My-IDE
    cd .local/My-IDE && ./init.ubuntu20.04.wsl.sh
    ```
    
[**wsl使用手册**](wsl.md)

# VSCode
1. 下载并安装[VSCode](https://code.visualstudio.com/download)，登录账户并同步配置。

2. 下载并安装[git](https://git-scm.com/downloads)

3. 下载并安装[neovim](https://github.com/neovim/neovim/releases/)，然后安装配置[vscode-neovim](vscode/vscode-neovim/)
   1. 修改[init.vim](vscode/vscode-neovim/init.vim)中第97行路径为[vscode-neovim/plugged](vscode/vscode-neovim/plugged/)安装路径
   2. 修改vscode配置neoviim安装路径

4. 下载并安装[VS for c++](https://visualstudio.microsoft.com/downloads/#other)并设置工具链的环境变量
    > Settings -> advanced system settings
    * PATH：
        > `C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.27.29110\bin\Hostx64\x64`
    * LIB：
        > `C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.27.29110\lib\x64`
        > `C:\Program Files (x86)\Windows Kits\10\Lib\10.0.18362.0\ucrt\x64`
        > `C:\Program Files (x86)\Windows Kits\10\Lib\10.0.18362.0\um\x64`
    * INCLUDE：
        > `C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.27.29110\include`
        > `C:\Program Files (x86)\Windows Kits\10\Include\10.0.18362.0\ucrt`

[**vscode使用手册**](vscode.md)

# Others
* 下载并安装[SwitchHosts](https://github.com/oldj/SwitchHosts/releases)

* 下载并安装[Postman](https://www.postman.com/downloads/)

* 下载并安装[Navicat](# "太TM贵了")

* 下载并安装[ARDM](https://github.com/qishibo/AnotherRedisDesktopManager/releases)
