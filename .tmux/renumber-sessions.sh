#!/bin/bash
# two passes to avoid name collisions
i=1
for session in $(tmux list-sessions -F '#{session_name}'); do
    tmux rename-session -t "$session" "__tmp$i" 2>/dev/null
    i=$((i+1))
done
i=1
for session in $(tmux list-sessions -F '#{session_name}'); do
    tmux rename-session -t "$session" "$i" 2>/dev/null
    i=$((i+1))
done
