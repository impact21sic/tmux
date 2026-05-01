#!/usr/bin/env bash
cur_name="$1"

mapfile -t sessions < <(tmux list-sessions -F '#{session_name}')
count=${#sessions[@]}

if [ "$count" -le 1 ]; then
  tmux kill-server
  exit
fi

for i in "${!sessions[@]}"; do
  [ "${sessions[$i]}" = "$cur_name" ] && cur_pos=$i && break
done

if [ "$cur_pos" -gt 0 ]; then
  tmux switch-client -t "${sessions[$((cur_pos - 1))]}"
elif [ "$((cur_pos + 1))" -lt "$count" ]; then
  tmux switch-client -t "${sessions[$((cur_pos + 1))]}"
else
  tmux kill-server
fi

tmux kill-session -t "$cur_name"
