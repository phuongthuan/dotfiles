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
