#!/bin/bash

function backup() {
    if [[ -z "$1" ]] ;then
        echo -e "\033[31mError: backup() required one parameter\033[m"
        exit 1
    elif [[ -e "$1" ]] ;then
        mv "$1" "$1".bak
    fi
}

function makedir() {
    if [[ -z "$1" ]] ;then
        echo -e "\033[31mError: makedir() required one parameter\033[m"
        exit 1
    elif [[ ! -d "$1" ]] ;then
        if [[ -e "$1" ]] ;then
            mv "$1" "$1".bak
        fi
        mkdir -p "$1"
    fi
}

# sudoers
echo '=========> Modifing /etc/sudoers ...'
echo '%sudo   ALL=(ALL:ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers

# apt repo
echo '=========> Modifing /etc/apt/sources.list ...'
echo 'deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
#deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
#deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
#deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
#deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse' | sudo tee /etc/apt/sources.list
sudo apt clean
sudo apt update
sudo apt upgrade

# download tools
sudo apt install python3-pynvim neovim vim cmake ctags global silversearcher-ag ripgrep
sudo apt install npm php shellcheck zip
sudo apt install gcc clang clang-tidy cppcheck gdb cgdb libboost-dev mariadb-client mariadb-server libmysql++-dev mycli
sudo apt install tmux zsh zsh-syntax-highlighting zsh-autosuggestions autojump
sudo apt install thefuck fzf ranger ncdu htop iotop dstat cloc screenfetch figlet cmatrix python3-pip 
pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple
pip3 install cppman gdbgui

# vim config
echo '=========> Installing configuration for vim/nvim ...'
backup ~/.SpaceVim
git clone https://gitee.com/mrbeardad/SpaceVim ~/.SpaceVim

makedir ~/.config
backup ~/.config/nvim
ln -s ~/.SpaceVim ~/.config/nvim

makedir ~/.SpaceVim.d
backup ~/.SpaceVim.d/init.toml
cp -v ~/.SpaceVim/mode/init.toml ~/.SpaceVim.d

makedir ~/.local/bin
g++ -O3 -std=c++17 -o ~/.local/bin/quickrun_time ~/.SpaceVim/custom/quickrun_time.cpp
cp -v ~/.SpaceVim/custom/vim-quickrun.sh ~/.local/bin

curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
mv /tmp/win32yank.exe ~/.local/bin

# zsh config
echo '=========> Installing configuration for zsh ...'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp zsh/*theme ~/.oh-my-zsh/themes
backup ~/.zshrc
cp -v zsh/zshrc ~/.zshrc

# tmux config
echo '=========> Installing configuration for tmux ...'
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux-resurrect
backup ~/.tmux.conf
cp -v tmux/tmux ~/.tmux.conf

# ranger config
echo '=========> Installing configuration for ranger ...'
backup ~/.config/ranger
cp -rv ranger ~/.config/ranger

# ssh config
makedir ~/.ssh
cat ssh/ssh_config >> ~/.ssh/ssh_config
cp .gitconfig ~
sudo cp -v ssh/sshd_config /etc/ssh/sshd_config

# cli config
sudo cp -v bin/terminal-tmux.sh /usr/local/bin
backup ~/.cheat
dotfiles_dir=$PWD
export dotfiles_dir
git clone https://gitee.com/mrbeardad/learning-notes-and-cheat-sheets ~/.cheat
g++ -O3 -std=c++17 -o ~/.local/bin/see ~/.cheat/see.cpp 
makedir ~/.cache/cppman/cplusplus.com
(
    cd /tmp || exit 1
    tar -zxf "$dotfiles_dir"/cppman/cppman_db.tar.gz
    cp -vn cplusplus.com/* ~/.cache/cppman/cplusplus.com
)
backup ~/.gdbinit
cp -v gdb/gdbinit ~/.gdbinit
makedir ~/.cgdb
backup ~/.cgdb/cgdbrc
cp -v gdb/cgdbrc ~/.cgdb

# links
echo '=========> Creating links to access Windows easily ...'
for inUserDir in $(find /mnt/c/Users -maxdepth 1 -not -iregex '/mnt/c/Users/\(all users\|default\|default user\|public\)' | sed '1d') ;do
    if [[ -d "$inUserDir" ]] ;then
        Dir=$inUserDir
        break;
    fi
done
ln -vs "$Dir" ~/WindowsHome
ln -vs "$Dir/Documents" ~/Documents
ln -vs "$Dir/Downloads" ~/Downloads
