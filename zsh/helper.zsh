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

# Open Google Translation
otl() {
  if [ -z "$1" ]; then
    open 'https://translate.google.com/?sl=en&tl=vi'
  else
    text="$1"
    open "https://translate.google.com/?sl=en&tl=vi&text=$text"
  fi
}

# Copy content in a file to clipboard
cp_fe_pr_template() {
  cat "$(eval echo ${ICLOUD_DRIVE_OBSIDIAN_DIR})/employmenthero/fe_core_pr_template.md" | pbcopy
}

# Open ChatGPT
gpt() {
  open "https://chatgpt.com/"
}

# Open Goggle Gemini (Goggle AI)
gai() {
  open "https://gemini.google.com/gem/coding-partner"
}

so() {
  local file=""$HOME/.config/zsh/"$1.zsh"

  if [[ -z $1 ]]; then
    source "$HOME/.zshrc"
    echo -e "\033[32m Source .zshrc completed 🚀 \033[0m"
  else
    source "$file"
    echo -e "\033[32m Source $1.zsh completed 🚀 \033[0m"
  fi
}

# Bitwarden unlock vault
bwu() {
  local secret_file="$HOME/.config/zsh/secret.zsh"
  local bw_session=$(bw unlock --raw)

  if [[ -z "$bw_session" ]]; then
    return 1
  fi

  echo "\n Unlocking your vault ... ⏳"

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
    echo -e "\033[31mError: Missing arguments. Usage: bwg <object> <id>\033[0m"
    return 1
  fi

  local data=$(bw get "$object" "$id" 2>/dev/null)

  if [[ -n "$data" ]]; then
    echo "$data" | pbcopy
    echo -e "\n\033[32m Data copied to clipboard 📝\033[0m"
  else
    echo -e "\n\033[31m Data not found ❌\033[0m"
    return 1
  fi
}
