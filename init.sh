#!/bin/env bash

set -eo pipefail

PATH="$HOME"/.local/bin:"$PATH"

CONFIG_FILE=${CONFIG_FILE:-"$0"}
WIN_HOME=${WIN_HOME:-"/winhome"}
OPTION_UPDATE_CONFIG=
OPTION_AUTO_YES=
PROMPT_INFORMATION=

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

  # NOTE: Redirect operation execute before simple command, so bash will truncate file before read it
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
  ask_user "Do you want to execute 'sudo' without password?" || return 0
  sudo sed -i '/^%sudo\s*ALL=(ALL:ALL)\s*ALL$/s/ALL$/NOPASSWD: ALL/' /etc/sudoers
}

change_apt_mirror_source() {
  sudo apt -y install git curl gpg
  ask_user "Do you want to change apt mirror source to tencent cloud?" || return 0
  sudo curl -Lo /etc/apt/sources.list http://mirrors.cloud.tencent.com/repo/ubuntu20_sources.list
  sudo apt update
}

upgrade_to_ubuntu22() {
  ask_user "Do you want yo upgrade to ubuntu22.04 STL?" || return 0
  sudo apt -y upgrade
  sudo do-release-upgrade -d
}

prerequisites() {
  curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  sudo apt -y install golang cargo python3-pip python-is-python3 nodejs unzip

  ask_user "Do you want to set GOPROXY to tencent cloud mirror?" &&
    go env -w GOPROXY=https://mirrors.tencent.com/go/,direct
  go env -w GOPATH="$HOME"/.go/ GOBIN="$HOME"/.local/bin/ GOSUMDB=sum.golang.google.cn

  ask_user "Do you want to config npm registry to tencent cloud mirror?" &&
    npm config set registry http://mirrors.tencent.com/npm/
  npm config set prefix ~/.local
  npm config set global-bin-dir ~/.local/bin
  npm install pnpm -g

  ask_user "Do you want to config pip index-url to tencent cloud mirror?" &&
    pip config set global.index-url https://mirrors.tencent.com/pypi/simple

  ask_user "Do you want to config cargo registry to utsc cloud mirror?" &&
    mkdir -p ~/.cargo && cat >~/.cargo/config <<EOF
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
    mkdir -p ~/.ssh/
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
  PROMPT_INFORMATION="$PROMPT_INFORMATION$(echo -e "\e[32m======>\e[33m zsh:\e[m You may want to custom your zsh prompt theme and enable proxy prompt by modify ~/.p10k.zsh")"
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
  sudo apt -y install btop libncursesw5-dev autoconf automake libtool
  git clone --depth=1 https://github.com/KoffeinFlummi/htop-vim ~/.local/share/htop-vim
  (
    cd ~/.local/share/htop-vim
    ./autogen.sh && ./configure && make
    cp ./htop ~/.local/bin/
  )
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
  cargo install stylua

  curl -Lo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
  unzip -p /tmp/win32yank.zip win32yank.exe >~/.local/bin/win32yank.exe
  chmod +x ~/.local/bin/win32yank.exe

  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

  # get_config __CONFIG_LUA >~/.config/lvim/config.lua
  rm -fr ~/.config/lvim/
  git clone https://github.com/mrbeardad/MyLunarVim ~/.config/lvim
  ~/.config/lvim/bin/nvim --headless \
    -c 'autocmd User PackerComplete quitall' \
    -c 'PackerSync'
  ask_user "Do you want use lvim instead of nvim all the time? Means to copy ~/.config/lvim/bin/nvim to /usr/local/bin" &&
    sudo cp ~/.config/lvim/bin/nvim /usr/local/bin/nvim
}

lang_shell() {
  sudo apt -y install shellcheck
  go install mvdan.cc/sh/v3/cmd/shfmt@latest
}

lang_cpp() {
  sudo apt -y install clang lldb lld clangd clang-tidy clang-format cppcheck \
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
  sudo apt install -y tidy
  pnpm install -g eslint htmlhint stylelint markdownlint-cli prettier
}

other_cli_tools() {
  sudo apt -y install neofetch cloc ncdu gnupg nmap socat
  cargo install lsd
  git clone --recurse-submodules https://github.com/mrbeardad/SeeCheatSheets ~/.cheat
  mkdir -p ~/.cheat/src/build
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
      cp -uv "$WIN_HOME"/AppData/Local/vscode-neovim/init.vim ./vscode/vscode-neovim/
      cp -uv "$WIN_HOME"/AppData/Local/Packages/Microsoft.WindowsTerminal_*/LocalState/settings.json wt/settings.json
    fi
    set_config __TMUX_CONF ~/.tmux.conf
    set_config __ZSHRC ~/.zshrc
    set_config __RANGER ~/.config/ranger/commands.py
    set_config __HTOPRC ~/.config/htop/htoprc
    set_config __TIGRC ~/.tigrc
    # set_config __CONFIG_LUA ~/.config/lvim/config.lua
    set_config __GITCONFIG ~/.gitconfig
    set_config __SSH_CONFIG ~/.ssh/config
  else
    cd "$(dirname "$0")"
    mkdir -p ~/.local/bin/
    mkdir -p ~/.local/share/
    mkdir -p ~/.config/

    sudo_without_passwd
    change_apt_mirror_source
    upgrade_to_ubuntu22
    prerequisites
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
# # ----------------------------=== General ===--------------------------
# set -g default-terminal "screen-256color"
# if 'infocmp -x tmux-256color > /dev/null 2>&1' 'set -g default-terminal "tmux-256color"'
# # true color support
# set -ga terminal-overrides ",*256color:RGB"
# # undercurl support
# set -ga terminal-overrides ',*:Smulx=\E[4::%p1%dm'
# # underscore colours support
# set -ga terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
# # cursor style support
# set -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[1 q'
# 
# set -g extended-keys always  # enable extended keys in escape sequence, for example, ctrl+shift+letter
# set -g escape-time 10
# set -g focus-events on
# set -g mouse on
# set -g set-clipboard on
# set -g mode-keys vi
# 
# # ----------------------------=== Display ===--------------------------
# set -g set-titles off         # set terminal title
# set -g base-index 1           # start windows numbering at 1
# set -g pane-base-index 1      # make pane numbering consistent with windows
# set -g automatic-rename on    # rename window to reflect current program
# set -g renumber-windows on    # renumber windows when a window is closed
# set -g display-panes-time 800 # slightly longer pane indicators display time
# set -g display-time 1000      # slightly longer status messages display time
# set -g monitor-activity on    # monitor for activity in the window. 
# set -g visual-activity off    # don't display a message instead of sending a bell when activity occurs in monitored window
# set -g status-interval 10     # redraw status line every 10 seconds
# 
# # ----------------------------=== Theme ===--------------------------
# # colors
# thm_bg="#1e1e28"
# thm_fg="#dadae8"
# thm_cyan="#c2e7f0"
# thm_black="#15121c"
# thm_gray="#332e41"
# thm_magenta="#c6aae8"
# thm_pink="#e5b4e2"
# thm_red="#e38c8f"
# thm_green="#b1e3ad"
# thm_yellow="#ebdd98"
# thm_blue="#a4b9ef"
# thm_orange="#ffba96"
# thm_black4="#474258"
# 
# # status
# set -g status on
# set -g status-bg "${thm_bg}"
# set -g status-position top
# set -g status-justify "centre"
# set -g status-left-length "100"
# set -g status-right-length "100"
# 
# # messages
# set -g message-style fg="${thm_cyan}",bg="${thm_gray}",align="centre"
# set -g message-command-style fg="${thm_cyan}",bg="${thm_gray}",align="centre"
# 
# # panes
# set -g pane-border-style fg="${thm_gray}"
# set -g pane-active-border-style fg="${thm_blue}"
# 
# # windows
# setw -g window-status-activity-style fg="${thm_fg}",bg="${thm_bg}",none
# setw -g window-status-separator ""
# setw -g window-status-style fg="${thm_fg}",bg="${thm_bg}",none
# 
# # statusline
# setw -g window-status-format "#[fg=$thm_blue,bg=$thm_bg]#[fg=$thm_bg,bg=$thm_blue,italics]#I #[fg=$thm_fg,bg=$thm_gray] #W#[fg=$thm_gray,bg=$thm_bg] "
# setw -g window-status-current-format "#{?client_prefix,#[fg=$thm_red],#{?window_zoomed_flag,#[fg=$thm_yellow],#[fg=$thm_orange]}}#[bg=$thm_bg]#[fg=$thm_bg,italics]#{?client_prefix,#[bg=$thm_red],#{?window_zoomed_flag,#[bg=$thm_yellow],#[bg=$thm_orange]}}#I #{?client_prefix,#[fg=$thm_red],#{?window_zoomed_flag,#[fg=$thm_yellow],#[fg=$thm_fg]}}#[bg=$thm_black4] #W#[fg=$thm_black4,bg=$thm_bg] "
# set -g status-left "#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics] #S #[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics] #[fg=$thm_green,bg=$thm_gray]#[bg=$thm_green,fg=$thm_bg]ﱿ #{b:pane_current_path} #[fg=$thm_green,bg=$thm_bg]"
# set -g status-right "#[fg=$thm_cyan,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_cyan,nobold,nounderscore,noitalics] %H:%M #[fg=$thm_cyan,bg=$thm_bg,nobold,nounderscore,noitalics] #[fg=$thm_magenta,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_magenta,nobold,nounderscore,noitalics] %F #[fg=$thm_magenta,bg=$thm_bg,nobold,nounderscore,noitalics]"
# 
# # modes
# setw -g clock-mode-colour "${thm_blue}"
# setw -g mode-style "fg=${thm_pink} bg=${thm_black4} bold"
# 
# # ----------------------------=== Keybindings ===--------------------------
# # prefix
# unbind C-Z
# unbind C-B
# set -g prefix M-w
# 
# # clear both screen and history
# bind -n C-l send-keys C-l \; run 'sleep 0.2' \; clear-history
# 
# # reload config file
# bind R source-file ~/.tmux.conf \; display-message "Config reloaded.."
# 
# # pane operator
# bind s splitw -v -c '#{pane_current_path}'
# bind v splitw -h -c '#{pane_current_path}'
# bind h selectp -L
# bind j selectp -D
# bind k selectp -U
# bind l selectp -R
# bind + resizep -U 10
# bind - resizep -D 10
# bind < resizep -L 10
# bind > resizep -R 10
# 
# # clipboard
# bind-key -T copy-mode-vi v send-keys -X begin-selection
# bind-key -T copy-mode-vi y send-keys -X copy-selection
# bind ] run-shell -b "win32yank.exe -o --lf | tmux load-buffer - ; tmux paste-buffer"
# 
# # fast launch
# bind t new-window htop
# bind T new-window btop
# bind g new-window -c "#{pane_current_path}" tig --all
# bind r new-window -c "#{pane_current_path}" ranger
# bind m new-window "cmatrix"
# 
# # mouse wheel simulation
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
# # ----------------------------=== Plugins ===--------------------------
# run '/usr/share/tmux-plugin-manager/tpm'        # plugin manager
# set -g @plugin 'tmux-plugins/tmux-resurrect'    # store and restore session
# 
# # ----------------------------=== Env ===--------------------------
# EDITOR=nvim
# PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
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
# export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
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
# alias glra='git pull --rebase --autostash'
# alias gsa='git submodule add'
# alias gsu='git submodule update --init --recursive'
# gsrm() {
#   set -e
#   git submodule deinit -f "$1"
#   git rm -f "$1"
#   declare TOP_LEVEL="$(git rev-parse --show-toplevel)"
#   declare DOT_GIT="$TOP_LEVEL"/.git
#   if [[ -f "$DOT_GIT" ]]; then
#     DOT_GIT="$TOP_LEVEL"/"$(sed '1s/^gitdir: //' "$DOT_GIT")"
#   fi
#   rm -fr "$DOT_GIT"/modules/"$1"
#   set +e
# }
# 
# source /usr/share/doc/fzf/examples/key-bindings.zsh
# source /usr/share/doc/fzf/examples/completion.zsh
# bindkey '^F' fzf-file-widget
# 
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# zstyle ':bracketed-paste-magic' active-widgets '.self-*'
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#606060"
# 
# export VI_MODE_SET_CURSOR=true
# bindkey -M vicmd '^L' clear-screen
# # bindkey '^L' forward-word
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
# htop_version=3.1.1-dev
# config_reader_min_version=2
# fields=2 45 48 6 5 7 4 0 3 109 110 46 47 20 49 1
# sort_key=46
# sort_direction=-1
# tree_sort_key=0
# tree_sort_direction=1
# hide_kernel_threads=1
# hide_userland_threads=1
# shadow_other_users=0
# show_thread_names=0
# show_program_path=1
# highlight_base_name=0
# highlight_deleted_exe=1
# highlight_megabytes=1
# highlight_threads=1
# highlight_changes=0
# highlight_changes_delay_secs=5
# find_comm_in_cmdline=1
# strip_exe_from_cmdline=1
# show_merged_command=0
# tree_view=1
# tree_view_always_by_pid=0
# all_branches_collapsed=0
# header_margin=1
# detailed_cpu_time=0
# cpu_count_from_one=1
# show_cpu_usage=1
# show_cpu_frequency=0
# update_process_names=0
# account_guest_in_cpu_meter=0
# color_scheme=6
# enable_mouse=1
# delay=15
# hide_function_bar=0
# header_layout=two_50_50
# column_meters_0=LeftCPUs Memory Swap
# column_meter_modes_0=1 1 1
# column_meters_1=RightCPUs Tasks LoadAverage Uptime
# column_meter_modes_1=1 2 2 2
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
# require("user.neovim").config()
#
# -- In order to disable lunarvim's default colorscheme
# lvim.colorscheme = "default"
#
# lvim.builtin.bufferline.options.always_show_bufferline = true
#
# require("user.statusline").config()
#
# require("user.alpha").config()
#
# require("user.treesitter").config()
#
# lvim.builtin.notify.active = true
# lvim.builtin.terminal.active = true
# lvim.builtin.terminal.shell = "/bin/bash"
# lvim.builtin.terminal.open_mapping = "<C-Space>"
# lvim.builtin.nvimtree.setup.view.mappings.list = {
# 	{ key = { "<Tab>" }, action = nil },
# 	{ key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
# 	{ key = "h", action = "close_node" },
# 	{ key = "v", action = "vsplit" },
# }
#
# ----------------------------------------
# -- Telescope
# ----------------------------------------
# -- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
# -- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
# local _, actions = pcall(require, "telescope.actions")
# lvim.builtin.telescope.defaults.mappings = {
# 	-- for input mode
# 	i = {
# 		["<Esc>"] = actions.close,
# 	},
# 	-- for normal mode
# 	n = {},
# }
#
# -- ---WARN: configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
# -- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
# vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })
#
# require("user.plugins").config()
#
# require("user.keybindings").config()
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
