#!/bin/bash


function readFileSlice() {
  if [[ -z "$1" || -z "$2" ]] ;then
    echo "$0() usage: $0 __FALG_BEGIN __FLAG_END"
    return 1
  fi

  awk -v flagBegin="$1" -v flagEnd="$2" '
    BEGIN {
      inFileSlice=0;
    }
    $0==flagBegin {
      inFileSlice=1;
      next;
    }
    $0==flagEnd {
      inFileSlice=0;
      exit;
    }
    inFileSlice==1 {
      print $0;
    }' "$0"
}


cd ~


# 修改sudo配置免除密码
sudo sed -i '/%sudo\s*ALL=\(ALL:ALL\)\s*ALL/s/ALL$/NOPASSWD: ALL/' /etc/sudoers

# 配置apt镜像源
sudo wget -O /etc/apt/sources.list http://mirrors.cloud.tencent.com/repo/ubuntu20_sources.list

# 配置docker镜像仓库
curl -fsSL https://mirrors.cloud.tencent.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://mirrors.cloud.tencent.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

# 更新软件包
sudo apt update
sudo apt upgrade

# 下载所需软件
sudo apt install docker-ce docker-ce-cli containerd.io daemonize \
  tmux tmux-plugin-manager xsel \
  zsh zsh-syntax-highlighting zsh-autosuggestions autojump \
  neovim \
  silversearcher-ag ripgrep fzf ranger ncdu tig unzip neofetch sl cmatrix \
  clang-12 clangd-12 clang-format-12 clang-tidy-12 cmake \
  golang \
  npm \
  pip

mkdir -p ~/.local/bin
curl -Lo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > ~/.local/bin/win32yank.exe
chmod +x ~/.local/bin/win32yank.exe

wget -O /tmp/lsd.deb https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd-musl_0.20.1_amd64.deb
sudo dpkg -i /tmp/lsd.deb

# 配置tmux
readFileSlice __TMUX_CONF_BEGIN __TMUX_CONF_END >~/.tmux.conf

# 配置zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
readFileSlice __ZSHRC_BEGIN __ZSHRC_END >~/.zshrc

# 配置vim
git clone --depth=1 https://gitee.com/mrbeardad/SpaceVim ~/.SpaceVim
ln -sv ~/.SpaceVim/mode ~/.SpaceVim.d
mkdir ~/.config/
ln -sv ~/.SpaceVim ~/.config/nvim

# 配置git与ssh
if [[ "$USER" == beardad ]] ;then
  cat >~/.gitconfig <<END 
[user]
  email = mrbeardad@qq.com
  name = Heache Bear
[core]
  editor = nvim
[merge]
  tool = vimdiff
[mergetool "vimdiff"]
  path = nvim
END

  mkdir ~/.ssh
  cat >~/.ssh/config <<END
Host github.com
    HostName github.com
    Port 22
    User git
    IdentitiesOnly yes
    IdentityFile ~/.ssh/id_rsa_github

Host gitee.com
    HostName gitee.com
    Port 22
    User git
    IdentitiesOnly yes
    IdentityFile ~/.ssh/id_ecdsa_gitee
END

fi

# 配置htop
mkdir -p ~/.config/htop
readFileSlice __HTOPRC_BEGIN __HTOPRC_END >~/.config/htop/htoprc

# cpp
# echo -e 'BasedOnStyle: Chromium\nIndentWidth: 4' >~/.clang-format

# go
go env -w GOPATH="$HOME"/.local/go/
go env -w GOBIN="$HOME"/.local/bin/
go env -w GOPROXY=https://mirrors.tencent.com/go/

# python
pip config set global.index-url https://mirrors.tencent.com/pypi/simple

# nodejs
npm config set registry http://mirrors.tencent.com/npm/
sudo npm install -g eslint


exit 0


### END ###


