#!/bin/sh

yarn
yarn compile

tmux new-session -d 'yarn fork'
tmux split-window -v 'ipython'
tmux split-window -h
#tmux new-window 'mutt'
#tmux -2 attach-session -d
