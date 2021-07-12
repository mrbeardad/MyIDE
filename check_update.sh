#!/bin/bash

if [[ "$1" == "-f" ]] ;then
    option="-f"
elif [[ "$1" == "-n" ]] ;then
    option="-n"
else
    option="-i"
fi

cp $option -vu ~/.tmux.conf tmux/tmux.conf
cp $option -vu ~/.zshrc zsh/zshrc
cp $option -vu ~/.gdbinit gdb/gdbinit
cp $option -vu ~/.cgdb/cgdbrc gdb
cp $option -vu ~/.config/htop/htoprc htop/htoprc