__TMUX_CONF_BEGIN
##################################################################################################
# 全局选项
##################################################################################################
set -g set-titles off                   # 不更改terminal title
set -g default-terminal "xterm-256color" # 设置$TERM环境变量
set -g xterm-keys on                    # 支持xterm按键序列
set-option -g mouse on                  # 开启鼠标支持
setw -g mode-keys vi                    # 支持vi模式
set-option -s set-clipboard on          # 开启系统剪切板支持
setw -g escape-time 50                  # '<esc>'序列的延迟时间
set -g base-index 1                     # 设置窗口的起始下标为1
set -g pane-base-index 1                # 设置面板的起始下标为1
set -g visual-activity on               # 非当前窗口有内容更新时提醒用户
setw -g allow-rename off                # 禁止运行的程序更名window
setw -g automatic-rename off            # 禁止自动更名window
set-option -g status off                # 不显示status line
set-option -sa terminal-overrides ",xterm-256color:Tc"
# set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
set -as terminal-overrides '*:Smulx=\E[4::%p1%dm,*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'


##################################################################################################
# 状态栏配置
##################################################################################################
set -g status-interval 1                        # 状态栏刷新时间
set -g status-justify left                      # 状态栏列表左对齐
set -g message-style "bg=#202529, fg=#91A8BA"   # 指定消息通知的前景、后景色
set -g status-left "#[fg=cyan]  #S \ue0b2"     # 状态栏左侧内容
set -g status-right '#[fg=cyan]Continuum status: #{continuum_status}' # 状态栏右侧内容
set -g status-left-length 300                   # 状态栏左边长度300
set -g status-right-length 500                  # 状态栏右边长度500
set -wg window-status-format " #I #W "          # 状态栏窗口名称格式
set -wg window-status-current-format " #I:#W#F #[fg=green]#[bg=black]\ue0b0" # 状态栏当前窗口名称格式(#I：序号，#w：窗口名称，#F：间隔符)
set -wg window-status-separator ""              # 状态栏窗口名称之间的间隔
set -wg window-status-current-style "fg=white, bg=green" # 状态栏当前窗口名称的样式
set -wg window-status-last-style "fg=blue"      # 状态栏最后一个窗口名称的样式

##################################################################################################
# 插件
##################################################################################################
# 保存会话插件
set -g @plugin 'tmux-plugins/tmux-resurrect'

##################################################################################################
# 快捷键
##################################################################################################
# 更改快捷键前缀
unbind C-Z
unbind C-B
set -g prefix M-w

# Window跳转
unbind 'b'
bind b previous-window

# Pane跳转
unbind-key M-Left
unbind-key M-Right
unbind-key M-Down
unbind-key M-Up
bind Up     selectp -U
bind Down   selectp -D
bind Left   selectp -L
bind Right  selectp -R

# Pane分割
unbind '%'
unbind '"'
bind s splitw -v -c '#{pane_current_path}'
bind v splitw -h -c '#{pane_current_path}'

# Pane大小调整
unbind-key C-Right
unbind-key C-Left
unbind-key C-Up
unbind-key C-Down
bind  + resizep -U 10
bind  - resizep -D 10
bind  < resizep -L 10
bind  > resizep -R 10

# 剪切板支持
bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xsel -i -p && xsel -o -p | xsel -i -b"
bind-key p run "xsel -o | tmux load-buffer - ; tmux paste-buffer"

# 快速启动
bind h new-window  htop
bind g new-window  tig
bind r new-window  -c "#{pane_current_path}" ranger
bind f new-window   -c "#{pane_current_path}" 'sed -n "/export FZF_DEFAULT_COMMAND=/,/fi$/p" ~/.zshrc > /tmp/fzf-ranger && bash /tmp/fzf-ranger && : > /tmp/fzf-ranger'
bind m new-window  "cmatrix"

# 其他按键
## 切换statusline
unbind 't'
bind t set-option status

## 重载配置
unbind 'R'
bind R source-file ~/.tmux.conf \; display-message "Config reloaded.."

## 鼠标滚轮模拟
# Emulate scrolling by sending up and down keys if these commands are running in the pane
tmux_commands_with_legacy_scroll="nano less more man"
bind-key -T root WheelUpPane \
    if-shell -Ft= '#{?mouse_any_flag,1,#{pane_in_mode}}' \
        'send -Mt=' \
        'if-shell -t= "#{?alternate_on,true,false} || echo \"#{tmux_commands_with_legacy_scroll}\" | grep -q \"#{pane_current_command}\"" \
            "send -t= Up Up Up" "copy-mode -et="'
bind-key -T root WheelDownPane \
    if-shell -Ft = '#{?pane_in_mode,1,#{mouse_any_flag}}' \
        'send -Mt=' \
        'if-shell -t= "#{?alternate_on,true,false} || echo \"#{tmux_commands_with_legacy_scroll}\" | grep -q \"#{pane_current_command}\"" \
            "send -t= Down Down Down" "send -Mt="'

