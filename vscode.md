# VSCode Key Bindings

- [VSCode Key Bindings](#vscode-key-bindings)
  - [光标移动](#光标移动)
  - [屏幕滚动](#屏幕滚动)
  - [快速编辑](#快速编辑)
  - [普通模式](#普通模式)
  - [搜索导航](#搜索导航)
  - [书签标记](#书签标记)
  - [Editor 操作](#editor-操作)
  - [Group 操作](#group-操作)
  - [界面元素](#界面元素)
  - [其他按键](#其他按键)
  - [开发调试](#开发调试)
    - [Markdown](#markdown)
    - [Cpp](#cpp)

## 光标移动

**不要在插入模式下执行任何光标移动操作！**

| 按键               | 作用                         |
| ------------------ | ---------------------------- |
| `h`\|`j`\|`k`\|`l` | 左/下/上/右                  |
| `w`\|`e`\|`b`      | 下个单词头/单词尾/上个单词头 |
| `Ctrl`+`A`/`E`     | 行首/尾                      |
| `f`/`F`+`{char}`   | 下/上一个字符`{char}`        |
| `;` `{char}`       | 选择并跳转到指定字符`{char}` |
| `%`                | 跳转结对符                   |
| `gg`               | 第一行                       |
| `G`                | 最后一行                     |
| `{num}` `G`        | 跳转第`{num}`行              |

## 屏幕滚动

| 按键           | 作用               |
| -------------- | ------------------ |
| `Ctrl`+`D`/`B` | 向下/上翻页滚屏    |
| `Ctrl`+`↓`/`↑` | 向下/上逐行滚屏    |
| `zz`           | 滚屏到光标行       |
| `M`            | 移动光标到屏幕中央 |

## 快速编辑

| 按键                   | 作用                                    |
| ---------------------- | --------------------------------------- |
| `Shift`+`←`/`Ctrl`+`D` | 左移本行                                |
| `Shift`+`→`/`Ctrl`+`T` | 右移本行                                |
| `Shift`+`↓`            | 下移本行                                |
| `Shift`+`↑`            | 上移本行                                |
| `Ctrl`+`Enter`         | 下行插入                                |
| `Ctrl`+`W`             | 删除光标前单词                          |
| `Ctrl`+`U`             | 删除光标前文本                          |
| `Ctrl`+`K`             | 删除光标后文本                          |
| `Ctrl`+`L`             | 删除光标后单词                          |
| `Ctrl`+`Z`             | 撤销                                    |
| `Ctrl`+`R`             | 重做                                    |
| `F2`                   | 重构变量名                              |
| `Ctrl`+`\`             | 手动触发补全列表                        |
| `Tab`                  | 下个补全项                              |
| `Shift`+`Tab`          | 上个补全项                              |
| `Enter`                | 选中补全项                              |
| `Alt`+`\`              | 手动搜索 snippet                        |
| `Tab`                  | 根据 snippet 前缀补全代码片段或下个锚点 |
| `Shift`+`Tab`          | 上个代码片段锚点                        |
| `Ctrl`+`/`             | 注释代码                                |
| `mi`\|`ma`             | 多光标插入（visual 模式）               |
| `Ctrl`+`N`             | 选中下个匹配单词并添加光标              |
| `Ctrl`+`Shift`+`N`     | 选中上个匹配单词并添加光标              |
| `Ctrl`+`Shift`+`L`     | 所有匹配当前单词的地方添加光标          |
| `Ctrl`+`LeftMouse`     | 添加多光标                              |

## 普通模式

- 复合操作符：
  > `d` `c` `y` `gu` `gU` `g~`
- 光标移动：
  > `0` `^` `$` `w` `W` `b` `B` `e` `E` `(` `)` `{` `}`  
  > `f` `F` `gg` `G` `%` `H` `L` `M`
- 文本对象：
  > `w` `s` `p` `(` `{` `[` `<` `"` `'` `` ` ``  
  > `e` `l` `i` `f` `,`

| 按键                      | 作用                         |
| ------------------------- | ---------------------------- |
| `~`                       | 反转字符大小写               |
| `r`                       | 替换光标下字符               |
| `x`                       | 删除字符                     |
| `s`                       | 删除字符并进入 insert        |
| `R`                       | 从光标位置开始替换           |
| `D`                       | 删除直到行尾                 |
| `C`                       | 删除直到行尾并进入 insert    |
| `dd`                      | 删除当前行                   |
| `cc`                      | 删除当前行并进入 insert      |
| `ys` `{textobj}` `{char}` | 添加包围符                   |
| `ds` `{char}` `{char}`    | 删除包围符                   |
| `cs` `{char}` `{char}`    | 替换包围符                   |
| `.`                       | 重复上次修改操作             |
| `y`                       | 复制到 0 号寄存器            |
| `Y`                       | 复制光标后文本到 0 号寄存器  |
| `\y`                      | 复制到系统剪切板             |
| `\Y`                      | 复制标光后文本到系统剪切板   |
| `Space` `y`               | 复制整个文件到系统剪切板     |
| `=p`\|`=P`                | 粘贴 0 号寄存器到光标后/前   |
| `=o`\|`=O`                | 粘贴 0 号寄存器到下/上行     |
| `\p`\|`=P`                | 粘贴系统剪切板到光标后/前    |
| `\o`\|`=O`                | 粘贴系统剪切板到下/上行      |
| `Space` `p`               | 粘贴系统剪切板覆盖至当前文件 |

## 搜索导航

| 按键                         | 作用                   |
| ---------------------------- | ---------------------- |
| `Alt`+`C`                    | 搜索时是否大小写敏感   |
| `Alt`+`W`                    | 搜索时是否匹配单词边界 |
| `Alt`+`R`                    | 搜索时是否使用正则引擎 |
| `Ctrl`+`F`                   | 搜索当前文件内容       |
| `Ctrl`+`H`                   | 替换当前文件内容       |
| `Ctrl`+`Shift`+`F`           | 搜索目录所有文件内容   |
| `Ctrl`+`Shift`+`H`           | 替換目录所有文件內容   |
| `Ctrl`+`P`                   | 搜索文件               |
| `Ctrl`+`Shift`+`P`           | 搜索命令               |
| `Ctrl`+`Shift`+`O`           | 搜索本地标签           |
| `Ctrl`+`T`                   | 搜索全局标签           |
| `F12`\|`Alt`+`Click`\|`gd`   | 跳转定义或声明         |
| `Shift`+`F12`                | 跳转引用               |
| `Ctrl`+`F12`                 | 跳转实现               |
| `Ctrl`+`O`\|`Mouse Backward` | 后向跳转               |
| `Ctrl`+`I`\|`Mouse Forward`  | 前向跳转               |

## 书签标记

| 按键           | 作用                   |
| -------------- | ---------------------- |
| `Ctrl`+`M` `m` | 切换标签状态           |
| `Ctrl`+`M` `i` | 为标签添加注释         |
| `Ctrl`+`M` `n` | 跳转至下一个标签       |
| `Ctrl`+`M` `b` | 跳转至上一个标签       |
| `Ctrl`+`M` `l` | 列出当前文件的标签     |
| `Ctrl`+`M` `L` | 列出所有标签           |
| `Ctrl`+`M` `c` | 删除当前文件的标签     |
| `Ctrl`+`M` `C` | 删除所有标签           |
| `m` `{char}`   | vim 标签，大写字母全局 |
| `'` `{char}`   | 跳转 vim 标签          |

## Editor 操作

| 按键                  | 作用                   |
| --------------------- | ---------------------- |
| `Ctrl`+`Tab`          | 快速切换               |
| `\n`                  | 下个 editor            |
| `\b`                  | 上个 editor            |
| `Ctrl`+`K` `n`        | 新建文件               |
| `Ctrl`+`K` `o`        | 打开文件               |
| `Ctrl`+`K` `Ctrl`+`O` | 打开目录               |
| `Ctrl`+`K` `r`        | 打开最近访问文件或目录 |
| `Ctrl`+`S`            | 保存                   |
| `Ctrl`+`Shift`+`S`    | 另存为                 |
| `Ctrl`+`K` `s`        | 保存所有               |
| `Ctrl`+`Shift`+`W`    | 关闭当前文件           |
| `Ctrl`+`K` `u`        | 关闭已保存文件         |
| `Ctrl`+`K` `w`        | 关闭其他文件           |
| `Ctrl`+`Shift`+`T`    | 重开关闭的 Editor      |

## Group 操作

| 按键                               | 作用                                |
| ---------------------------------- | ----------------------------------- |
| `Tab`\|`Shift`+`Tab`               | 跳转下/上个 Group                   |
| `Ctrl`+`1~8`                       | 跳转指定第 1~8 个 Group             |
| `Ctrl`+`W` `↑`/`↓`/`←`/`→`         | 跳转上/下/左/右方的 Group           |
| `Ctrl`+`W` `Shift`+`H`/`J`/`K`/`L` | 与/左/下/上/右方 Group 上移交换位置 |
| `Ctrl`+`W` `=`                     | 均布 Group 窗口大小                 |
| `Ctrl`+`W` `v`                     | 竖直切分                            |
| `Ctrl`+`W` `s`                     | 水平切分                            |
| `Ctrl`+`W` `o`                     | 仅保留当前 Group                    |

## 界面元素

| 按键                   | 作用               |
| ---------------------- | ------------------ |
| `F1`                   | 开关 Side Bar      |
| `Ctrl`+`Shift`+`E`     | 文件树-标签栏-TODO |
| `Ctrl`+`Shift`+`D`     | 调试器             |
| `Ctrl`+`Shift`+`G` `g` | 版本管理器         |
| `Ctrl`+`Shift`+`M`     | Problem 窗口       |
| `Alt`+`` ` ``          | Terminal 窗口      |

## 其他按键

| 按键              | 作用                               |
| ----------------- | ---------------------------------- |
| `:s/pat/rep/g`    | 替换命令                           |
| `g&`              | 当前行重复上次替换命令             |
| `q` `{char}`      | 宏录制                             |
| `@` `{char}`      | 应用宏                             |
| `@@`              | 应用上次宏                         |
| `ga`              | 查看 ascii 字符编码或 unicode 码点 |
| `g8`              | 查看 utf-8 字符编码                |
| `K`               | 触发鼠标悬停                       |
| `Alt`+`Z`         | 是否长行回绕                       |
| `Alt`+`Shift`+`E` | 在 Explorer 中打开文件目录         |
| `Alt`+`Shift`+`R` | 快速运行单个代码文件               |
| `Alt`+`T`         | 切换鼠标悬停翻译                   |
| `Alt`+`Shift`+`T` | 翻译选择文本                       |
| `Alt`+`Shift`+`F` | 格式化文本                         |
| `Alt`+`Shift`+`C` | 计算器                             |
| `:VSCodeCounter`  | 项目代码统计                       |

## 开发调试

- 编译：

  1. 编写 tasks.json（`Ctrl`+`Shift`+`P`搜索"task"）
  2. 执行 task（`Ctrl`+`P`输入`task `）

- 调试：
  1. 编写 launch.json（`Ctrl`+`Shift`+`D`）
  2. 启动调试（`F5`）

### Markdown

| 按键               | 作用                         |
| ------------------ | ---------------------------- |
| `Ctrl`+`Shift`+`V` | Markdown 预览（当前 Editor） |
| `Ctrl`+`K` `V`     | Markdown 预览（切分 Editor） |
| `Ctrl`+`Shift`+`]` | 标题(uplevel)                |
| `Ctrl`+`Shift`+`[` | 标题(downlevel)              |
| `Ctrl`+`B`         | 粗体                         |
| `Ctrl`+`I`         | 斜体                         |
| `Alt`+`C`          | check/uncheck task           |

### Cpp

1. 编写 CMakeLists.txt 文件并添加

```cmake
if(${CMAKE_BUILD_TYPE} STREQUAL Debug)
    add_compile_options(
        -g3
        -Wall
        -Wextra
    )
endif()
```

2. cmake 配置构建目录并导出 compile_commands.json

```sh
mkdir build
cd build
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=DEBUG ..
```

3. 编写.clangd

```yaml
CompileFlags:
  CompilationDatabase: build
Completion:
  AllScopes: yes
Hover:
  ShowAKA: yes
```

4. 编写.clang-tidy

```yaml
Checks: "-*,bugprone-*,cert-dcl21-cpp,cert-dcl50-cpp,cert-env33-c,cert-err34-c,cert-err52-cpp,cert-err60-cpp,cert-flp30-c,cert-msc50-cpp,cert-msc51-cpp,cppcoreguidelines-*,-cppcoreguidelines-macro-usage,-cppcoreguidelines-pro-type-reinterpret-cast,-cppcoreguidelines-pro-type-union-access,-cppcoreguidelines-pro-bounds-pointer-arithmetic,-cppcoreguidelines-pro-type-vararg,google-build-using-namespace,google-explicit-constructor,google-global-names-in-headers,google-readability-casting,google-runtime-int,google-runtime-operator,hicpp-*,-hicpp-vararg,misc-*,modernize-*,performance-*,readability-*,-readability-named-parameter,-readability-implicit-bool-conversion"
CheckOptions:
  - key: bugprone-argument-comment.StrictMode
    value: 1
  - key: bugprone-exception-escape.FunctionsThatShouldNotThrow
    value: WinMain,SDL_main
  - key: misc-non-private-member-variables-in-classes.IgnoreClassesWithAllMemberVariablesBeingPublic
    value: 1
FormatStyle: "file"
```

5. 编写.clang-format

```yaml
BasedOnStyle: Chromium
IndentWidth: 4
```
