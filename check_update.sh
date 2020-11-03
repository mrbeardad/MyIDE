#!/bin/bash

if [[ "$1" == "-f" ]] ;then
    option="-f"
elif [[ "$1" == "-n" ]] ;then
    option="-n"
else
    option="-i"
fi

cp $option -vu ~/.gdbinit gdb/gdbinit
cp $option -vu ~/.cgdb/cgdbrc gdb
cp $option -vu ~/.tmux.conf tmux/tmux.conf
cp $option -vu ~/.config/htop/htoprc htop/htoprc
cp $option -vu ~/.zshrc zsh/zshrc
cp $option -vu ~/WindowsHome/AppData/Local/Packages/Microsoft.WindowsTerminal_*/LocalState/settings.json WindowsTerminal/settings.json
cp $option -vu ~/WindowsHome/AppData/Roaming/Code/User/settings.json vscode
cp -frvu ~/WindowsHome/AppData/Roaming/Rime/* rime 2> /dev/null

