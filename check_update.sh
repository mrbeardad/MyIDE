#!/bin/bash

if [[ "$1" == "-f" ]] ;then
    option="-f"
elif [[ "$1" == "-n" ]] ;then
    option="-n"
else
    option="-i"
fi

cp $option -vu ~/.gdbinit gdb/gdbinit
cp $option -vu ~/.config/htop/htoprc htop/htoprc
cp $option -vu ~/.ssh/ssh_config ssh/ssh_config
cp $option -vu ~/.tmux.conf tmux/tmux.conf
cp $option -vu ~/.zshrc zsh/zshrc
cp $option -vu ~/.vscode-neovim/init.vim vscode/vscode-neovim/init.vim
