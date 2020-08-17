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
cp $option -vu ~/.zshrc zsh/zshrc
cp $option -vu ~/WindowsHome/AppData/Local/Packages/Microsoft.WindowsTerminal_*/LocalState/settings.json win10/settings.json
# cp $option -vu ~/WindowsHome/AppData/Roaming/alacritty/alacritty.yml alacritty/alacritty.yml
cp -frvu ~/WindowsHome/AppData/Roaming/Rime/* rime 2> /dev/null

