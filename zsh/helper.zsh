# Kill background process
bgkill() {
  kill -9 $(jobs -l | head -1 | awk '{print $3}')
}

# Open localhost with given port
ol() {
  local port="$1"
  if [ -z "$port" ]; then
    open "http://localhost:3000"
  else
    open "http://localhost:${port}"
  fi
}

# Open Jira with given card id
ojr() {
  local card_id="$1"
  if [ -z "$card_id" ]; then
    open "https://employmenthero.atlassian.net/jira/software/projects/SGF/boards/455/backlog"
  else
    open "https://employmenthero.atlassian.net/browse/${card_id}"
  fi
}

# Open Google Translation
otl() {
  if [ -z "$1" ]; then
    open 'https://translate.google.com/?sl=en&tl=vi'
  else
    text="$1"
    open "https://translate.google.com/?sl=en&tl=vi&text=$text"
  fi
}

so() {
  local file=""$HOME/.config/zsh/"$1.zsh"

  if [[ -z $1 ]]; then
    source "$HOME/.zshrc"
    echo -e "\033[32m Source .zshrc completed 󱓟  \033[0m"
  else
    source "$file"
    echo -e "\033[32m Source $1.zsh completed 󱓟  \033[0m"
  fi
}

# Bitwarden unlock vault, eg: bwg username github
bwu() {
  local secret_file="$HOME/.config/zsh/secret.zsh"
  local bw_session=$(bw unlock --raw)

  if [[ -z "$bw_session" ]]; then
    return 1
  fi

  echo "\n Unlocking your vault ... 󰔟 "

  awk -v new_line="export BW_SESSION=\"$bw_session\"" '
        /^export BW_SESSION=/ { print new_line; next }
        { print }
    ' "$secret_file" >"${secret_file}.tmp" && mv "${secret_file}.tmp" "$secret_file"

  source $secret_file
  echo "\033[32m Your vault was unlocked 🔓! \033[0m"
}

# Bitwarden get data
bwg() {
  local object=$1
  local id=$2

  # Validate inputs
  if [[ -z "$object" || -z "$id" ]]; then
    echo -e "\n\033[31m Missing arguments. Usage: bwg <object> <id>\033[0m"
    return 1
  fi

  echo "\n Retrieving data from Bitwarden... 󰔟"

  # Check if user is logged in
  if ! bw status &>/dev/null; then
    echo -e "\n\033[31m Not logged in to Bitwarden. Please try to login first  \033[0m"
    return 1
  fi

  # Check if vault is locked
  local vault_status=$(bw status 2>/dev/null | jq -r '.status' 2>/dev/null)
  if [[ "$vault_status" == "locked" ]]; then
    echo -e "\n\033[31m Vault is locked. Please unlock it first  \033[0m"
    return 1
  fi

  local data=$(bw get "$object" "$id" 2>/dev/null)

  if [[ -n "$data" ]]; then
    echo "$data" | pbcopy
    echo -e "\n\033[32m Data copied to clipboard 󰅎 \033[0m"
  else
    echo -e "\n\033[31m Data not found 󱞄 \033[0m"
    return 1
  fi
}

# Kill all Zen browser processes
kaz() {
  killall "Zen"
  killall "ZenCP Isolated Web Content"
  echo -e "\033[32mClean Zen Browser  \033[0m"
}

# Kill all Chrome browser processes
kac() {
  killall "Google Chrome"
  killall "Google Chrome Helper (Renderer)"
  killall "Google Chrome Helper (GPU)"
  echo -e "\033[32mClean Google Chrome  \033[0m"
}

# Kill all Slack processes
kas() {
  killall "Slack"
  killall "Slack Helper (Renderer)"
  killall "Slack Helper (GPU)"
  echo -e "\033[32mClean Slack  \033[0m"
}
