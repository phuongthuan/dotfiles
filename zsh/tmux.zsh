tmux_new_session() {
  local session="$1"

  if [ -z "$session" ]; then
    echo -e "\033[31mPlease provide a session name❗ \033[0m"
    return 1
  fi

  if tmux has-session -t "$session" 2>/dev/null; then
    echo -e "\033[33mTmux session '$session' already exists.\033[0m"
    return 0
  fi

  tmux new-session -s "$session" -d
  echo -e "\033[32mNew tmux session $session_name was created! \033[0m"
}
