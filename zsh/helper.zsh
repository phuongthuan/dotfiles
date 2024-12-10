# Kill background process
bgkill() {
  kill -9 $(jobs -l | head -1 | awk '{print $3}')
}

# Search a string in a directory
ssd() {
  local search_string="$1"
  local directory_path="$2"

  if [ -z "$search_string" ]; then
    echo "Please provide a search string 🔴"
    return 1
  fi

  grep -r --exclude-dir={node_modules} --exclude=yarn.lock --exclude=package-lock.json "$search_string" "$directory_path"
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

# Open Circle CI: oci <project_name> <branch_name>
oci() {
  # https://github.com/Thinkei/frontend-core/actions/workflows/build-dev.yml?query=actor%3Aphuongthuan
  if [ -z "$1" ]; then
    open 'https://app.circleci.com/pipelines/github/Thinkei?filter=mine'
  else
    project="$1"
    open "https://app.circleci.com/pipelines/github/Thinkei/${project}?filter=mine"
  fi
}

# Open Expo Dev: oxp <project_name>
oxp() {
  if [ -z "$1" ]; then
    open 'https://expo.dev/accounts/employmentos/projects/talent-marketplace-app/builds'
  else
    project="$1"
    open "https://expo.dev/accounts/employmentos/projects/${project}/builds"
  fi
}

# Open main app release
opl() {
  open "https://github.com/Thinkei/${EH_MAIN_APP_PROJECT}/actions/workflows/release_pipeline.yml"
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
