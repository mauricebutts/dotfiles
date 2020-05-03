#!/bin/sh
cd ~/go/src/gitlab.com/glympse/
tmux start-server \; \
  new-session \; \
  send-keys 'nvim $1' C-m \; \
  split-window -h -p 25 \; \
  # split-window -v -p 50 \; \
