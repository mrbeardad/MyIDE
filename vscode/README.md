<!--
 * @FilePath: /My-IDE/vscode/README.md
 * @Description: 
 * @Author: Heache Bear <mrbeardad@qq.com>
 * @Date: 2022-03-25 21:20:55
 * @LastEditTime: 2022-03-28 00:03:43
 * @LastEditors: Heache Bear <mrbeardad@qq.com>
 * Copyright (c) 2018 - 2022 Heachen Bear & Contributors
-->
# 目录
- [目录](#目录)
- [插入模式](#插入模式)
- [普通模式](#普通模式)
- [复制粘贴](#复制粘贴)
- [高效编辑](#高效编辑)
- [书签标记](#书签标记)
- [窗口操作](#窗口操作)
- [界面元素](#界面元素)
- [其他按键](#其他按键)
- [开发调试](#开发调试)
- [Markdown](#markdown)
- [Cpp](#cpp)
# 插入模式

| 按键               | 作用           |
| ------------------ | -------------- |
| `Ctrl`+`A`         | 行首           |
| `Ctrl`+`E`         | 行尾           |
| `Ctrl`+`←`         | 左移一个单词   |
| `Ctrl`+`→`         | 右移一个单词   |
| `Shift`+`←`        | 左移本行       |
| `Shift`+`→`        | 右移本行       |
| `Shift`+`↓`        | 下移本行       |
| `Shift`+`↑`        | 上移本行       |
| `Ctrl`+`Enter`     | 下行插入       |
| `Ctrl`+`W`         | 删除光标前单词 |
| `Ctrl`+`U`         | 删除光标前文本 |
| `Ctrl`+`K`         | 删除光标后文本 |
| `Ctrl`+`L`         | 删除光标后字符 |
| `Ctrl`+`Z`         | 撤销           |
| `Ctrl`+`Shift`+`Z` | 重做           |

# 普通模式

* 复合操作符：
   `d` `c` `y` `gu` `gU` `g~` `v`
* 光标移动：
   `0` `^` `$` `w` `W` `b` `B` `e` `E` `ge` `gE` `(` `)` `{` `}`
   `gm` `f` `F`
   `gg` `G` `%` `H` `L` `M`
* 文本对象：
   `w` `s` `p` `(` `{` `[` `<` `"` `'` `` ` ``
   `e` `l` `i` `f` `,`

    | 按键           | 作用                      |
    | -------------- | ------------------------- |
    | `Ctrl`+`A`     | 行首                      |
    | `Ctrl`+`E`     | 行尾                      |
    | `Ctrl`+`←`     | 左移一个单词              |
    | `Ctrl`+`→`     | 右移一个单词              |
    | `Shift`+`←`    | 左移本行                  |
    | `Shift`+`→`    | 右移本行                  |
    | `Shift`+`↓`    | 下移本行                  |
    | `Shift`+`↑`    | 上移本行                  |
    | `Ctrl`+`Enter` | 下行插入                  |
    | `r`            | 替换光标下字符            |
    | `R`            | 从光标位置开始替换        |
    | `~`            | 反转字符大小写            |
    | `x`            | 删除字符                  |
    | `s`            | 删除字符并进入insert      |
    | `D`            | 删除直到行尾              |
    | `C`            | 删除直到行尾并进入insert  |
    | `dd`           | 删除当前行                |
    | `cc`           | 删除当前行并进入insert    |
    | `.`            | 重复上次操作              |
    | `u`            | undo(按栈序)              |
    | `Ctrl`+`R`     | redo(按栈序)              |
    | `Ctrl`+`O`     | 后向跳转                  |
    | `Ctrl`+`I`     | 前向跳转                  |
    | `g;`           | 跳转旧的修改处            |
    | `g,`           | 跳转新的修改处            |
    | `gi`           | 跳转上次插入处            |
    | `gv`           | 跳转上次选择处            |
    | `;` `{char}`   | 跳转字符{char}处          |
    | `f/F` `{char}` | 跳转下/上一个字符{char}处 |

# 复制粘贴

| 按键        | 作用                         |
| ----------- | ---------------------------- |
| `y`         | 复制到0号寄存器              |
| `Y`         | 复制光标后文本到0号寄存器    |
| `=p`        | 粘贴0号寄存器到光标后        |
| `=P`        | 粘贴0号寄存器到光标钱        |
| `=o`        | 粘贴0号寄存器到下行          |
| `=O`        | 粘贴0号寄存器到上行          |
| `\y`        | 复制到系统剪切板             |
| `\Y`        | 复制光标后文本到系统剪切板   |
| `Space` `y` | 复制整个文件到系统剪切板     |
| `\p`        | 粘贴系统剪切板到光标后       |
| `\P`        | 粘贴系统剪切板到光标钱       |
| `\o`        | 粘贴系统剪切板到下行         |
| `\O`        | 粘贴系统剪切板到上行         |
| `Space` `p` | 粘贴系统剪切板覆盖至当前文件 |

# 高效编辑

| 按键                       | 作用                                  |
| -------------------------- | ------------------------------------- |
| `Tab`                      | 下个补全项                            |
| `Shift`+`Tab`              | 上个补全项                            |
| `Enter`                    | 选中补全项                            |
| `Ctrl`+`\`                 | 手动触发补全列表                      |
| `Tab`                      | 根据snippet前缀补全代码片段或下个锚点 |
| `Shift`+`Tab`              | 上个代码片段锚点                      |
| `Alt`+`\`                  | 手动搜索snippet                       |
| `Ctrl`+`/`                 | 注释代码                              |
| `Alt`+`E`                  | 快速包围                              |
| `ys` `{text-obj}` `{char}` | 添加包围符                            |
| `yss` `{char}`             | 为改行添加包围符                      |
| `ds` `{char}` `{char}`     | 删除包围符                            |
| `cs` `{char}` `{char}`     | 替换包围符                            |
| `Ctrl`+`N`                 | 选中下个匹配单词并添加光标            |
| `Ctrl`+`Shift`+`N`         | 选中上个匹配单词并添加光标            |
| `Ctrl`+`Shift`+`L`         | 所有匹配当前单词的地方添加光标        |
| `Ctrl`+`LeftMouse`         | 添加多光标                            |
| `Ctrl`+`Shift`+`LeftMouse` | 块选择并添加多光标                    |

# 书签标记

| 按键           | 作用               |
| -------------- | ------------------ |
| `Ctrl`+`M` `m` | 切换标签状态       |
| `Ctrl`+`M` `i` | 为标签添加注释     |
| `Ctrl`+`M` `n` | 跳转至下一个标签   |
| `Ctrl`+`M` `b` | 跳转至上一个标签   |
| `Ctrl`+`M` `l` | 列出当前文件的标签 |
| `Ctrl`+`M` `L` | 列出所有标签       |
| `Ctrl`+`M` `c` | 删除当前文件的标签 |
| `Ctrl`+`M` `C` | 删除所有标签       |

# 窗口操作

| 按键                   | 作用                                    |
| ---------------------- | --------------------------------------- |
| `Ctrl`+`W` `↑`         | 跳转上方的Editor Group，`↓` `←` `→`同理 |
| `Ctrl`+`W` `Shift`+`K` | 将Editor Group上移，`H` `J` `L`同理     |
| `Ctrl`+`1`             | 跳转指定Editor Group，其他数字同理      |
| `Ctrl`+`Tab`           | 快速切换Editor                          |
| `Tab`                  | 跳转下个Editor Group                    |
| `Shift`+`Tab`          | 跳转上个Editor Group                    |
| `Ctrl`+`W` `=`         | 均布Editor Group窗口大小                |
| `Ctrl`+`W` `v`         | 竖直切分                                |
| `Ctrl`+`W` `s`         | 水平切分                                |
| `Ctrl`+`W` `o`         | 仅保留当前Editor                        |
| `Ctrl`+`W` `c`         | 关闭当前Editor                          |
| `Ctrl`+`Shift`+`W`     | 关闭当前Editor                          |
| `Ctrl`+`Shift`+`T`     | 重开关闭的Editor                        |

# 界面元素

| 按键                   | 作用                     |
| ---------------------- | ------------------------ |
| `F1`                   | 开关Side Bar             |
| `Ctrl`+`Shift`+`E`     | 文件树、标签栏、文件历史 |
| `Ctrl`+`Shift`+`G` `g` | 版本管理器               |
| `Ctrl`+`Shift`+`D`     | Debug展示器              |
| `Ctrl`+`Shift`+`F`     | 搜索文件内容             |
| `Ctrl`+`Shift`+`H`     | 替換文件內容             |
| `Alt`+`C`              | 搜索时是否大小写敏感     |
| `Alt`+`W`              | 搜索时是否匹配单词边界   |
| `Alt`+`R`              | 搜索时是否使用正则引擎   |
| `Ctrl`+`P`             | 搜索文件路径             |
| `Ctrl`+`Shift`+`P`     | 搜索命令                 |
| `Ctrl`+`Shift`+`O`     | 搜索本地标签             |
| `Ctrl`+`T`             | 搜索全局标签             |
| `Ctrl`+`Shift`+`M`     | Problem窗口              |
| `Alt`+`` ` ``          | Terminal窗口             |

# 其他按键

| 按键              | 作用                           |
| ----------------- | ------------------------------ |
| `g&`              | 当前行重复上次:s命令           |
| `ga`              | 查看ascii字符编码或unicode码点 |
| `g8`              | 查看utf-8字符编码              |
| `Alt`+`Z`         | 是否长行回绕                   |
| `Alt`+`Shift`+`E` | 在Explorer中打开文件目录       |
| `Alt`+`Shift`+`F` | 格式化文本                     |
| `Alt`+`Shift`+`H` | 添加文件头部信息               |
| `Alt`+`Shift`+`C` | 计算器                         |
| `Alt`+`Shift`+`T` | 翻译并替换选择文本             |
| `Alt`+`Shift`+`R` | 快速运行单个代码文件           |

# 开发调试
* 编译：
   1. 编写tasks.json（`Ctrl`+`Shift`+`P`）
   2. 搜索tasks（`Ctrl`+`P`输入`task `）
   3. 执行tasks

* 调试：
   1. 编写launch.json（`Ctrl`+`Shift`+`D`）
   2. 启动调试（`F5`）
   3. 跳转定义（`F12`）
   4. 跳转引用（`Shift`+`F12`）
   5. 重构（`F2`）


# Markdown
| 按键               | 作用               |
| ------------------ | ------------------ |
| `Ctrl`+`Shift`+`V` | Markdown预览       |
| `Ctrl`+`Shift`+`]` | 标题(uplevel)      |
| `Ctrl`+`Shift`+`[` | 标题(downlevel)    |
| `Ctrl`+`B`         | 粗体               |
| `Ctrl`+`I`         | 斜体               |
| `Alt`+`C`          | check/uncheck task |

# Cpp
1. 编写CMakeLists.txt文件
```cmake
if(DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
    add_compile_options(
        -O2
        -Weverything
        -Wno-c++98-compat
        -Wno-c++98-compat-pedantic
        -Wno-pedantic
        -Wno-missing-prototypes
        -Wno-padded
        -Wno-old-style-cast
        -Wno-global-constructors
        -Wno-exit-time-destructors
    )
endif()
```
2. cmake配置构建目录
```sh
cd build && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS src_dir
```

3. 链接构建参数文件
```sh
cd src_dir && ln -s build/compile_commands.json .
```