#!/bin/bash
current=$(tmux display-message -p '#S')

tmux list-sessions -F '#{session_name}' | while read session; do
    windows=$(tmux list-windows -t "$session" -F '#{window_name}' | tr '\n' ' ')
    if [ "$session" = "$current" ]; then
        printf '#[bg=colour4,fg=colour0,bold] %s: %s#[default]' "$session" "$windows"
    else
        printf '#[fg=colour0,bg=default] %s: %s#[default]' "$session" "$windows"
    fi
done
