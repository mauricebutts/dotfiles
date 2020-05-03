#!/bin/sh
cd ~/go/src/gitlab.com/glympse/enroute/org-api/
tmux start-server \; \
  new-session \; \
  split-window -h -p 50 \; \
