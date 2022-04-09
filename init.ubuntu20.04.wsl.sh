#!/bin/bash

get_config() {
    if [[ $# -lt 1 ]]; then
        echo -e "\e[31mget_config()\e[m: usage: get_config CONFIG_BEGIN" >&2
        return 1
    fi
    sed -n "/^# $1$/,/^$/{s/^# //;p}" "$0" | sed -n '2,$p'
}

if ! lsb_release -a | grep -qi 'ubuntu 20.04'; then
    echo -e "\e[31mError\e[m: this script requires ubuntu 20.04"
    exit 1
fi

cd ~ || exit 1

# 修改sudo配置免除密码
read -n 1 -p "do you want to execute sudo without password? (Y/n): " SUDO_WITHOUT_PASSWD
[[ "${SUDO_WITHOUT_PASSWD,}" == "y" ]] &&
sudo sed -i '/^%sudo\s*ALL=\(ALL:ALL\)\s*ALL/s/ALL$/NOPASSWD: ALL/' /etc/sudoers

# 配置apt镜像源
read -n 1 -p "do you want to use the mirrors on tencent cloud? (Y/n): " USE_TENCENT_CLOUD_REPO
[[ "${USE_TENCENT_CLOUD_REPO,}" == "y" ]] &&
sudo wget -O /etc/apt/sources.list http://mirrors.cloud.tencent.com/repo/ubuntu20_sources.list

# 配置docker镜像仓库
[[ "${USE_TENCENT_CLOUD_REPO,}" == "y" ]] &&
curl -fsSL https://mirrors.cloud.tencent.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://mirrors.cloud.tencent.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

# 配置go仓库
go env -w GOPATH="$HOME"/.local/go/ GOBIN="$HOME"/.local/bin/ GOSUMDB=sum.golang.google.cn
[[ "$USE_TENCENT_CLOUD_REPO" == y ]] && go env -w GOPROXY=https://mirrors.tencent.com/go/,direct

# 配置pip仓库
[[ "$USE_TENCENT_CLOUD_REPO" == y ]] && pip config set global.index-url https://mirrors.tencent.com/pypi/simple

# 配置npm仓库
[[ "$USE_TENCENT_CLOUD_REPO" == y ]] && npm config set registry http://mirrors.tencent.com/npm/

# 更新软件包
sudo apt update
sudo apt -y upgrade

mkdir -p ~/.local/bin/
# 下载所需软件
sudo apt -y install neofetch sl cmatrix ncdu cloc gnupg unzip nmap \
docker-ce docker-ce-cli containerd.io \
tmux tmux-plugin-manager \
zsh zsh-syntax-highlighting zsh-autosuggestions autojump \
ranger fzf fd-find \
tig \
neovim silversearcher-ag ripgrep universal-ctags php \
cmake doxygen google-perftools libboost-all-dev libgtest-dev libsource-highlight-dev \
golang \
npm \
python3-pip python-is-python3

# clang-14
read -n 1 -p "do you want to install clang-14 from llvm-repository instead of default clang-10? (Y/n)" INSTLL_CLANG_14
if [[ "${INSTLL_CLANG_14,}" == "y" ]]; then
    bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
    sudo apt -y install clang-format-14 clang-tidy-14
    (
        cd /bin || exit
        sudo ln -sf clang-14 clang
        sudo ln -sf clang++-14 clang++
        sudo ln -sf clangd-14 clangd
        sudo ln -sf clang-format-14 clang-format
        sudo ln -sf clang-tidy-14 clang-tidy
        sudo ln -sf lldb-14 lldb
        sudo ln -sf lldb-argdumper-14 lldb-argdumper
        sudo ln -sf lldb-instr-14 lldb-instr
        sudo ln -sf lldb-server-14 lldb-server
        sudo ln -sf lldb-vscode-14 lldb-vscode
    )
else
    sudo apt -y install clang lldb lld clangd clang-format clang-tidy
fi

# win32yank.exe
curl -Lo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip &&
unzip -p /tmp/win32yank.zip win32yank.exe > ./win32yank.exe &&
chmod +x win32yank.exe &&
sudo cp -v win32yank.exe /bin/

# lsd
wget -O /tmp/lsd.deb https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd-musl_0.20.1_amd64.deb &&
sudo dpkg -i /tmp/lsd.deb

# SeeCheatSheets
git clone https://github.com/mrbeardad/SeeCheatSheets ~/.cheat
mkdir ~/.cheat/build
(
    cd ~/.cheat/build || exit 1
    cmake -D CMAKE_BUILD_TYPE=Release ..
    cmake --build . -t see
    cmake --install .
)

mkdir ~/.config/
# 配置tmux
[[ -e ~/.tmux.conf ]] && mv ~/.tmux.conf{,.backup}
get_config __TMUX_CONF >~/.tmux.conf

# 配置zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
get_config __ZSHRC >~/.zshrc
cat >~/.config/proxy <<END
#!/bin/bash
sed -n '/^nameserver/{s/nameserver //;s/$/:7890/;p}' /etc/resolv.conf
END
chmod +x ~/.config/proxy

# 配置htop
mkdir -p ~/.config/htop/
[[ -e ~/.config/htop/htoprc ]] && mv ~/.config/htop/htoprc{,.backup}
get_config __HTOPRC >~/.config/htop/htoprc

# 配置ranger
mkdir -p ~/.config/ranger/
[[ -e ~/.config/ranger/commands.py ]] && mv ~/.config/ranger/commands.py{,.backup}
get_config __RANGER >~/.config/ranger/commands.py
[[ -e ~/.config/ranger/rc.conf ]] && mv ~/.config/ranger/rc.conf{,.backup}
cat >~/.config/ranger/rc.conf <<EOF
map <C-f> fzf_select
set show_hidden true
EOF

# 配置tig
[[ -e ~/.tigrc ]] && mv ~/.tigrc{,.backup}
get_config __TIGRC >~/.tigrc

# 配置vim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt -y install neovim
git clone --depth=1 https://gitee.com/mrbeardad/SpaceVim ~/.SpaceVim
ln -sv ~/.SpaceVim/mode/ ~/.SpaceVim.d/
[[ -e ~/.config/nvim ]] && mv ~/.config/nvim{,-bcakup}
ln -sv ~/.SpaceVim/ ~/.config/nvim/

# 配置git与ssh
if [[ "$USER" == beardad ]] ;then
    get_config __GITCONFIG >~/.gitconfig
    mkdir ~/.ssh/
    get_config __SSH_CONFIG >~/.ssh/config
fi

# cpp
cat >~/.clang-format <<EOF
BasedOnStyle: Chromium
IndentWidth: 4
EOF

# __TMUX_CONF
# # 全局选项
# set -g set-titles off                   # 不更改terminal title
# set -g default-terminal "xterm-256color" # 设置$TERM环境变量
# set -g xterm-keys on                    # 支持xterm按键序列
# set-option -g mouse on                  # 开启鼠标支持
# setw -g mode-keys vi                    # 支持vi模式
# set-option -s set-clipboard on          # 开启系统剪切板支持
# setw -g escape-time 50                  # '<esc>'序列的延迟时间
# set -g base-index 1                     # 设置窗口的起始下标为1
# set -g pane-base-index 1                # 设置面板的起始下标为1
# set -g visual-activity on               # 非当前窗口有内容更新时提醒用户
# setw -g allow-rename off                # 禁止运行的程序更名window
# setw -g automatic-rename off            # 禁止自动更名window
# set-option -g status off                # 不显示status line
# set-option -sa terminal-overrides ",xterm-256color:Tc"
# set -as terminal-overrides '*:Smulx=\E[4::%p1%dm,*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
#
#
# # 更改快捷键前缀
# unbind C-Z
# unbind C-B
# set -g prefix M-w
#
# # 重载配置
# unbind 'R'
# bind R source-file ~/.tmux.conf \; display-message "Config reloaded.."
#
# # Window跳转
# unbind 'b'
# bind b previous-window
#
# # Pane跳转
# unbind-key M-Left
# unbind-key M-Right
# unbind-key M-Down
# unbind-key M-Up
# bind Up     selectp -U
# bind Down   selectp -D
# bind Left   selectp -L
# bind Right  selectp -R
#
# # Pane分割
# unbind '%'
# unbind '"'
# bind s splitw -v -c '#{pane_current_path}'
# bind v splitw -h -c '#{pane_current_path}'
#
# # Pane大小调整
# unbind-key C-Right
# unbind-key C-Left
# unbind-key C-Up
# unbind-key C-Down
# bind  + resizep -U 10
# bind  - resizep -D 10
# bind  < resizep -L 10
# bind  > resizep -R 10
#
# # 剪切板支持
# bind p run-shell -b "win32yank.exe -o --lf | tmux load-buffer - ; tmux paste-buffer"
#
# # 快速启动
# bind h new-window htop
# bind g new-window -c "#{pane_current_path}" tig --all
# bind r new-window -c "#{pane_current_path}" ranger
# bind m new-window "cmatrix"
# bind t new-window "sl"
#
# # 鼠标滚轮模拟
# tmux_commands_with_legacy_scroll="nano less more man"
# bind-key -T root WheelUpPane \
#     if-shell -Ft= '#{?mouse_any_flag,1,#{pane_in_mode}}' \
#         'send -Mt=' \
#         'if-shell -t= "#{?alternate_on,true,false} || echo \"#{tmux_commands_with_legacy_scroll}\" | grep -q \"#{pane_current_command}\"" \
#             "send -t= Up Up Up" "copy-mode -et="'
# bind-key -T root WheelDownPane \
#     if-shell -Ft = '#{?pane_in_mode,1,#{mouse_any_flag}}' \
#         'send -Mt=' \
#         'if-shell -t= "#{?alternate_on,true,false} || echo \"#{tmux_commands_with_legacy_scroll}\" | grep -q \"#{pane_current_command}\"" \
#             "send -t= Down Down Down" "send -Mt="'
#
# # 插件
# run '/usr/share/tmux-plugin-manager/tpm'        # 插件管理器
# set -g @plugin 'tmux-plugins/tmux-resurrect'    # 会话保存与恢复插件
#

# __ZSHRC
# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
#
# # If you come from bash you might have to change your $PATH.
# export PATH=$HOME/.local/bin:$PATH
#
# # Path to your oh-my-zsh installation.
# export ZSH="/home/beardad/.oh-my-zsh"
#
# # Set name of the theme to load --- if set to "random", it will
# # load a random theme each time oh-my-zsh is loaded, in which case,
# # to know which specific one was loaded, run: echo $RANDOM_THEME
# # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"
#
# # Set list of themes to pick from when loading at random
# # Setting this variable when ZSH_THEME=random will cause zsh to load
# # a theme from this variable instead of looking in $ZSH/themes/
# # If set to an empty array, this variable will have no effect.
# # ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
#
# # Uncomment the following line to use case-sensitive completion.
# # CASE_SENSITIVE="true"
#
# # Uncomment the following line to use hyphen-insensitive completion.
# # Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
#
# # Uncomment the following line to disable bi-weekly auto-update checks.
# # DISABLE_AUTO_UPDATE="true"
#
# # Uncomment the following line to automatically update without prompting.
# # DISABLE_UPDATE_PROMPT="true"
#
# # Uncomment the following line to change how often to auto-update (in days).
# # export UPDATE_ZSH_DAYS=13
#
# # Uncomment the following line if pasting URLs and other text is messed up.
# # DISABLE_MAGIC_FUNCTIONS="true"
#
# # Uncomment the following line to disable colors in ls.
# # DISABLE_LS_COLORS="true"
#
# # Uncomment the following line to disable auto-setting terminal title.
# # DISABLE_AUTO_TITLE="true"
#
# # Uncomment the following line to enable command auto-correction.
# # ENABLE_CORRECTION="true"
#
# # Uncomment the following line to display red dots whilst waiting for completion.
# # You can also set it to another string to have that shown instead of the default red dots.
# # e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# # Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"
#
# # Uncomment the following line if you want to disable marking untracked files
# # under VCS as dirty. This makes repository status check for large repositories
# # much, much faster.
# # DISABLE_UNTRACKED_FILES_DIRTY="true"
#
# # Uncomment the following line if you want to change the command execution time
# # stamp shown in the history command output.
# # You can set one of the optional three formats:
# # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# # or set a custom format using the strftime function format specifications,
# # see 'man strftime' for details.
# HIST_STAMPS="yyyy-mm-dd"
#
# # Would you like to use another custom folder than $ZSH/custom?
# # ZSH_CUSTOM=/path/to/new-custom-folder
#
# # Which plugins would you like to load?
# # Standard plugins can be found in $ZSH/plugins/
# # Custom plugins may be added to $ZSH_CUSTOM/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# # Add wisely, as too many plugins slow down shell startup.
# plugins=(
#     aliases
#     autojump
#     colored-man-pages
#     common-aliases
#     docker
#     extract
#     git
#     gitignore
#     golang
#     history
#     nmap
#     shell-proxy
#     sudo
#     tmux
#     vi-mode
# )
#
# source $ZSH/oh-my-zsh.sh
#
# # User configuration
#
# # export MANPATH="/usr/local/man:$MANPATH"
#
# # You may need to manually set your language environment
# # export LANG=en_US.UTF-8
#
# # Preferred editor for local and remote sessions
# export EDITOR='nvim'
# # if [[ -n $SSH_CONNECTION ]]; then
# #   export EDITOR='vim'
# # else
# #   export EDITOR='mvim'
# # fi
#
# # Compilation flags
# # export ARCHFLAGS="-arch x86_64"
#
# # Set personal aliases, overriding those provided by oh-my-zsh libs,
# # plugins, and themes. Aliases can be placed here, though oh-my-zsh
# # users are encouraged to define aliases within the ZSH_CUSTOM folder.
# # For a full list of active aliases, run `alias`.
# #
# # Example aliases
# # alias zshconfig="mate ~/.zshrc"
# # alias ohmyzsh="mate ~/.oh-my-zsh"
#
# alias l='lsd -lah --group-dirs first'
# alias l.='lsd -lhd --group-dirs first .*'
# alias ll='lsd -lh --group-dirs first'
# alias jobs='jobs -l'
# alias df='df -hT'
# alias free='free -wh'
# alias ip='ip -c'
# alias dif='diff -Naur --color'
# alias apt='sudo apt'
# alias stl='sudo systemctl'
# alias dk='sudo docker'
# alias dki='sudo docker image'
# alias dkc='sudo docker container'
# alias vi='nvim'
#
# alias gmv='git mv'
# alias grms='git rm --cached'
# alias gdi='git diff-index --name-status'
# alias gdt='git difftool --tool=vimdiff'
# alias gdts='git difftool --staged --tool=vimdiff'
# alias gmt='git mergetool --tool=vimdiff'
# alias gmc='git merge --continue'
# alias gt='git tag'
# alias gbv='git branch -a -vv'
# alias gbsup='git branch --set-upstream-to'
# alias gco='git checkout --recurse-submodules'
# alias glr='git pull --rebase'
# alias gsa='git submodule add'
#
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# zstyle ':bracketed-paste-magic' active-widgets '.self-*'
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#606060"
#
# MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[yellow]%}<%{$fg[green]%}<%{$fg[cyan]%}<%{$fg[blue]%}<%{$reset_color%}"
# bindkey -M vicmd '^a' beginning-of-line
# bindkey -M vicmd '^e' end-of-line
# bindkey -M vicmd "^[[1;5C" forward-word
# bindkey -M vicmd "^[[1;5D" backward-word
# #bindkey "^[[1;5C" forward-word
# #bindkey "^[[1;5D" backward-word
# bindkey '^U' backward-kill-line
# bindkey '^K' kill-line
# bindkey '^Y' yank
# bindkey '^[OA' up-line-or-beginning-search
# bindkey '^[OB' down-line-or-beginning-search
#
# zstyle ':completion:*:*:docker:*' option-stacking yes
# zstyle ':completion:*:*:docker-*:*' option-stacking yes
#
# bindkey -M emacs '^S' sudo-command-line
# bindkey -M vicmd '^S' sudo-command-line
# bindkey -M viins '^S' sudo-command-line
#
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# __HTOPRC
# # Beware! This file is rewritten by htop when settings are changed in the interface.
# # The parser is also very primitive, and not human-friendly.
# fields=2 45 48 6 5 7 4 0 3 109 110 46 47 20 49 1
# sort_key=46
# sort_direction=1
# tree_sort_key=47
# tree_sort_direction=1
# hide_kernel_threads=1
# hide_userland_threads=1
# shadow_other_users=0
# show_thread_names=0
# show_program_path=0
# highlight_base_name=0
# highlight_megabytes=1
# highlight_threads=1
# highlight_changes=0
# highlight_changes_delay_secs=5
# find_comm_in_cmdline=1
# strip_exe_from_cmdline=1
# show_merged_command=0
# tree_view=1
# tree_view_always_by_pid=0
# header_margin=1
# detailed_cpu_time=0
# cpu_count_from_one=1
# show_cpu_usage=1
# show_cpu_frequency=0
# show_cpu_temperature=0
# degree_fahrenheit=0
# update_process_names=0
# account_guest_in_cpu_meter=0
# color_scheme=0
# enable_mouse=1
# delay=15
# left_meters=LeftCPUs Memory Swap
# left_meter_modes=1 1 1
# right_meters=RightCPUs Tasks LoadAverage Uptime
# right_meter_modes=1 2 2 2
# hide_function_bar=0

# __RANGER
# #!/usr/bin/env python
# # -*- coding: utf-8 -*-
#
# from ranger.api.commands import Command
#
# class fzf_select(Command):
#     """
#     :fzf_select
#     Find a file using fzf.
#     With a prefix argument to select only directories.
#
#     See: https://github.com/junegunn/fzf
#     """
#
#     def execute(self):
#         import subprocess
#         import os
#
#         hidden = ('--hidden' if self.fm.settings.show_hidden else '')
#         exclude = "--no-ignore-vcs --exclude '.git' --exclude '*.py[co]' --exclude '__pycache__'"
#         only_directories = ('--type directory' if self.quantifier else '')
#         fzf_default_command = '{} --follow {} {} {} --color=always'.format(
#             'fdfind', hidden, exclude, only_directories
#         )
#
#         env = os.environ.copy()
#         env['FZF_DEFAULT_COMMAND'] = fzf_default_command
#         env['FZF_DEFAULT_OPTS'] = '--layout=reverse --ansi --preview="{}"'.format('''
#             (
#                 batcat --color=always {} ||
#                 bat --color=always {} ||
#                 cat {} ||
#                 tree -ahpCL 3 -I '.git' -I '*.py[co]' -I '__pycache__' {}
#             ) 2>/dev/null | head -n 100
#         ''')
#
#         fzf = self.fm.execute_command('fzf --no-multi', env=env,
#                                       universal_newlines=True, stdout=subprocess.PIPE)
#         stdout, _ = fzf.communicate()
#         if fzf.returncode == 0:
#             selected = os.path.abspath(stdout.strip())
#             if os.path.isdir(selected):
#                 self.fm.cd(selected)
#             else:
#                 self.fm.select_file(selected)
#

# __TIGRC
# set line-graphics = utf-8
# set main-view = date:default author:full id:yes,color \
#                 line-number:no,interval=1 \
#                 commit-title:graph=v2,refs=yes,overflow=no

# __GITCONFIG
# [user]
#   email = mrbeardad@qq.com
#   name = Heache Bear
# [core]
#   editor = nvim
# [merge]
#   tool = vimdiff
# [mergetool "vimdiff"]
#   path = nvim

# __SSH_CONFIG
# Host github.com
#     HostName github.com
#     Port 22
#     User git
#     IdentitiesOnly yes
#     IdentityFile ~/.ssh/github.key
#
# Host gitee.com
#     HostName gitee.com
#     Port 22
#     User git
#     IdentitiesOnly yes
#     IdentityFile ~/.ssh/gitee.key
