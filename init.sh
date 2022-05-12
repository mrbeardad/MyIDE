#!/bin/env bash

set -eo pipefail

CONFIG_FILE=${CONFIG_FILE:-"$0"}
WIN_HOME=${WIN_HOME:-"/winhome"}
OPTION_UPDATE_CONFIG=
OPTION_AUTO_YES=
PROMPT_INFORMATION=

sudo() {
  if [[ -s "$DEBUG" ]]; then
    echo "$@"
  else
    sudo "$@"
  fi
}

usage() {
  echo "Usage: init.sh [-h|-u|-y]"
  echo ""
  echo "Options:"
  echo "  -h    Print this help message"
  echo "  -u    Update configuration segements in this script file"
  echo "  -y    Automatically answer yes to all questions"
}

parse_arguments() {
  declare option
  while getopts "huy" option; do
    case "$option" in
    "h")
      usage
      exit 0
      ;;
    "u")
      OPTION_UPDATE_CONFIG=1
      ;;
    "y")
      OPTION_AUTO_YES=1
      ;;
    "?")
      usage
      exit 1
      ;;
    esac
  done
}

get_config() {
  if [[ $# -ne 1 ]]; then
    echo -e "\e[31mget_config()\e[m: usage: get_config CONFIG_LABEL" >&2
    return 1
  fi

  sed -n "/^#\s*$1$/,/^#\s*$1_END$/p" "$CONFIG_FILE" | sed -e'1d' -e'$d' -e's/^# \?//'
}

set_config() {
  if [[ $# -ne 2 ]]; then
    echo -e "\e[31mset_config()\e[m: usage: set_config CONFIG_LABEL /path/to/config_file" >&2
    return 1
  fi

  if [[ "$(get_config "$1")" == "$(<"$2")" ]]; then
    return
  fi

  echo "update configuration segement $1"

  # HACK: Redirect operation execute before simple command, so bash will truncate file before read it
  CONTENT=$(sed "/^#\s*$1$/,/^#\s*$1_END$/c# $1\n# $1_END" "$CONFIG_FILE" |
    sed "/^#\s*$1$/r$2" |
    sed "/^#\s*$1$/,/^#\s*$1_END$/s/^/# /" |
    sed -e"/^# # $1$/s/^# //" -e"/^# # $1_END$/s/^# //")
  echo "$CONTENT" >"$CONFIG_FILE"
}

ask_user() {
  if [[ $# -ne 1 ]]; then
    echo -e "\e[31mask_user()\e[m: usage: ask_user 'prompt message'" >&2
    return 1
  fi

  if [[ "$OPTION_AUTO_YES" = 1 ]]; then
    return 0
  fi

  declare USER_ANSWER
  read -rn 1 -p "$1 (Y/n): " USER_ANSWER

  if [[ "${USER_ANSWER,}" == y ]]; then
    return 0
  else
    return 1
  fi
}

sudo_without_passwd() {
  ask_user "Do you want to execute 'sudo' without password?" || return
  sudo sed -i '/^%sudo\s*ALL=\(ALL:ALL\)\s*ALL/s/ALL$/NOPASSWD: ALL/' /etc/sudoers
}

change_apt_mirror_source() {
  sudo apt -y install git curl gpg
  ask_user "Do you want to change apt mirror source to tencent cloud?" || return
  sudo curl -Lo /etc/apt/sources.list http://mirrors.cloud.tencent.com/repo/ubuntu20_sources.list
  sudo apt update
}

upgrade_to_ubuntu22() {
  ask_user "Do you want yo upgrade to ubuntu22.04 STL?" || return
  sudo apt -y upgrade
  sudo do-release-upgrade -d
}

prerequisites() {
  sudo apt -y install golang cargo python3-pip python-is-python3
  curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  sudo apt -y install nodejs

  ask_user "Do you want to set GOPROXY to tencent cloud mirror?" &&
    go env -w GOPROXY=https://mirrors.tencent.com/go/,direct
  go env -w GOBIN="$HOME"/.local/bin/ GOSUMDB=sum.golang.google.cn

  ask_user "Do you want to config npm registry to tencent cloud mirror?" &&
    npm config set registry http://mirrors.tencent.com/npm/ &&
    npm config set prefix ~/.local -g
  npm config set global-bin-dir ~/.local/bin
  npm install pnpm -g

  ask_user "Do you want to config pip index-url to tencent cloud mirror?" &&
    pip config set global.index-url https://mirrors.tencent.com/pypi/simple

  ask_user "Do you want to config cargo registry to utsc cloud mirror?" &&
    mkdir ~/.cargo && cat >~/.cargo/config <<EOF
[source.crates-io]
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
EOF
}

ssh_and_git_config() {
  # only for myself
  if [[ "$USER" == beardad ]]; then
    get_config __GITCONFIG >~/.gitconfig
    mkdir ~/.ssh/
    get_config __SSH_CONFIG >~/.ssh/config
  fi
}

install_docker() {
  ask_user "Do you want to install docker from tencent cloud mirror" || return
  curl -fsSL https://mirrors.cloud.tencent.com/docker-ce/linux/ubuntu/gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/docker-ce-archive-keyring.gpg
  echo "deb [arch=amd64] https://mirrors.cloud.tencent.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker-ce.list
  sudo apt update
  sudo apt -y install docker-ce docker-ce-cli containerd.io
}

tmux_conf() {
  sudo apt -y install tmux tmux-plugin-manager cmatrix
  [[ -e ~/.tmux.conf ]] && mv ~/.tmux.conf{,.bak}
  get_config __TMUX_CONF >~/.tmux.conf
  PROMPT_INFORMATION="$PROMPT_INFORMATION$(echo -e "\e[32m======>\e[33m tmux:\e[m Don't forget to pressing 'Alt+W I' in tmux to install plugin")"
}

zsh_conf() {
  sudo apt -y install zsh zsh-syntax-highlighting zsh-autosuggestions autojump fzf
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  [[ -e ~/.zshrc ]] && mv ~/.zshrc{,.bak}
  get_config __ZSHRC >~/.zshrc
  cat >~/.config/proxy <<EOF
#!/bin/bash
sed -n '/^nameserver/{s/^nameserver\s*\([0-9.]*\)\s*$/\1:7890/; p}' /etc/resolv.conf
EOF
  chmod +x ~/.config/proxy
  PROMPT_INFORMATION="$PROMPT_INFORMATION$(echo -e "\e[32m======>\e[33m zsh:\e[m You may want to custom your zsh prompt theme in ~/.p10k.zsh")"
}

ranger_conf() {
  sudo apt -y install ranger fzf fd-find
  mkdir -p ~/.config/ranger/
  [[ -e ~/.config/ranger/commands.py ]] && mv ~/.config/ranger/commands.py{,.bak}
  get_config __RANGER >~/.config/ranger/commands.py
  [[ -e ~/.config/ranger/rc.conf ]] && mv ~/.config/ranger/rc.conf{,.bak}
  cat >~/.config/ranger/rc.conf <<EOF
map <C-f> fzf_select
set show_hidden true
EOF
}

htop_conf() {
  sudo apt -y install htop btop
  mkdir -p ~/.config/htop/
  [[ -e ~/.config/htop/htoprc ]] && mv ~/.config/htop/htoprc{,.bak}
  get_config __HTOPRC >~/.config/htop/htoprc
}

tig_conf() {
  sudo apt -y install git tig
  [[ -e ~/.tigrc ]] && mv ~/.tigrc{,.bak}
  get_config __TIGRC >~/.tigrc
}

neovim_conf() {
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt update
  sudo apt -y install neovim

  curl -Lo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
  unzip -p /tmp/win32yank.zip win32yank.exe >~/.local/bin/win32yank.exe
  chmod +x ~/.local/bin/win32yank.exe

  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
  mv ~/.cargo/bin/* ~/.local/bin/

  # get_config __CONFIG_LUA >~/.config/lvim/config.lua
  rm -fr ~/.config/lvim/
  git clone https://github.com/mrbeardad/MyLunarVim ~/.config/lvim
  ~/.config/lvim/bin/nvim --headless \
    -c 'autocmd User PackerComplete quitall' \
    -c 'PackerSync'
  ask_user "Do you want use lvim instead of nvim all the time? Means to copy ~/.config/lvim/bin/nvim to /usr/local/bin" &&
    cp ~/.config/lvim/bin/nvim /usr/local/bin/nvim
}

lang_shell() {
  sudo apt -y install shellcheck
  go install mvdan.cc/sh/v3/cmd/shfmt@latest
}

lang_cpp() {
  sudo apt -y install libc++-dev clang lldb lld clangd clang-tidy clang-format cppcheck \
    cmake doxygen graphviz plantuml google-perftools \
    libboost-all-dev libgtest-dev libsource-highlight-dev
  pip install cmake_format
}

lang_go() {
  go install golang.org/x/tools/gopls@latest
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
  go install github.com/google/pprof@latest
}

lang_py() {
  pip install pylint flake8 yapf
}

lang_web() {
  pnpm install -g eslint htmlhint csslint markdownlint-cli prettier
}

other_cli_tools() {
  sudo apt -y install neofetch cloc ncdu gnupg nmap
  cargo install lsd
  mv ~/.cargo/bin/* ~/.local/bin/
  git clone --recurse-submodules https://github.com/mrbeardad/SeeCheatSheets ~/.cheat
  mkdir ~/.cheat/src/build
  (
    cd ~/.cheat/src/build
    cmake -D CMAKE_BUILD_TYPE=Release ..
    cmake --build . -t see
    cp ./see ~/.local/bin/
  )
}

main() {
  parse_arguments "$@"
  if [[ "$OPTION_UPDATE_CONFIG" == "1" ]]; then
    if [[ -d "$WIN_HOME" ]]; then
      cp -uv "$WIN_HOME"/AppData/Roaming/Code/User/{settings.json,keybindings.json} ./vscode/
      cp -uv "$WIN_HOME"/AppData/Roaming/Code/User/sync/extensions/lastSyncextensions.json ./vscode/
      cp -uv "$WIN_HOME"/AppData/Local/vscode-neovim/init.vim ./vscode/vscode-neovim/init.vim
      cp -uv "$WIN_HOME"/AppData/Local/Packages/Microsoft.WindowsTerminal_*/LocalState/settings.json wt/settings.json
    fi
    set_config __TMUX_CONF ~/.tmux.conf
    set_config __ZSHRC ~/.zshrc
    set_config __RANGER ~/.config/ranger/commands.py
    set_config __HTOPRC ~/.config/htop/htoprc
    set_config __TIGRC ~/.tigrc
    set_config __CONFIG_LUA ~/.config/lvim/config.lua
    set_config __GITCONFIG ~/.gitconfig
    set_config __SSH_CONFIG ~/.ssh/config
  else
    # the default cwd after enter wsl may be windows home
    cd ~
    mkdir -p ~/.local/bin/
    mkdir -p ~/.config/

    sudo_without_passwd
    change_apt_mirror_source
    upgrade_to_ubuntu22
    lpm
    ssh_and_git_config
    install_docker
    tmux_conf
    zsh_conf
    ranger_conf
    htop_conf
    tig_conf
    neovim_conf
    lang_shell
    lang_cpp
    lang_go
    lang_py
    lang_web
    other_cli_tools

    echo "$PROMPT_INFORMATION"
  fi
}

main "$@"

############################## CONFIG_SEGEMENTS ##############################

# __TMUX_CONF
# # 全局选项
# set-option -g set-titles off     # 不更改terminal title
# set-option -g status off         # 不显示status line
# set-option -g base-index 1       # 设置窗口的起始下标为1
# set-option -g pane-base-index 1  # 设置面板的起始下标为1
# set-option -g visual-activity on # 非当前窗口有内容更新时提醒用户
# set-option -g mouse on           # 开启鼠标支持
# set-option -g set-clipboard on   # 开启系统剪切板支持
# set-option -g mode-keys vi       # 支持vi模式
# set-option -g escape-time 50     # '<esc>'序列的延迟时间
# set-option -g focus-events on    # 开启聚焦事件
# set-option -g xterm-keys on      # 支持xterm按键序列
# set-option -g default-terminal "tmux-256color"
# set-option -ga terminal-overrides ",*256color:RGB" # true color support
# set-option -ga terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
# set-option -ga terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours
# set-option -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[1 q' # cursor style
# # set-option -ga terminal-overrides ',*:cnorm=\E[?12h\E[?25h'
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
# # bind b previous-window
# 
# # Pane分割
# bind s splitw -v -c '#{pane_current_path}'
# bind v splitw -h -c '#{pane_current_path}'
# 
# # Pane跳转
# #unbind-key M-Left
# #unbind-key M-Right
# #unbind-key M-Down
# #unbind-key M-Up
# bind h selectp -L
# bind j selectp -D
# bind k selectp -U
# bind l selectp -R
# 
# # Pane大小调整
# #unbind-key C-Right
# #unbind-key C-Left
# #unbind-key C-Up
# #unbind-key C-Down
# bind + resizep -U 10
# bind = resizep -U 10
# bind - resizep -D 10
# bind < resizep -L 10
# bind > resizep -R 10
# 
# # 剪切板支持
# bind-key -T copy-mode-vi v send-keys -X begin-selection
# bind-key -T copy-mode-vi y send-keys -X copy-selection
# bind ] run-shell -b "win32yank.exe -o --lf | tmux load-buffer - ; tmux paste-buffer"
# 
# # 快速启动
# bind t new-window htop
# bind T new-window btop
# bind g new-window -c "#{pane_current_path}" tig --all
# bind r new-window -c "#{pane_current_path}" ranger
# bind m new-window "cmatrix"
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
# EDITOR=nvim
# PATH=$HOME/.local/bin/:$PATH
# __TMUX_CONF_END

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
# export UPDATE_ZSH_DAYS=30
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
# alias vi="$EDITOR"
# 
# alias gmv='git mv'
# alias grms='git rm --cached'
# alias grss='git restore --staged'
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
# alias glra='git pull --rebase --auto-stash'
# alias gsa='git submodule add'
# alias gsd='git submodule deinit'
# alias gsu='git submodule update --init --recursive'
# 
# source /usr/share/doc/fzf/examples/key-bindings.zsh
# source /usr/share/doc/fzf/examples/completion.zsh
# 
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# zstyle ':bracketed-paste-magic' active-widgets '.self-*'
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#606060"
# 
# export VI_MODE_SET_CURSOR=true
# bindkey -M vicmd '^L' clear-screen
# bindkey '^L' forward-word
# bindkey 'jj' vi-cmd-mode
# bindkey 'jk' vi-cmd-mode
# bindkey '^U' backward-kill-line
# bindkey '^K' kill-line
# bindkey '^Y' yank
# bindkey '^P' up-line-or-beginning-search
# bindkey '^N' down-line-or-beginning-search
# 
# zstyle ':completion:*:*:docker:*' option-stacking yes
# zstyle ':completion:*:*:docker-*:*' option-stacking yes
# 
# bindkey -M emacs '^[s' sudo-command-line
# bindkey -M vicmd '^[s' sudo-command-line
# bindkey -M viins '^[s' sudo-command-line
# 
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# 
# __ZSHRC_END

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
# __RANGER_END

# __HTOPRC
# # Beware! This file is rewritten by htop when settings are changed in the interface.
# # The parser is also very primitive, and not human-friendly.
# fields=2 45 48 6 5 7 4 0 3 109 110 46 47 20 49 1
# sort_key=46
# sort_direction=1
# tree_sort_key=0
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
# color_scheme=6
# enable_mouse=1
# delay=15
# left_meters=LeftCPUs Memory Swap
# left_meter_modes=1 1 1
# right_meters=RightCPUs Tasks LoadAverage Uptime
# right_meter_modes=1 2 2 2
# hide_function_bar=0
# __HTOPRC_END

# __TIGRC
# set line-graphics = utf-8
# set main-view = date:default author:full id:yes,color \
#                 line-number:no,interval=1 \
#                 commit-title:graph=v2,refs=yes,overflow=no
#
# bind main c @git checkout %(commit)
# bind main d >git difftool --tool=vimdiff %(commit)
# bind diff d >git difftool --tool=vimdiff %(commit)^! -- %(file)
#
# # Vim-style keybindings for Tig
# bind generic h scroll-left
# bind generic j move-down
# bind generic k move-up
# bind generic l scroll-right
#
# bind generic g  none
# bind generic gg move-first-line
# bind generic gj next
# bind generic gk previous
# bind generic gp parent
# bind generic gP back
# bind generic gn view-next
#
# bind main    G move-last-line
# bind generic G move-last-line
#
# bind generic <C-f> move-page-down
# bind generic <C-b> move-page-up
#
# bind generic v  none
# bind generic vm view-main
# bind generic vd view-diff
# bind generic vl view-log
# bind generic vt view-tree
# bind generic vb view-blob
# bind generic vx view-blame
# bind generic vr view-refs
# bind generic vs view-status
# bind generic vu view-stage
# bind generic vy view-stash
# bind generic vg view-grep
# bind generic vp view-pager
# bind generic vh view-help
#
# bind generic o  none
# bind generic oo :toggle sort-order
# bind generic os :toggle sort-field
# bind generic on :toggle line-number
# bind generic od :toggle date
# bind generic oa :toggle author
# bind generic og :toggle line-graphics
# bind generic of :toggle file-name
# bind generic op :toggle ignore-space
# bind generic oi :toggle id
# bind generic ot :toggle commit-title-overflow
# bind generic oF :toggle file-filter
# bind generic or :toggle commit-title-refs
#
# bind generic @  none
# bind generic @j :/^@@
# bind generic @k :?^@@
# bind generic @- :toggle diff-context -1
# bind generic @+ :toggle diff-context +1
#
# bind status  u  none
# bind stage   u  none
# bind generic uu status-update
# bind generic ur status-revert
# bind generic um status-merge
# bind generic ul stage-update-line
# bind generic up stage-update-part
# bind generic us stage-split-chunk
#
# bind generic c  none
# bind generic cc !git commit
# bind generic ca !?@git commit --amend --no-edit
#
# bind generic K view-help
# bind generic <C-w><C-w> view-next
# __TIGRC_END

# __CONFIG_LUA
# ----------------------------------------
# -- GENERAL
# ----------------------------------------
# vim.opt.backup = true
# vim.opt.backupdir = join_paths(get_cache_dir(), "backup")
# vim.opt.swapfile = true
# vim.opt.directory = join_paths(get_cache_dir(), "swap")
# vim.opt.list = true
# vim.opt.listchars = 'tab:→ ,eol:↵,trail:·,extends:↷,precedes:↶'
# vim.opt.wildignorecase = true
# lvim.colorscheme = "onedarker"
# lvim.log.level = "warn"
# lvim.format_on_save = true
# 
# ----------------------------------------
# -- GUI
# ----------------------------------------
# vim.opt.guicursor = 'n:block-blinkon10,i-ci:ver15-blinkon10,c:hor15-blinkon10,v-sm:block,ve:ver15,r-cr-o:hor10'
# vim.opt.guifont = "NerdCodePro Font:h10"
# vim.g.neovide_cursor_vfx_mode = "ripple"
# vim.g.neovide_cursor_animation_length = 0.01
# 
# ----------------------------------------
# -- KEYMAPPINGS
# ----------------------------------------
# vim.opt.timeoutlen = 350
# lvim.leader = "space"
# 
# ----------------------------------------
# -- 屏幕滚动: neoscroll
# ----------------------------------------
# 
# ----------------------------------------
# -- 光标移动: clever-f, hop, matchit
# ----------------------------------------
# vim.opt.relativenumber = true
# vim.api.nvim_set_keymap('c', '<C-a>', '<C-b>', { noremap = true })
# -- vim.api.nvim_set_keymap('i', '<C-e>', '<End>', { noremap = true })
# -- vim.api.nvim_set_keymap('v', '<C-e>', '$', { noremap = true })
# -- vim.api.nvim_set_keymap('n', '<C-e>', '$', { noremap = true })
# 
# ----------------------------------------
# -- 全文搜索: vim-visual-star-search, vim-cool, telescope, nvim-spectre
# ----------------------------------------
# vim.api.nvim_set_keymap('n', '<BS>', '<CMD>nohl<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-l>', '<CMD>nohl<CR><C-l>', { noremap = true })
# vim.api.nvim_set_keymap('n', 'n', "'Nn'[v:searchforward]", { noremap = true, expr = true })
# vim.api.nvim_set_keymap('n', 'N', "'nN'[v:searchforward]", { noremap = true, expr = true })
# vim.api.nvim_set_keymap('c', '<M-W>', "\\<\\><Left><Left>", { noremap = true })
# vim.api.nvim_set_keymap('c', '<M-r>', "\\v", { noremap = true })
# vim.api.nvim_set_keymap('c', '<M-c>', "\\C", { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-f>', '<CMD>Telescope current_buffer_fuzzy_find<CR>', { noremap = true })
# -- HACK: terminal map: ctrl+shift+f -> alt+f
# vim.api.nvim_set_keymap('n', '<M-f>', '<CMD>Telescope live_grep<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-S-F>', '<CMD>Telescope live_grep<CR>', { noremap = true })
# 
# ----------------------------------------
# -- 标签跳转: vim-bookmarks, telescope-vim-bookmarks
# ----------------------------------------
# -- HACK: terminal map: ctrl+i -> alt+shift+i
# vim.api.nvim_set_keymap('n', '<M-I>', '<C-i>', { noremap = true })
# vim.api.nvim_set_keymap('n', '[h', "<CMD>Gitsigns next_hunk<CR>", { noremap = true })
# vim.api.nvim_set_keymap('n', ']h', "<CMD>Gitsigns prev_hunk<CR>", { noremap = true })
# 
# ----------------------------------------
# -- 插入编辑
# ----------------------------------------
# vim.api.nvim_set_keymap('n', '<', '<<', { noremap = true })
# vim.api.nvim_set_keymap('n', '>', '>>', { noremap = true })
# -- HACK: terminal map: ctrl+shift+j -> alt+shift+j
# vim.api.nvim_set_keymap('i', '<M-J>', '<CMD>m .+1<CR><Cmd>normal ==<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<M-J>', '<CMD>m .+1<CR><Cmd>normal ==<CR>', { noremap = true })
# vim.api.nvim_set_keymap('i', '<C-S-J>', '<CMD>m .+1<CR><Cmd>normal ==<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-S-J>', '<CMD>m .+1<CR><Cmd>normal ==<CR>', { noremap = true })
# -- HACK: terminal map: ctrl+shift+k -> alt+shift+k
# vim.api.nvim_set_keymap('i', '<M-K>', '<CMD>m .-2<CR><Cmd>normal ==<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<M-K>', '<CMD>m .-2<CR><Cmd>normal ==<CR>', { noremap = true })
# vim.api.nvim_set_keymap('i', '<C-S-K>', '<CMD>m .-2<CR><Cmd>normal ==<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-S-K>', '<CMD>m .-2<CR><Cmd>normal ==<CR>', { noremap = true })
# vim.api.nvim_set_keymap('i', '<C-j>', '<End><CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-j>', '<CMD>put =repeat(nr2char(10), v:count1)<CR>', { noremap = true })
# vim.api.nvim_set_keymap('i', '<C-k>', "repeat('<Del>', strchars(getline('.')) - getcurpos()[2] + 1)", { noremap = true, expr = true })
# vim.api.nvim_set_keymap('c', '<C-k>', "repeat('<Del>', strchars(getcmdline()) - getcmdpos() + 1)", { noremap = true, expr = true })
# vim.api.nvim_set_keymap('i', '<C-l>', '<C-Right>', { noremap = true })
# vim.api.nvim_set_keymap('c', '<C-l>', '<C-Right>', { noremap = true })
# vim.api.nvim_set_keymap('i', '<C-z>', '<CMD>undo<CR>', { noremap = true })
# vim.api.nvim_set_keymap('i', '<C-r><C-r>', '<CMD>redo<CR>', { noremap = true })
# 
# ----------------------------------------
# -- 普通模式
# ----------------------------------------
# vim.api.nvim_set_keymap('n', 'S', 'i<CR><Esc>', { noremap = true })
# 
# ----------------------------------------
# -- 复制粘贴
# ----------------------------------------
# vim.opt.clipboard = '' -- lunarvim use system clipboard as default register, reset it
# vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })
# vim.api.nvim_set_keymap('v', '=p', '"0p', { noremap = true })
# vim.api.nvim_set_keymap('n', '=p', '"0p', { noremap = true })
# vim.api.nvim_set_keymap('n', '=P', '"0P', { noremap = true })
# vim.api.nvim_set_keymap('n', '=o', '<CMD>put =@0<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '=O', '<CMD>put! =@0<CR>', { noremap = true })
# vim.api.nvim_set_keymap('v', '<Space>y', '"+y', { noremap = true })
# vim.api.nvim_set_keymap('v', '<Space>p', '"+p', { noremap = true })
# lvim.builtin.which_key.mappings["<Space>"] = { "<CMD>let @+ = @0<CR>", "Copy Register 0 to Clipboard" }
# lvim.builtin.which_key.mappings["y"] = { '"+y', "Yank to Clipboard" }
# lvim.builtin.which_key.mappings["Y"] = { '"+y$', "Yank All Right to Clipboard" }
# lvim.builtin.which_key.mappings["p"] = { '"+p', "Paste Clipboard After Cursor" }
# lvim.builtin.which_key.mappings["P"] = { '"+P', "Paste Clipboard Before Cursor" }
# lvim.builtin.which_key.mappings["o"] = { "<CMD>put =@+<CR>", "Paste Clipboard to Next Line" }
# lvim.builtin.which_key.mappings["O"] = { "<CMD>put! =@+<CR>", "Paste Clipboard to Previous Line" }
# lvim.builtin.which_key.mappings["by"] = { "<CMD>%y +<CR>", "Yank Whole Buffer to Clipboard" }
# lvim.builtin.which_key.mappings["bp"] = { "<CMD>%d<CR>\"+P", "Patse Clipboard to Whole Buffer" }
# 
# ----------------------------------------
# -- 文件操作: telescope
# ----------------------------------------
# lvim.builtin.which_key.mappings["<Tab>"] = { ":try | b# | catch | endtry<CR>", "Switch Buffer" }
# lvim.keys.normal_mode["<C-k>"] = false
# vim.api.nvim_set_keymap('n', '<C-k><C-o>', '<CMD>Telescope projects<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k>o', ":e <C-r>=fnamemodify('.',':p')<CR>", { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k>n', '<CMD>enew<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k>r', '<CMD>Telescope oldfiles<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-p>', '<CMD>Telescope find_files<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-s>', '<CMD>w<CR>', { noremap = true })
# -- HACK: terminal map: ctrl+shift+s -> alt+shift+s
# vim.api.nvim_set_keymap('n', '<M-S>', ":saveas <C-r>=fnamemodify('.',':p')<CR>", { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-S-S>', ":saveas <C-r>=fnamemodify('.',':p')<CR>", { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k>s', '<CMD>wa<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k>x', '<CMD>BufferKill<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k>u', ':try | %bd | catch | endtry<CR>', { noremap = true, silent = true })
# vim.api.nvim_set_keymap('n', '<C-k>w', '<CMD>%bd<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<Tab>', '<CMD>wincmd w<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<S-Tab>', '<CMD>wincmd p<CR>', { noremap = true })
# lvim.builtin.which_key.mappings["q"] = { "<CMD>call SmartClose()<CR>", "Quit Cleverly" }
# 
# ----------------------------------------
# -- 语言服务
# ----------------------------------------
# lvim.builtin.cmp.mapping["<C-j>"] = nil
# lvim.builtin.cmp.mapping["<C-k>"] = nil
# lvim.builtin.cmp.mapping["<C-e>"] = nil
# lvim.builtin.cmp.mapping["<C-d>"] = nil
# lvim.builtin.cmp.mapping["<CR>"] = nil
# lvim.builtin.cmp.confirm_opts.select = true
# local cmp = require("cmp")
# local luasnip = require("luasnip")
# local lccm = require("lvim.core.cmp").methods
# -- HACK: terminal map: ctrl+i -> alt+shift+i
# lvim.builtin.cmp.mapping["<M-I>"] = cmp.mapping.complete()
# lvim.builtin.cmp.mapping["<Tab>"] = cmp.mapping(function(fallback)
#   if luasnip.expandable() then
#     luasnip.expand()
#   elseif lccm.jumpable() then
#     luasnip.jump(1)
#   elseif cmp.visible() then
#     cmp.confirm(lvim.builtin.cmp.confirm_opts)
#   elseif lccm.check_backspace() then
#     fallback()
#   elseif lccm.is_emmet_active() then
#     return vim.fn["cmp#complete"]()
#   else
#     fallback()
#   end
# end, { "i", "s", }
# )
# vim.api.nvim_set_keymap('n', '<M-F>', '<CMD>lua require("lvim.lsp.utils").format()<CR>', { noremap = true })
# vim.api.nvim_set_keymap('i', '<M-F>', '<CMD>lua require("lvim.lsp.utils").format()<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<F2>', "<CMD>lua vim.lsp.buf.rename()<CR>", { noremap = true })
# -- HACK: terminal map: ctrl+. -> alt+.
# vim.api.nvim_set_keymap('n', '<M-.>', '<CMD>lua vim.lsp.buf.code_action()<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-.>', '<CMD>lua vim.lsp.buf.code_action()<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', {})
# vim.api.nvim_set_keymap('i', '<C-_>', '<CMD>normal gcc<CR>', {})
# vim.api.nvim_set_keymap('n', '<C-t>', '<CMD>Telescope lsp_workspace_symbols<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '[e', "<CMD>lua vim.diagnostic.goto_prev()<CR>", { noremap = true })
# vim.api.nvim_set_keymap('n', ']e', "<CMD>lua vim.diagnostic.goto_next()<CR>", { noremap = true })
# 
# ----------------------------------------
# -- 其它按键: vim-translator, Calc, ...
# ----------------------------------------
# vim.api.nvim_set_keymap('n', '<M-z>', "<CMD>let &wrap=!&wrap<CR>", { noremap = true })
# vim.api.nvim_set_keymap('n', '<M-e>', "<CMD>call Open_file_in_explorer()<CR>", { noremap = true })
# -- HACK: terminal map: ctrl+shift+p -> alt+shift+p
# vim.api.nvim_set_keymap('n', '<M-P>', "<CMD>Telescope commands<CR>", { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-S-P>', "<CMD>Telescope commands<CR>", { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k><C-s>', "<CMD>Telescope keymaps<CR>", { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k><C-t>', "<Cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<CR>", { noremap = true })
# lvim.builtin.which_key.mappings[";"] = nil
# lvim.builtin.which_key.mappings["/"] = nil
# lvim.builtin.which_key.mappings["w"] = nil
# lvim.builtin.which_key.mappings["h"] = nil
# lvim.builtin.which_key.mappings["f"] = nil
# lvim.builtin.which_key.mappings["c"] = nil
# lvim.builtin.which_key.mappings["e"] = nil
# lvim.builtin.which_key.mappings["a"] = {
#   name = "Application",
#   t = { "<CMD>TodoTrouble<CR>", "TODO" },
#   e = { "<CMD>NvimTreeToggle<CR>", "Explorer" },
#   c = { "<CMD>Calc<CR>", "Calculator" },
#   u = { "<CMD>UndotreeToggle<CR>", "UndoTree" },
# }
# 
# ----------------------------------------
# -- Telescope
# ----------------------------------------
# -- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
# -- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
# local _, actions = pcall(require, "telescope.actions")
# lvim.builtin.telescope.defaults.mappings = {
#   -- for input mode
#   i = {
#     -- ["<Esc>"] = actions.close,
#     ["<C-b>"] = actions.preview_scrolling_up,
#     ["<C-u>"] = nil
#   },
#   -- for normal mode
#   n = {
#   },
# }
# 
# -- WARN: After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
# ----------------------------------------
# -- User Config for predefined plugins
# ----------------------------------------
# lvim.builtin.alpha.active = true
# lvim.builtin.alpha.mode = "dashboard"
# lvim.builtin.alpha.dashboard.section.buttons.entries[1][1] = "Ctrl+K n"
# lvim.builtin.alpha.dashboard.section.buttons.entries[1][2] = "  New File"
# lvim.builtin.alpha.dashboard.section.buttons.entries[1][3] = "<CMD>ene!<CR>"
# lvim.builtin.alpha.dashboard.section.buttons.entries[2][1] = "Ctrl+P"
# lvim.builtin.alpha.dashboard.section.buttons.entries[2][2] = "  Find File"
# lvim.builtin.alpha.dashboard.section.buttons.entries[2][3] = "<CMD>Telescope find_files<CR>"
# lvim.builtin.alpha.dashboard.section.buttons.entries[3][1] = "Ctrl+K Ctrl+O"
# lvim.builtin.alpha.dashboard.section.buttons.entries[3][2] = "  Recent Projects "
# lvim.builtin.alpha.dashboard.section.buttons.entries[3][3] = "<CMD>Telescope projects<CR>"
# lvim.builtin.alpha.dashboard.section.buttons.entries[4][1] = "Ctrl+K r"
# lvim.builtin.alpha.dashboard.section.buttons.entries[4][2] = "  Recently Used Files"
# lvim.builtin.alpha.dashboard.section.buttons.entries[4][3] = "<CMD>Telescope oldfiles<CR>"
# lvim.builtin.alpha.dashboard.section.buttons.entries[5][1] = "SPC S l"
# lvim.builtin.alpha.dashboard.section.buttons.entries[5][2] = "  Restore Session"
# lvim.builtin.alpha.dashboard.section.buttons.entries[5][3] = "<CMD>lua require('persistence').load({ last = true })<CR>"
# 
# lvim.builtin.notify.active = true
# 
# lvim.builtin.terminal.active = true
# lvim.builtin.terminal.shell = "/bin/bash"
# lvim.builtin.terminal.open_mapping = "<M-`>"
# 
# lvim.builtin.nvimtree.setup.view.side = "left"
# lvim.builtin.nvimtree.show_icons.git = 1
# 
# lvim.builtin.bufferline.options.always_show_bufferline = true
# 
# lvim.builtin.lualine.options.theme = "material"
# lvim.builtin.lualine.options = {
#   globalstatus       = true,
#   section_separators = { left = '', right = ' ' },
# }
# local components = require("lvim.core.lualine.components")
# lvim.builtin.lualine.sections.lualine_a = {
#   { '', type = 'stl' }
# }
# lvim.builtin.lualine.sections.lualine_b = {
#   {
#     function()
#       return "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
#     end,
#     color = { bg = "#454c5a" },
#     separator = { right = '' }
#   },
#   components.branch
# }
# lvim.builtin.lualine.sections.lualine_x = {
#   components.diagnostics,
#   { '', type = 'stl', color = { fg = "#454c5a" } }
# }
# lvim.builtin.lualine.sections.lualine_y = {
#   components.treesitter,
#   components.lsp,
#   components.filetype,
#   { "fileformat", color = { fg = "#bbbbbb" } },
# }
# lvim.builtin.lualine.sections.lualine_z = {
#   { ' %l/%L  %c', type = 'stl' },
#   components.scrollbar
# }
# 
# -- if you don't want all the parsers change this to a table of the ones you want
# lvim.builtin.treesitter.highlight.enabled = true
# lvim.builtin.treesitter.rainbow.enable = true
# lvim.builtin.treesitter.ensure_installed = {
#   "bash",
#   "vim",
#   "lua",
#   "c",
#   "cpp",
#   "cmake",
#   "go",
#   "python",
#   "javascript",
#   "typescript",
#   "tsx",
#   "html",
#   "css",
#   "markdown",
#   "json",
#   "yaml",
# }
# 
# 
# ----------------------------------------
# -- generic LSP settings
# ----------------------------------------
# 
# -- ---@usage disable automatic installation of servers
# -- lvim.lsp.automatic_servers_installation = false
# 
# -- ---WARN: configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
# -- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
# -- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
# -- local opts = {} -- check the lspconfig documentation for a list of all possible options
# -- require("lvim.lsp.manager").setup("pyright", opts)
# 
# -- ---WARN: remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
# -- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
# -- vim.tbl_map(function(server)
# --   return server ~= "emmet_ls"
# -- end, lvim.lsp.automatic_configuration.skipped_servers)
# 
# -- -- you can set a custom on_attach function that will be used for all the language servers
# -- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
# -- lvim.lsp.on_attach_callback = function(client, bufnr)
# --   local function buf_set_option(...)
# --     vim.api.nvim_buf_set_option(bufnr, ...)
# --   end
# --   --Enable completion triggered by <c-x><c-o>
# --   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
# -- end
# 
# -- -- set a formatter, this will override the language server formatting capabilities (if it exists)
# -- local formatters = require "lvim.lsp.null-ls.formatters"
# -- formatters.setup {
# --   { command = "black", filetypes = { "python" } },
# --   { command = "isort", filetypes = { "python" } },
# --   {
# --     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
# --     command = "prettier",
# --     ---@usage arguments to pass to the formatter
# --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
# --     extra_args = { "--print-with", "100" },
# --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
# --     filetypes = { "typescript", "typescriptreact" },
# --   },
# -- }
# 
# -- -- set additional linters
# -- local linters = require "lvim.lsp.null-ls.linters"
# -- linters.setup {
# --   { command = "flake8", filetypes = { "python" } },
# --   {
# --     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
# --     command = "shellcheck",
# --     ---@usage arguments to pass to the formatter
# --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
# --     extra_args = { "--severity", "warning" },
# --   },
# --   {
# --     command = "codespell",
# --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
# --     filetypes = { "javascript", "python" },
# --   },
# -- }
# 
# ----------------------------------------
# -- Additional Plugins
# ----------------------------------------
# lvim.plugins = {
#   {
#     "karb94/neoscroll.nvim",
#     event = "WinScrolled",
#     config = function()
#       require('neoscroll').setup({
#         mappings = { '<C-d>', '<C-u>', 'zz' },
#         respect_scrolloff = true,
#         easing_function = "circular", -- quadratic, cubic, quartic, quintic, circular, sine
#       })
#     end
#   }, {
#     "lukas-reineke/indent-blankline.nvim",
#     event = "BufRead",
#     setup = function()
#       vim.g.indentLine_enabled = 1
#       vim.g.indent_blankline_char = "▏"
#       vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard", "alpha", "packer" }
#       vim.g.indent_blankline_buftype_exclude = { "terminal", "quickfix", "nofile", "help" }
#       vim.g.indent_blankline_show_trailing_blankline_indent = false
#       vim.g.indent_blankline_show_first_indent_level = false
#     end
#   }, {
#     "rhysd/clever-f.vim",
#     keys = { "f", "F", "t", "T" },
#     setup = function()
#       vim.g.clever_f_across_no_linew = 1
#       vim.g.clever_f_smart_case = 1
#       vim.g.clever_f_fix_key_direction = 1
#     end
#   }, {
#     'phaazon/hop.nvim',
#     cmd = "Hop*",
#     branch = 'v1', -- optional but strongly recommended
#     setup = function()
#       vim.api.nvim_set_keymap("", ";", "<CMD>HopChar1<CR>", { noremap = true })
#       vim.api.nvim_set_keymap("", ",", "<CMD>HopLineStartMW<CR>", { noremap = true })
#     end,
#     config = function()
#       require("hop").setup({
#         char2_fallback_key = "<Esc>"
#       })
#     end
#   }, {
#     "bronson/vim-visual-star-search",
#     keys = { { "v", "*" }, { "v", "#" }, { "v", "g*" }, { "v", "g#" } },
#   }, {
#     "romainl/vim-cool",
#     event = "CursorMoved"
#   }, {
#     "windwp/nvim-spectre",
#     -- terminal map: ctrl+shift+h -> alt+shift+h
#     keys = { "<M-H>" },
#     config = function()
#       require("spectre").setup({
#         line_sep_start = '╭─────────────────────────────────────────────────────────',
#         result_padding = '│  ',
#         line_sep       = '╰─────────────────────────────────────────────────────────',
#         mapping        = {
#           ['run_replace'] = {
#             -- terminal map: ctrl+alt+enter -> alt+enter
#             map = "<M-CR>",
#             cmd = "<CMD>lua require('spectre.actions').run_replace()<CR>",
#             desc = "replace all"
#           },
#           ['toggle_ignore_case'] = {
#             map = "<M-c>",
#             cmd = "<CMD>lua require('spectre').change_options('ignore-case')<CR>",
#             desc = "toggle ignore case"
#           },
#         }
#       })
#       vim.api.nvim_set_keymap('n', '<M-H>', ":lua require('spectre').open_visual({select_word=true})<CR>", { noremap = true, silent = true })
#     end
#   }, {
#     "ethanholz/nvim-lastplace",
#     event = "BufRead",
#     config = function()
#       require("nvim-lastplace").setup({
#         lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
#         lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit", },
#         lastplace_open_folds = true,
#       })
#     end,
#   }, {
#     "MattesGroeger/vim-bookmarks",
#     event = "BufRead",
#     setup = function()
#       vim.g.bookmark_sign = ''
#       vim.g.bookmark_annotation_sign = ''
#       vim.g.bookmark_display_annotation = 1
#       vim.g.bookmark_auto_save_file = join_paths(get_cache_dir(), ".vim-bookmarks")
#     end,
#     config = function()
#       vim.cmd [[hi link BookmarkSign SignColumn]]
#       vim.cmd [[hi link BookmarkAnnotationSign SignColumn]]
#       vim.api.nvim_set_keymap('n', 'ma', '', {})
#       vim.api.nvim_set_keymap('n', 'mx', '', {})
#       vim.api.nvim_set_keymap('n', 'mC', '<CMD>BookmarkClearAll<CR>', { noremap = true })
#     end
#   }, {
#     "tom-anders/telescope-vim-bookmarks.nvim",
#     keys = { "ml", "mL" },
#     config = function()
#       require('telescope').load_extension('vim_bookmarks')
#       vim.api.nvim_set_keymap('n', 'ml', '<CMD>lua require("telescope").extensions.vim_bookmarks.current_file()<CR>', { noremap = true })
#       vim.api.nvim_set_keymap('n', 'mL', '<CMD>lua require("telescope").extensions.vim_bookmarks.all()<CR>', { noremap = true })
#     end
#   },
#   { "terryma/vim-expand-region",
#     keys = { { "v", "v" }, { "v", "V" } },
#     config = function()
#       vim.api.nvim_set_keymap('v', 'v', '<Plug>(expand_region_expand)', {})
#       vim.api.nvim_set_keymap('v', 'V', '<Plug>(expand_region_shrink)', {})
#     end
#   },
#   { 'kana/vim-textobj-user' },
#   { 'kana/vim-textobj-entire' },
#   { 'kana/vim-textobj-function' },
#   { 'kana/vim-textobj-indent' },
#   { 'kana/vim-textobj-line' },
#   { 'sgur/vim-textobj-parameter' },
#   { "tpope/vim-repeat" },
#   {
#     "tpope/vim-surround",
#     keys = { "c", "d", "y" }
#   },
#   {
#     "lambdalisue/suda.vim",
#     cmd = { "SudaRead", "SudaWrite" },
#     setup = function()
#       vim.api.nvim_set_keymap('n', '<M-s>', '<CMD>SudaWrite<CR>', { noremap = true })
#     end
#   }, {
#     "benfowler/telescope-luasnip.nvim",
#     keys = { "<M-i>" },
#     config = function()
#       require('telescope').load_extension('luasnip')
#       vim.api.nvim_set_keymap('n', '<M-i>', "<CMD>lua require'telescope'.extensions.luasnip.luasnip{}<CR>", { noremap = true })
#       vim.api.nvim_set_keymap('i', '<M-i>', "<CMD>lua require'telescope'.extensions.luasnip.luasnip{}<CR>", { noremap = true })
#     end
#   }, {
#     "ray-x/lsp_signature.nvim",
#     event = "InsertEnter",
#     config = function()
#       require "lsp_signature".setup()
#     end
#   }, {
#     "simrat39/symbols-outline.nvim",
#     cmd = "SymbolsOutline",
#     setup = function()
#       vim.g.symbols_outline = {
#         position = 'right',
#         width = 20,
#       }
#       -- HACK: terminal map: ctrl+shift+o -> alt+shift+o
#       vim.api.nvim_set_keymap('n', '<M-O>', '<CMD>SymbolsOutline<CR>', { noremap = true })
#       vim.api.nvim_set_keymap('n', '<C-S-O>', '<CMD>SymbolsOutline<CR>', { noremap = true })
#     end
#   }, {
#     "folke/trouble.nvim",
#     cmd = { "Trouble*" },
#     setup = function()
#       -- HACK: terminal map: ctrl+shift+m -> alt+shift+m
#       vim.api.nvim_set_keymap('n', '<C-S-M>', "<CMD>TroubleToggle<CR>", { noremap = true })
#     end
#   }, {
#     "folke/persistence.nvim",
#     event = "BufReadPre", -- this will only start session saving when an actual file was opened
#     module = "persistence",
#     setup = function()
#       lvim.builtin.which_key.mappings["S"] = {
#         name = "Session",
#         c = { "<CMD>lua require('persistence').load()<cr>", "Restore last session for current dir" },
#         l = { "<CMD>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
#         Q = { "<CMD>lua require('persistence').stop()<cr>", "Quit without saving session" },
#       }
#     end,
#     config = function()
#       require("persistence").setup {
#         dir = join_paths(get_cache_dir(), "session/"),
#         options = { "buffers", "curdir", "tabpages", "winsize" },
#       }
#     end,
#   }, {
#     "voldikss/vim-translator",
#     cmd = { "Translate*" },
#     setup = function()
#       vim.g.translator_default_engines = { 'bing', 'youdao' }
#       vim.api.nvim_set_keymap('n', '<M-t>', '<CMD>TranslateW<CR>', { noremap = true })
#       vim.api.nvim_set_keymap('v', '<M-t>', ':TranslateW<CR>', { noremap = true, silent = true })
#       lvim.builtin.which_key.mappings["t"] = {
#         name = "Translate",
#         t = { "<Plug>Translate", "Echo translation in the cmdline" },
#         w = { "<Plug>TranslateW", "Display translation in a window" },
#         r = { "<Plug>TranslateR", "Replace the text with translation" },
#       }
#       lvim.builtin.which_key.vmappings["t"] = {
#         name = "Translate",
#         t = { "<Plug>TranslateV", "Echo translation in the cmdline" },
#         w = { "<Plug>TranslateWV", "Display translation in a window" },
#         r = { "<Plug>TranslateRV", "Replace the text with translation" },
#       }
#     end,
#   }, {
#     "norcalli/nvim-colorizer.lua",
#     config = function()
#       require("colorizer").setup({ "*" }, {
#         RGB = true, -- #RGB hex codes
#         RRGGBB = true, -- #RRGGBB hex codes
#         RRGGBBAA = true, -- #RRGGBBAA hex codes
#         rgb_fn = true, -- CSS rgb() and rgba() functions
#         hsl_fn = true, -- CSS hsl() and hsla() functions
#         css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
#         css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
#       })
#     end,
#   },
#   {
#     "mg979/vim-visual-multi",
#     keys = {
#       { "n", "<C-n>" },
#       { "v", "<C-n>" },
#       { "n", "<M-L>" },
#       { "v", "<M-L>" },
#       { "n", "ma" },
#       { "v", "ma" }
#     },
#     setup = function()
#       vim.cmd [[
#         " VM will override <BS>
#         function! VM_Start()
#           iunmap <buffer><Bs>
#         endf
#         function! VM_Exit()
#           exe 'inoremap <buffer><expr><BS> v:lua.MPairs.autopairs_bs('.bufnr().')'
#         endf
#       ]]
#     end,
#     config = function()
#       -- HACK: terminal map: ctrl+shift+l -> alt+shift+l
#       vim.api.nvim_set_keymap('n', '<M-L>', '<Plug>(VM-Select-All)', {})
#       vim.api.nvim_set_keymap('v', '<M-L>', '<Plug>(VM-Visual-All)', {})
#       vim.api.nvim_set_keymap('n', '<C-S-L>', '<Plug>(VM-Select-All)', {})
#       vim.api.nvim_set_keymap('v', '<C-S-L>', '<Plug>(VM-Visual-All)', {})
#       vim.api.nvim_set_keymap('n', 'ma', '<Plug>(VM-Add-Cursor-At-Pos)', {})
#       vim.api.nvim_set_keymap('v', 'ma', '<Plug>(VM-Visual-Add)', {})
#     end
#   }, {
#     "fedorenchik/VimCalc3",
#     cmd = { "Calc" }
#   }, {
#     "folke/todo-comments.nvim",
#     event = "BufRead",
#     config = function()
#       require("todo-comments").setup()
#     end,
#   }, {
#     "p00f/nvim-ts-rainbow"
#   }, {
#     "petertriho/nvim-scrollbar",
#     config = function()
#       require("scrollbar").setup()
#     end
#   }, {
#     "mbbill/undotree",
#     cmd = { "UndotreeToggle" }
#   }
# }
# 
# -- Autocommands (https://neovim.io/doc/user/autocmd.html)
# -- vim.cmd [[
# --   function! AutoOpenAlpha()
# --     let bufs = getbufinfo({'buflisted':1})
# --     let g:fuck_bufs = bufs
# --     let g:fuck_bufnr = bufnr()
# --     if len(bufs) == 1 && bufnr() == bufs[0].bufnr
# --       Alpha
# --     endif
# --   endf
# -- ]]
# vim.cmd [[
# function! SmartClose() abort
#   if &bt ==# 'nofile' || &bt ==# 'quickfix'
#     quit
#     return
#   endif
#   let num = winnr('$')
#   for i in range(1, num)
#     let buftype = getbufvar(winbufnr(i), '&buftype')
#     if buftype ==# 'quickfix' || buftype ==# 'nofile'
#       let num = num - 1
#     elseif getwinvar(i, '&previewwindow') == 1 && winnr() !=# i
#       let num = num - 1
#     endif
#   endfor
#   if num == 1
#     if len(getbufinfo({'buflisted':1,'bufloaded':1,'bufmodified':1})) > 0
#       echohl WarningMsg
#       echon 'There are some buffer modified! Quit/Save/Cancel'
#       let rs = nr2char(getchar())
#       echohl None
#       if rs ==? 'q'
#         qall!
#       elseif rs ==? 's' || rs ==? 'w'
#         redraw
#         wall
#         qall
#       else
#         redraw
#         echohl ModeMsg
#         echon 'canceled!'
#         echohl None
#       endif
#     else
#       qall
#     endif
#   else
#     quit
#   endif
# endf
# 
# function! Open_file_in_explorer() abort
#   if has('win32') || has('wsl')
#     call jobstart('explorer.exe .')
#   elseif has('unix')
#     call jobstart('xdg-open .')
#   endif
# endf
# ]]
# lvim.autocommands.custom_groups = {
#   -- { "WinEnter", "*", [[call AutoOpenMinimap()]] }
# }
# __CONFIG_LUA_END

# __GITCONFIG
# [user]
#     email = mrbeardad@qq.com
#     name = Heache Bear
# [merge]
#     tool = vimdiff
# [mergetool "vimdiff"]
#     path = nvim
# __GITCONFIG_END

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
# __SSH_CONFIG_END
