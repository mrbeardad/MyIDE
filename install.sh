#!/bin/bash
# 设置为WSL2（PowerShell）
wsl --set-version Arch2 2

# 添加普通用户
useradd -m beardad -G wheel
passwd beardad
visudo

# 设置默认用户（PowerShell）
.\Arch.exe config --default-user beardad


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

# 配置pacman
sudo sed -i '/^#\[multilib\]$/{s/#//; n; s/^#//}; /^#Color$/s/#//; /^SigLevel/s/=.*$/= Never/;' /etc/pacman.conf
sudo sed -i '/^Include = \/etc\/pacman.d\/mirrorlist$/s/.*/Server = https:\/\/mirrors.cloud.tencent.com\/archlinux\/$repo\/os\/$arch/' /etc/pacman.conf
if grep -q '\[archlinuxcn\]' /etc/pacman.conf ; then
    echo -e '[archlinuxcn]\nServer = https://mirrors.cloud.tencent.com/archlinuxcn/$arch' | sudo tee -a /etc/pacman.conf > /dev/null
fi

# 设置并更新系统
sudo sed -i '/\[Journal\]/a\SystemMaxUse=100M' /etc/systemd/journald.conf
sudo pacman -Syyu

# 下载pacman周边
sudo pacman -S yay expac paccache-hook
sudo systemctl enable --now paccache.timer

# 搭建开发环境
yay -S base-devel neovim python-pynvim cmake ctags global silver-searcher-git ripgrep \
    npm php markdown2ctags shellcheck cppcheck clang gdb cgdb boost mariadb mysql++

git clone https://gitee.com/mrbeardad/SpaceVim ~/.SpaceVim
ln -sfv ~/.SpaceVim ~/.config/nvim
mkdir ~/.SpaceVim.d
cp -v ~/.SpaceVim/mode/init.toml ~/.SpaceVim.d

mkdir -p ~/.local/bin
g++ -O3 -DNDEBUG -std=c++17 -o ~/.local/bin/quickrun_time ~/.SpaceVim/custom/quickrun_time.cpp
cp -v ~/.SpaceVim/custom/vim-quickrun.sh ~/.local/bin/

curl -Lo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
yay -S zip unzip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
mv -v /tmp/win32yank.exe ~/.local/bin

cp -v gdb/gdbinit ~/.gdbinit
mkdir ~/.cgdb/
cp -v gdb/cgdbrc ~/.cgdb

# GIT & SSH
cp -v .gitconfig ~
mkdir ~/.ssh
cat ssh/ssh_config >> ~/.ssh/ssh_config

yay -S openssh
sudo cp -fv ssh/sshd_config /etc/sshd_config
sudo systemctl enable --now sshd

# ZSH
yay -S zsh oh-my-zsh-git autojump zsh-syntax-highlighting zsh-autosuggestions
cp -v zsh/zshrc ~/.zshrc
sudo cp zsh/agnoster-time.zsh-theme /usr/share/oh-my-zsh/themes/
chsh -s /bin/zsh

# TMUX
yay -S tmux tmux-resurrect-git
cp -v tmux/tmux.conf ~/.tmux.conf
sudo cp -v bin/terminal-tmux.sh /usr/local/bin

# 其他CLI工具
yay -S man tree fzf ranger ncdu gtop htop iotop dstat cloc screenfetch figlet cmatrix python-pip
pip config set global.index-url https://mirrors.cloud.tencent.com/pypi/simple
pip install cppman gdbgui thefuck
cp -vr ranger ~/.config/ranger

# Cheat Sheets
git clone https://gitee.com/mrbeardad/learning-notes-and-cheat-sheets ~/.cheat
g++ -O3 -DNDEBUG -std=c++17 -o ~/.local/bin/see ~/.cheat/see.cpp

# xdg-open
yay -S xdg-utils wslu
sudo ln -sv /bin/wslview /bin/www-browser
