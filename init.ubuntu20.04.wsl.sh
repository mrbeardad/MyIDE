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
  ask_user "Do you want to change apt mirror source to tencent cloud?" || return
  sudo wget -O /etc/apt/sources.list http://mirrors.cloud.tencent.com/repo/ubuntu20_sources.list
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

  go env -w GOPATH="$HOME"/.local/go/ GOBIN="$HOME"/.local/bin/ GOSUMDB=sum.golang.google.cn
  ask_user "Do you want to set GOPROXY to tencent cloud mirror?" &&
    go env -w GOPROXY=https://mirrors.tencent.com/go/,direct

  ask_user "Do you want to config npm registry to tencent cloud mirror?" &&
    npm config set registry http://mirrors.tencent.com/npm/ &&
    npm config set global-bin-dir ~/.local/bin &&
    sudo npm install -g pnpm

  ask_user "Do you want to config pip index-url to tencent cloud mirror?" &&
    pip config set global.index-url https://mirrors.tencent.com/pypi/simple
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
  sudo curl -Lo /etc/apt/trusted.gpg.d/docker-ce.gpg https://mirrors.cloud.tencent.com/docker-ce/linux/ubuntu/gpg
  sudo add-apt-repository "deb [arch=amd64] https://mirrors.cloud.tencent.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
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
  sudo apt -y install htop
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
  sudo apt -y install neovim ripgrep
  pip install --upgrade pynvim

  curl -Lo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
  unzip -p /tmp/win32yank.zip win32yank.exe >./win32yank.exe
  chmod +x win32yank.exe
  # ~/.local/bin may not be in PATH when open neovim from ranger
  sudo cp -v win32yank.exe /bin/

  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
  mkdir -p ~/.config/lvim/after/ftplugin/
  get_config __CONFIG_LUA >~/.config/lvim/config.lua
  PROMPT_INFORMATION="$PROMPT_INFORMATION$(echo -e "\e[32m======>\e[33m neovim:\e[m Don't forget to run ':PackerSync' in lvim to install plugins")"
}

lang_shell() {
  sudo apt -y install shellcheck
  go install mvdan.cc/sh/v3/cmd/shfmt@latest
  cat >~/.config/lvim/after/ftplugin/sh.lua <<EOF
require "lvim.lsp.null-ls.linters".setup({
  { filetypes = { "sh" }, command = "shellcheck" }
})
require "lvim.lsp.null-ls.formatters".setup({
  { filetypes = { "sh" }, command = "shfmt", args = { "-i", "2" } }
})
EOF
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
  wget -O /tmp/lsd.deb https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd-musl_0.20.1_amd64.deb
  sudo dpkg -i /tmp/lsd.deb
  git clone --recurse-submodules https://github.com/mrbeardad/SeeCheatSheets ~/.cheat
  mkdir ~/.cheat/src/build
  (
    cd ~/.cheat/src/build
    cmake -D CMAKE_BUILD_TYPE=Release ..
    cmake --build . -t see
    cmake --install .
  )
}

main() {
  parse_arguments "$@"
  if [[ "$OPTION_UPDATE_CONFIG" == "1" ]]; then
    if [[ -d "$WIN_HOME" ]]; then
      cp -uv "$WIN_HOME"/AppData/Roaming/Code/User/{settings.json,keybindings.json} ./vscode/
      cp -uv "$WIN_HOME"/AppData/Roaming/Code/User/sync/extensions/lastSyncextensions.json ./vscode/
      cp -uv "$WIN_HOME"/AppData/Local/vscode-neovim/init.vim ./vscode/vscode-neovim/init.vim
      cp -uv "$WIN_HOME"/AppData/Local/Packages/Microsoft.WindowsTerminal_*/LocalState/settings.json WindowsTerminal/settings.json
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
# bind b previous-window
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
# if [[ -e ~/.local/bin/lvim ]]; then
#     export EDITOR='lvim'
# elif [[ -e /bin/nvim ]]; then
#     export EDITOR='nvim'
# else
#     export EDITOR='vim'
# fi
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
# # bindkey '^L' vi-forward-char
# bindkey '^H' backward-word
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
# hide_threads=1
# hide_kernel_threads=1
# hide_userland_threads=1
# shadow_other_users=0
# show_thread_names=0
# show_program_path=0
# highlight_base_name=0
# highlight_megabytes=1
# highlight_threads=1
# tree_view=1
# header_margin=1
# detailed_cpu_time=0
# cpu_count_from_zero=0
# update_process_names=0
# account_guest_in_cpu_meter=0
# color_scheme=6
# delay=15
# left_meters=LeftCPUs Memory Swap
# left_meter_modes=1 1 1
# right_meters=RightCPUs Tasks LoadAverage Uptime
# right_meter_modes=1 2 2 2
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
# vim.opt.timeoutlen = 350
# vim.opt.guicursor = 'n:block-blinkon10,i-ci:ver25-blinkon10,c:hor20-blinkon10,v-sm:block,ve:ver25,r-cr-o:hor20'
# vim.opt.relativenumber = true
# vim.opt.list = true
# vim.opt.listchars = 'tab:→ ,eol:↵,trail:·,extends:↷,precedes:↶'
# vim.opt.clipboard = ''
# vim.opt.swapfile = true
# vim.opt.directory = join_paths(get_cache_dir(), "swap")
# lvim.log.level = "warn"
# lvim.format_on_save = true
# lvim.colorscheme = "onedarker"
#
# ----------------------------------------
# -- KEYMAPPINGS
# ----------------------------------------
# lvim.leader = "space"
# -- 光标移动
# vim.api.nvim_set_keymap('c', '<C-a>', '<C-b>', { noremap = true })
# vim.api.nvim_set_keymap('i', '<C-e>', '<End>', { noremap = true })
# vim.api.nvim_set_keymap('v', '<C-e>', '$', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-e>', '$', { noremap = true })
# -- 全文搜索
# vim.api.nvim_set_keymap('n', '<Bs>', '<Cmd>nohl<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-l>', '<Cmd>nohl<Cr><C-l>', { noremap = true })
# vim.api.nvim_set_keymap('n', 'n', "'Nn'[v:searchforward]", { noremap = true, expr = true })
# vim.api.nvim_set_keymap('n', 'N', "'nN'[v:searchforward]", { noremap = true, expr = true })
# vim.api.nvim_set_keymap('c', '<M-c>', "\\<\\><Left><Left>", { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-f>', '<Cmd>Telescope current_buffer_fuzzy_find<Cr>', { noremap = true })
# vim.cmd([[
#   function! s:VSetSearch() abort
#     let temp = @s
#     norm! gv"sy
#     let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
#     let @s = temp
#   endf
#   vnoremap <C-h> :<C-u>call <SID>VSetSearch()<CR>:,$s/<C-R>=@/<CR>//gc<left><left><left>
#   nnoremap <C-h> viw:<C-u>call <SID>VSetSearch()<CR>:,$s/<C-R>=@/<CR>//gc<left><left><left>
# ]])
# -- terminal map: ctrl+shift+f -> alt+f
# vim.api.nvim_set_keymap('n', '<M-f>', '<Cmd>Telescope live_grep<Cr>', { noremap = true })
# -- 标签跳转
# -- terminal map: ctrl+i -> alt+shift+i
# vim.api.nvim_set_keymap('n', '<M-I>', '<C-i>', { noremap = true })
# -- 插入编辑
# vim.api.nvim_set_keymap('n', '<', '<<', { noremap = true })
# vim.api.nvim_set_keymap('n', '>', '>>', { noremap = true })
# -- terminal map: ctrl+shift+j -> alt+shift+j
# vim.api.nvim_set_keymap('i', '<M-J>', '<Cmd>m .+1<CR><Cmd>normal ==<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<M-J>', '<Cmd>m .+1<CR><Cmd>normal ==<Cr>', { noremap = true })
# -- terminal map: ctrl+shift+k -> alt+shift+k
# vim.api.nvim_set_keymap('i', '<M-K>', '<Cmd>m .-2<CR><Cmd>normal ==<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<M-K>', '<Cmd>m .-2<CR><Cmd>normal ==<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('i', '<C-j>', '<End><Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-j>', '<Cmd>put =repeat(nr2char(10), v:count1)<CR>', { noremap = true })
# vim.api.nvim_set_keymap('i', '<C-k>', "repeat('<Del>', strchars(getline('.')) - getcurpos()[2] + 1)", { noremap = true, expr = true })
# vim.api.nvim_set_keymap('c', '<C-k>', "repeat('<Del>', strchars(getcmdline()) - getcmdpos() + 1)", { noremap = true, expr = true })
# vim.api.nvim_set_keymap('i', '<C-l>', '<C-Right>', { noremap = true })
# vim.api.nvim_set_keymap('c', '<C-l>', '<C-Right>', { noremap = true })
# vim.api.nvim_set_keymap('i', '<C-z>', '<Cmd>undo<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('i', '<C-r><C-r>', '<Cmd>redo<Cr>', { noremap = true })
# -- 复制粘贴
# vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })
# vim.api.nvim_set_keymap('v', '=p', '"0p', { noremap = true })
# vim.api.nvim_set_keymap('n', '=p', '"0p', { noremap = true })
# vim.api.nvim_set_keymap('n', '=P', '"0P', { noremap = true })
# vim.api.nvim_set_keymap('n', '=o', '<Cmd>put =@0<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '=O', '<Cmd>put! =@0<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('v', '<Space>y', '"+y', { noremap = true })
# vim.api.nvim_set_keymap('v', '<Space>p', '"+p', { noremap = true })
# lvim.builtin.which_key.mappings["<Space>"] = { "<Cmd>let @+ = @0<Cr>", "Copy Register 0 to Clipboard" }
# lvim.builtin.which_key.mappings["y"] = { '"+y', "Yank to Clipboard" }
# lvim.builtin.which_key.mappings["Y"] = { '"+y$', "Yank All Right to Clipboard" }
# lvim.builtin.which_key.mappings["p"] = { '"+p', "Paste Clipboard After Cursor" }
# lvim.builtin.which_key.mappings["P"] = { '"+P', "Paste Clipboard Before Cursor" }
# lvim.builtin.which_key.mappings["o"] = { "<Cmd>put =@+<Cr>", "Paste Clipboard to Next Line" }
# lvim.builtin.which_key.mappings["O"] = { "<Cmd>put! =@+<Cr>", "Paste Clipboard to Previous Line" }
# lvim.builtin.which_key.mappings["by"] = { "<Cmd>%y +<Cr>", "Yank Whole Buffer to Clipboard" }
# lvim.builtin.which_key.mappings["bp"] = { "<Cmd>%d<Cr>\"+P", "Patse Clipboard to Whole Buffer" }
# -- 文件操作
# lvim.keys.normal_mode["<C-k>"] = false
# vim.api.nvim_set_keymap('n', '<C-k><C-o>', '<Cmd>Telescope projects<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k>o', ":e <C-r>=expand('%:p')<Cr>", { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k>n', '<Cmd>enew<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k>r', '<Cmd>Telescope oldfiles<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-p>', '<Cmd>Telescope find_files<Cr>', { noremap = true })
# lvim.builtin.which_key.mappings["<Tab>"] = { ":try | b# | catch | endtry<Cr>", "Switch Buffer" }
# vim.api.nvim_set_keymap('n', '<C-s>', '<Cmd>w<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k>s', '<Cmd>wa<Cr>', { noremap = true })
# vim.cmd([[
# function! s:save_as_new_file() abort
#   let current_fname = bufname()
#   let separator = has('win32') ? '\' : '/'
#   if !empty(current_fname)
#     let dir = fnamemodify(current_fname, ':h') . separator
#   else
#     let dir = getcwd() . separator
#   endif
#   let input = input('save as: ', dir, 'file')
#   noautocmd normal! :
#   if !empty(input)
#     exe 'silent! write ' . input
#     exe 'e ' . input
#     if v:errmsg !=# ''
#       echohl ErrorMsg
#       echo  v:errmsg
#       echohl None
#     else
#       echohl Delimiter
#       echo  fnamemodify(bufname(), ':.:gs?[\\/]?/?') . ' written'
#       echohl None
#     endif
#   else
#     echo 'canceled!'
#   endif
# endfunction
# nnoremap <M-S> <Cmd>call <SID>save_as_new_file()<Cr>
# ]])
# vim.api.nvim_set_keymap('n', '<C-k>x', '<Cmd>BufferKill<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k>u', ':try | %bd | catch | endtry<Cr>', { noremap = true, silent = true })
# vim.api.nvim_set_keymap('n', '<C-k>w', '<Cmd>%bd<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<Tab>', '<Cmd>wincmd w<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<S-Tab>', '<Cmd>wincmd p<Cr>', { noremap = true })
# -- 语言服务
# lvim.builtin.cmp.mapping["<C-j>"] = nil
# lvim.builtin.cmp.mapping["<C-k>"] = nil
# lvim.builtin.cmp.mapping["<C-e>"] = nil
# lvim.builtin.cmp.confirm_opts.select = true
# local cmp = require("cmp")
# local luasnip = require("luasnip")
# local lccm = require("lvim.core.cmp").methods
# -- terminal map: ctrl+i -> alt+shift+i
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
# vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', {})
# vim.api.nvim_set_keymap('i', '<C-_>', '<Cmd>normal gcc<Cr>', {})
# vim.api.nvim_set_keymap('n', '<F2>', "<Cmd>lua require('which-key').execute(3)<CR>", { noremap = true })
# -- terminal map: ctrl+. -> alt+.
# vim.api.nvim_set_keymap('n', '<M-.>', '<Cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<M-F>', '<Cmd>lua require("lvim.lsp.utils").format()<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('i', '<M-F>', '<Cmd>lua require("lvim.lsp.utils").format()<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-t>', '<Cmd>Telescope lsp_workspace_symbols<Cr>', { noremap = true })
# vim.api.nvim_set_keymap('n', '[e', "<Cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true })
# vim.api.nvim_set_keymap('n', ']e', "<Cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true })
# vim.api.nvim_set_keymap('n', '[h', "<Cmd>Gitsigns next_hunk<CR>", { noremap = true })
# vim.api.nvim_set_keymap('n', ']h', "<Cmd>Gitsigns prev_hunk<CR>", { noremap = true })
# -- 界面元素
# -- terminal map: ctrl+shift+n -> alt+shift+n
# vim.api.nvim_set_keymap('n', '<M-N>', "<Cmd>lua require('telescope').extensions.notify.notify()<Cr>", { noremap = true })
# -- terminal map: ctrl+shift+p -> alt+shift+p
# vim.api.nvim_set_keymap('n', '<M-P>', "<Cmd>Telescope commands<Cr>", { noremap = true })
# vim.api.nvim_set_keymap('n', '<C-k><C-s>', "<Cmd>Telescope keymaps<Cr>", { noremap = true })
# vim.api.nvim_set_keymap('n', '<M-z>', "<Cmd>let &wrap=!&wrap<Cr>", { noremap = true })
# vim.cmd([[
# function! s:open_file_in_explorer() abort
#   if has('win32') || has('wsl')
#     call jobstart('explorer.exe .')
#   elseif has('unix')
#     call jobstart('xdg-open .')
#   endif
# endf
# nnoremap <M-E> <Cmd>call <SID>open_file_in_explorer()<Cr>
# ]])
# -- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
# -- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
# local _, actions = pcall(require, "telescope.actions")
# lvim.builtin.telescope.defaults.mappings = {
#   -- for input mode
#   i = {
#     ["<Esc>"] = actions.close,
#     ["<C-b>"] = actions.preview_scrolling_up,
#     ["<C-u>"] = nil
#   },
#   -- for normal mode
#   n = {
#   },
# }
# -- Use which-key to add extra bindings with the leader-key prefix
# -- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
#
#
# ----------------------------------------
# -- TODO: User Config for predefined plugins
# ----------------------------------------
# -- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
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
# lvim.builtin.notify.active = true
# lvim.builtin.terminal.active = false
# lvim.builtin.nvimtree.setup.view.side = "left"
# lvim.builtin.nvimtree.show_icons.git = 1
# lvim.builtin.bufferline.options.always_show_bufferline = true
# local components = require("lvim.core.lualine.components")
# lvim.builtin.lualine.options = { globalstatus = true }
# lvim.builtin.lualine.sections.lualine_a = {
#   {
#     '',
#     separator = { right = '' },
#     type = 'stl'
#   }
# }
# lvim.builtin.lualine.sections.lualine_b = {
#   function()
#     return "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " "
#   end,
#   {
#     'branch',
#     separator = { right = ' ' }
#   },
# }
# lvim.builtin.lualine.sections.lualine_x = {
#   components.diagnostics,
#   {
#     function(msg)
#       local lsp = components.lsp[1](msg)
#       if lsp == 'LS Inactive' then
#         return '[LS Inactive]'
#       else
#         return '  ' .. lsp:gsub("^%[(.-)%]$", "%1")
#       end
#     end,
#     color = components.lsp.color,
#     cond = components.lsp.cond,
#   },
#   components.treesitter,
#   components.filetype,
#   "fileformat"
# }
# lvim.builtin.lualine.sections.lualine_y = {
#   { ' %l/%L  %c', type = 'stl' }
# }
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
# -- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
# -- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
# -- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
# -- local opts = {} -- check the lspconfig documentation for a list of all possible options
# -- require("lvim.lsp.manager").setup("pyright", opts)
#
# -- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
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
# -- Tip 1. Don't use keys to lazy load an set key maps in setup, packer.nvim will unmap your keys
# -- Tip 2. When you need to map keys to command, use cmd lazy load an set key maps in setup
# ----------------------------------------
# lvim.plugins = {
#   {
#     "karb94/neoscroll.nvim",
#     event = "WinScrolled",
#     config = function()
#       require('neoscroll').setup({
#         mappings = { '<C-d>', 'zz' },
#         respect_scrolloff = true,
#         easing_function = "circular", -- quadratic, cubic, quartic, quintic, circular, sine
#       })
#       vim.api.nvim_set_keymap("n", "<C-b>", "<Cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 250)<CR>", { noremap = true })
#       vim.api.nvim_set_keymap("v", "<C-b>", "<Cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 250)<CR>", { noremap = true })
#       vim.api.nvim_set_keymap("s", "<C-b>", "<Cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 250)<CR>", { noremap = true })
#     end
#   }, {
#     "lukas-reineke/indent-blankline.nvim",
#     event = "BufRead",
#     setup = function()
#       vim.g.indentLine_enabled = 1
#       vim.g.indent_blankline_char = "▏"
#       vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard", "alpha" }
#       vim.g.indent_blankline_buftype_exclude = { "terminal" }
#       vim.g.indent_blankline_show_trailing_blankline_indent = false
#       vim.g.indent_blankline_show_first_indent_level = false
#     end
#   }, {
#     "rhysd/clever-f.vim",
#     keys = { "f", "F", "t", "T" },
#     setup = function()
#       vim.g.clever_f_smart_case = 1
#       vim.g.clever_f_fix_key_direction = 1
#     end
#   }, {
#     'phaazon/hop.nvim',
#     cmd = "Hop*",
#     branch = 'v1', -- optional but strongly recommended
#     setup = function()
#       vim.api.nvim_set_keymap("", ";", "<Cmd>HopChar2<Cr>", { noremap = true })
#       vim.api.nvim_set_keymap("", ",", "<Cmd>HopLineStartMW<Cr>", { noremap = true })
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
#             cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
#             desc = "replace all"
#           },
#           ['toggle_ignore_case'] = {
#             map = "<M-c>",
#             cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
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
#         lastplace_ignore_filetype = {
#           "gitcommit", "gitrebase", "svn", "hgcommit",
#         },
#         lastplace_open_folds = true,
#       })
#     end,
#   }, {
#     "MattesGroeger/vim-bookmarks",
#     event = "BufRead",
#     setup = function()
#       vim.g.bookmark_sign = ''
#       vim.g.bookmark_annotation_sign = ''
#       vim.g.bookmark_auto_save_file = join_paths(get_cache_dir(), "bookmark")
#     end,
#     config = function()
#       vim.cmd [[hi link BookmarkSign SignColumn]]
#       vim.cmd [[hi link BookmarkAnnotationSign SignColumn]]
#       vim.api.nvim_set_keymap('n', 'ma', '', {})
#       vim.api.nvim_set_keymap('n', 'mx', '', {})
#       vim.api.nvim_set_keymap('n', 'mC', '<Cmd>BookmarkClearAll<Cr>', { noremap = true })
#     end
#   }, {
#     "tom-anders/telescope-vim-bookmarks.nvim",
#     keys = { "ml", "mL" },
#     config = function()
#       require('telescope').load_extension('vim_bookmarks')
#       vim.api.nvim_set_keymap('n', 'ml', '<Cmd>lua require("telescope").extensions.vim_bookmarks.current_file()<Cr>', { noremap = true })
#       vim.api.nvim_set_keymap('n', 'mL', '<Cmd>lua require("telescope").extensions.vim_bookmarks.all()<Cr>', { noremap = true })
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
#       vim.api.nvim_set_keymap('n', '<M-s>', '<Cmd>SudaWrite<Cr>', { noremap = true })
#     end
#   }, {
#     "benfowler/telescope-luasnip.nvim",
#     keys = { "<M-i>" },
#     config = function()
#       require('telescope').load_extension('luasnip')
#       vim.api.nvim_set_keymap('n', '<M-i>', "<Cmd>lua require'telescope'.extensions.luasnip.luasnip{}<Cr>", { noremap = true })
#       vim.api.nvim_set_keymap('i', '<M-i>', "<Cmd>lua require'telescope'.extensions.luasnip.luasnip{}<Cr>", { noremap = true })
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
#       -- terminal map: ctrl+shift+o -> alt+shift+o
#       vim.api.nvim_set_keymap('n', '<M-O>', '<Cmd>SymbolsOutline<Cr>', { noremap = true })
#     end
#   }, {
#     "folke/trouble.nvim",
#     cmd = { "Trouble*" },
#     setup = function()
#       -- terminal map: ctrl+shift+m -> alt+shift+m
#       vim.api.nvim_set_keymap('n', '<M-M>', "<Cmd>TroubleToggle<Cr>", { noremap = true })
#     end
#   }, {
#     "folke/persistence.nvim",
#     event = "BufReadPre", -- this will only start session saving when an actual file was opened
#     module = "persistence",
#     setup = function()
#       lvim.builtin.which_key.mappings["S"] = {
#         name = "Session",
#         c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
#         l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
#         Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
#       }
#     end,
#     config = function()
#       require("persistence").setup {
#         dir = join_paths(get_cache_dir(), "session"),
#         options = { "buffers", "curdir", "tabpages", "winsize" },
#       }
#     end,
#   }, {
#     "voldikss/vim-translator",
#     cmd = { "Translate*" },
#     setup = function()
#       vim.g.translator_default_engines = { 'bing', 'youdao' }
#       vim.api.nvim_set_keymap('n', '<M-t>', '<Cmd>TranslateW<Cr>', { noremap = true })
#       vim.api.nvim_set_keymap('v', '<M-t>', ':TranslateW<Cr>', { noremap = true, silent = true })
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
#         function! VM_Start()
#           iunmap <buffer><Bs>
#         endf
#         function! VM_Exit()
#           exe 'inoremap <buffer><expr><BS> v:lua.MPairs.autopairs_bs('.bufnr().')'
#         endf
#       ]]
#     end,
#     config = function()
#       -- terminal map: ctrl+shift+l -> alt+shift+l
#       vim.api.nvim_set_keymap('n', '<M-L>', '<Plug>(VM-Select-All)', {})
#       vim.api.nvim_set_keymap('v', '<M-L>', '<Plug>(VM-Visual-All)', {})
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
#   },
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
# -- lvim.autocommands.custom_groups = {
# -- { "BufUnload", "*", [[call AutoOpenAlpha()]] },
# -- }
# __CONFIG_LUA_END

# __GITCONFIG
# [user]
#     email = mrbeardad@qq.com
#     name = Heache Bear
# [merge]
#     tool = vimdiff
# [mergetool "vimdiff"]
#     path = lvim
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