run '/usr/share/tmux-plugin-manager/tpm'
__TMUX_CONF_END

__ZSHRC_BEGIN
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/ubuntu/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git cp history extract autojump tmux vi-mode docker golang)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias l='lsd -lah --group-dirs first'
alias l.='lsd -lhd --group-dirs first .*'
alias ll='lsd -lhd --group-dirs first [^.]*'
alias cp='cp -i'
alias mv='mv -i'
alias jobs='jobs -l'
alias df='df -hT'
alias psa='ps axo stat,euid,ruid,tty,sess,tpgid,pgrp,ppid,pid,pcpu,pmem,comm'
alias pstree='pstree -Uup'
alias free='free -wh'
alias vmstat='vmstat -w'
alias ip='ip -c'
alias dif='diff -Naur --color'
alias ra='ranger'
alias expactf='expac --timefmt="%Y-%m-%d %T" "%l\t%n" | sort'
alias apt='sudo apt'
alias stl='sudo systemctl'
alias dk='sudo docker'
alias dki='sudo docker image'
alias dkc='sudo docker container'
alias vi='DARKBG=1 nvim'
alias vim='DARKBG=1 vim'

alias gmv='git mv'
alias grms='git rm --cached'
alias grst='git restore --staged'
alias gdtre='git diff-tree'
alias gdi='git diff-index'
alias gdt='git difftool --tool=vimdiff'
alias gdts='git difftool --staged --tool=vimdiff'
alias gmt='git mergetool --tool=vimdiff'
alias gt='git tag'
alias gbav='git branch -a -vv'
alias gct='git checkout --track'
alias glr='git ls-remote'
alias gpt='git push --tags'
alias gfp='git format-patch'
alias gmc='git merge --continue'

function f() {
    if [[ -n "$1" ]] ;then
        cd $1
    fi
    export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
    FZF_FILESS=$(fzf)
    if [[ -n "$FZF_FILESS" ]] ;then
        cd ${FZF_FILESS%/*}
    fi
    if [[ -n "$1" ]] ;then
        cd -
    fi
}

function man() {
    LESS_TERMCAP_md=$'\e[01;34m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;46;30m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
zstyle ':bracketed-paste-magic' active-widgets '.self-*'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#a8a8a8"

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[yellow]%}<%{$fg[green]%}<%{$fg[cyan]%}<%{$fg[blue]%}<%{$reset_color%}"
bindkey -M vicmd '^a' beginning-of-line
bindkey -M vicmd '^e' end-of-line
bindkey -M vicmd "^[[1;5C" forward-word
bindkey -M vicmd "^[[1;5D" backward-word
#bindkey "^[[1;5C" forward-word
#bindkey "^[[1;5D" backward-word
bindkey '^U' backward-kill-line
bindkey '^K' kill-line
bindkey '^Y' yank
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
__ZSHRC_END

__HTOPRC_BEGIN
# Beware! This file is rewritten by htop when settings are changed in the interface.
# The parser is also very primitive, and not human-friendly.
fields=2 45 48 6 5 7 4 0 3 109 110 46 47 20 49 1
sort_key=46
sort_direction=1
tree_sort_key=47
tree_sort_direction=1
hide_kernel_threads=1
hide_userland_threads=1
shadow_other_users=0
show_thread_names=0
show_program_path=0
highlight_base_name=0
highlight_megabytes=1
highlight_threads=1
highlight_changes=0
highlight_changes_delay_secs=5
find_comm_in_cmdline=1
strip_exe_from_cmdline=1
show_merged_command=0
tree_view=1
tree_view_always_by_pid=0
header_margin=1
detailed_cpu_time=0
cpu_count_from_one=1
show_cpu_usage=1
show_cpu_frequency=0
show_cpu_temperature=0
degree_fahrenheit=0
update_process_names=0
account_guest_in_cpu_meter=0
color_scheme=0
enable_mouse=1
delay=15
left_meters=LeftCPUs Memory Swap
left_meter_modes=1 1 1
right_meters=RightCPUs Tasks LoadAverage Uptime
right_meter_modes=1 2 2 2
hide_function_bar=0
__HTOPRC_END
