#!/bin/bash

if [[ -z "$1" ]] ;then
    SessionName='Routine'
else
    SessionName="$1"
fi

tmux list-sessions | grep -q $SessionName
if [[ $? == 0 ]] ;then
    exec tmux attach -t $SessionName
else
    if [[ $SessionName == "NeoVim" ]] ;then
        exec tmux new-session -s $SessionName "DARKBG=1 nvim"
    else
        exec tmux new-session -s $SessionName
    fi
fi
