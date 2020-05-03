#!/bin/sh
tmux start-server \; \
  new-session \; \
  send-keys 'nvim $1' C-m \; \
  split-window -h -p 25 \; \
  send-keys 'ctxt' C-m
  # split-window -v -p 50 \; \
