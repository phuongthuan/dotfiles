# Kill background process
function bgkill() {
  kill -9 $(jobs -l | head -1 | awk '{print $3}')
}

# Open Github repo by project name: github_project_url <project_name>
function github_project_url() {
  if [ -z "$1" ]; then
    echo "Please provide a project name 🔴"
    return 1
  fi
  echo "$EH_GITHUB_URL/$1"
}

# Open Github PR: oprl <project_name>
function oprl() {
  if [ -z "$1" ]; then
    open 'https://github.com/thinkei/frontend-core/pulls/phuongthuan'
  else
    project="$1"
    open "https://github.com/thinkei/${project}/pulls/phuongthuan"
  fi
}

# Open Github PR ID: opr <pr_id> <author>
function opr() {

  # if [ -z "$1" ] || [ -z "$2" ]; then
  #   recent_pr_id=$(gh pr list --state open --author phuongthuan --repo Thinkei/frontend-core --json number --jq '.[0].number')
  #   open "https://github.com/thinkei/frontend-core/pull/${recent_pr_id}"
  # fi

  if [ -z "$1" ]; then
    recent_pr_id=$(gh pr list --state open --author phuongthuan --repo Thinkei/frontend-core --json number --jq '.[0].number')
    open "https://github.com/thinkei/frontend-core/pull/${recent_pr_id}"
  else
    project="$1"
    recent_pr_id=$(gh pr list --state open --author phuongthuan --repo "Thinkei/${project}" --json number --jq '.[0].number')
    open "https://github.com/thinkei/${project}/pull/${recent_pr_id}"
  fi
}

# Open Github repo: orp <repo_name>
function orp() {
  # https://github.com/Thinkei/frontend-core/actions/workflows/build-dev.yml?query=actor%3Aphuongthuan
  if [ -z "$1" ]; then
    open 'https://github.com/Thinkei/frontend-core'
  else
    repo_name="$1"
    open "https://github.com/Thinkei/${repo_name}"
  fi
}

# Open Circle CI: oci <project_name> <branch_name>
function oci() {
  # https://github.com/Thinkei/frontend-core/actions/workflows/build-dev.yml?query=actor%3Aphuongthuan
  if [ -z "$1" ]; then
    open 'https://app.circleci.com/pipelines/github/Thinkei?filter=mine'
  else
    project="$1"
    open "https://app.circleci.com/pipelines/github/Thinkei/${project}?filter=mine"
  fi
}

# Open Github Actions workflows: oga <env> <project_name> <branch_name>
function oga() {
  if [ -z "$1" ]; then
    open 'https://github.com/Thinkei/frontend-core/actions/workflows/build-sandbox--hr-web-app.yml?query=actor%3Aphuongthuan'
  else
    project="$1"
    open "https://github.com/Thinkei/${project}/actions/workflows/build-sandbox--hr-web-app.yml?query=actor%3Aphuongthuan"
  fi
}

# Open main app release
function opl() {
  open "https://github.com/Thinkei/employment-hero/actions/workflows/release_pipeline.yml"
}

# Simple Git commit: mygcm "commit message"
function cgc() {
  # Check if a commit message is provided as an argument
  if [ -z "$1" ]; then
    echo "Please provide a commit message 🔴"
    return 1
  fi

  message="$1"
  git add .
  git commit -m "$message"
  git push origin HEAD
}

# Create new branch and copy branch name to clipboard
function cgb() {
  if [ -z "$1" ]; then
    echo "Please provide a branch name 🔴"
    return 1
  fi

  branch_name="$1"
  git branch $branch_name
  echo "$branch_name" | pbcopy
  echo "Copied branch '$branch_name' to clipboard 📝"
}

# Checkout and pull current master branch
function swm() {
  branch_name=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

  if [ -z "$branch_name" ]; then
    echo "Error: No branch name found 🔴"
    return 1
  fi

  echo "Switching to branch: $branch_name"
  git checkout "$branch_name"
  git pull origin "$branch_name"
}

# Clear all local branches except given branches: ex clear_all_local_branches_except "master|development"
function clear_all_local_branches_except() {
  excluded_branches="$1"

  if [ -z "$excluded_branches" ]; then
    echo "Please provide a branch 🔴"
    return 1
  fi

  git checkout $excluded_branches

  # Loop through all local branches except given branches
  for branch in $(git branch --format='%(refname:short)' | grep -vE "^($excluded_branches)"); do
    echo "Deleting local branch: $branch 🟠"
    git branch -D $branch
  done
}

function yt_dl() {
  if [ -z "$1" ]; then
    echo "Please provide a Youtube video URL 🔴"
    return 1
  fi
  yt-dlp --extract-audio --audio-format mp3 "$1"
}

function mp() {
  if [ -z "$1" ]; then
    echo "Please provide a playlist 🔴"
    return 1
  fi
  mpc load "$1" && mpc play
}

function mppl() {
  if [ -z "$1" ]; then
    mpc lsplaylists
    return 1
  else
    mpc playlist -f "%title%" "$1"
  fi
}
