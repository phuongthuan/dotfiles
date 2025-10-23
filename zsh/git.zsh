export GITHUB_USERNAME="phuongthuan"

# Git
alias gj='gitmoji'
alias gs='git status -sb'
alias ga='git add .'
alias gwt='git worktree'
alias gbr='git branch'
alias gc='git commit -m'
alias gd='git diff'
alias gdn='git diff --name-only master'
alias gsw='git switch'
alias new='git switch -c'
alias glo='git log --oneline -25'
alias reflog='git reflog --relative-date'
alias del='git branch -D'
alias rsh='git reset --hard'
alias rss='git reset --soft'
alias grm='git checkout --'

alias gp='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gpm='git pull origin master'
alias gpd='git pull origin development'
alias gps='git push origin HEAD'
alias gpsm='git push origin master'
alias gpsf='git push origin HEAD --force-with-lease --no-verify'
alias gpsn='git push origin HEAD --no-verify'

alias gcl='git clone'
alias pick='git cherry-pick'
alias sts='git stash -u'
alias stl='git stash list'
alias sts='git stash save'
alias stp='git stash pop'
alias gcm='git checkout origin/master'
alias gfo='git fetch origin'
alias gcg='git config --global'
alias gh-create='gh repo create --private --source=. --remote=origin && git push -u --all && gh browse'

# GPG TTY
# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key
if ! grep -q "export GPG_TTY=\$(tty)" ~/.zshrc; then
  echo -e '\nexport GPG_TTY=$(tty)' >>~/.zshrc
fi

# Open repo by project name: github_project_url <project_name>
github_project_url() {
  if [ -z "$1" ]; then
    echo -e "\033[31mPlease provide a project name \033[0m"
    return 1
  fi
  open "$EH_GITHUB_URL/$1"
}

# Open PR: oprl <project:optional> <author:optional>
oprl() {
  if [ -z "$1" ] && [ -z "$2" ]; then # if non arguments were provided, default project and author would be frontend-core, me
    echo "Open $project's Github PR ✅"
    open "https://github.com/thinkei/${EH_DEFAULT_PROJECT}/pulls/${GITHUB_USERNAME}"
  elif [ -n $1 ] && [ -z "$2" ]; then # if project is provided but author is not
    project="$1"
    echo "Open $project's Github PR ✅ "
    open "https://github.com/thinkei/${project}/pulls/${GITHUB_USERNAME}"
  else # if all arguments were provided
    project="$1"
    author="$2"
    open "https://github.com/thinkei/${project}/pulls/${author}"
  fi
}

# Open PR ID: opr <pr_id> <author>
opr() {
  if [ -z "$1" ]; then
    recent_pr_id=$(gh pr list --state open --author phuongthuan --repo Thinkei/frontend-core --json number --jq '.[0].number')
    open "https://github.com/thinkei/frontend-core/pull/${recent_pr_id}"
  else
    project="$1"
    recent_pr_id=$(gh pr list --state open --author phuongthuan --repo "Thinkei/${project}" --json number --jq '.[0].number')
    open "https://github.com/thinkei/${project}/pull/${recent_pr_id}"
  fi
}

# Open repo: orp <repo_name>
orp() {
  # https://github.com/Thinkei/frontend-core/actions/workflows/build-dev.yml?query=actor%3Aphuongthuan
  if [ -z "$1" ]; then
    open "https://github.com/Thinkei/${EH_DEFAULT_PROJECT}"
  else
    repo_name="$1"
    open "https://github.com/Thinkei/${repo_name}"
  fi
}

# Open Run NPM release workflow: orl <env> <project_name> <branch_name>
orl() {
  if [ -z "$1" ]; then
    open "https://github.com/Thinkei/${EH_DEFAULT_PROJECT}/actions/workflows/run-npm-release.yml"
  else
    project="$1"
    open "https://github.com/Thinkei/${project}/actions/workflows/run-npm-release.yml"
  fi
}

# Open Release lib branch
orlb() {
  open "https://github.com/Thinkei/frontend-core/compare/changeset-release/master"
}

# Open main app release
opl() {
  open "https://github.com/Thinkei/${EH_MAIN_APP_PROJECT}/actions/workflows/release_pipeline.yml"
}

# Commit, Push and Open PR in defaut Browser
push_and_open_pr() {
  # Commit changes
  git commit -m "$message" --no-verify
  if [ $? -ne 0 ]; then
    echo -e "\n\033[31m❌ Commit failed, please stage the files before commit \033[0m"
    return 1
  fi

  # Push to origin
  response=$(git push origin HEAD --no-verify 2>&1)
  exit_code=$?
  if [ $exit_code -ne 0 ]; then
    echo -e "\n\033[31m❌ Push failed \033[0m"
    echo -e "\n\033[31m$response \033[0m"
    return $exit_code
  fi

  # Extract the URL from the output
  new_pr_url=$(echo "$response" | grep -oE 'https://github\.com/[^[:space:]]+/pull/new/[^[:space:]]+')

  if [ -n "$new_pr_url" ]; then
    echo "⛳ Opening PR in Browser..."
    echo -e "\033[32m$new_pr_url \033[0m"
    open "$new_pr_url"
  else
    # Open pull request of current branch
    oprb
  fi
}

# Create a commit: cgc "commit message"
cgc() {
  # Check if a commit message is provided as an argument
  if [ -z "$1" ]; then
    echo -e "\033[31mPlease provide a commit message \033[0m"
    return 1
  fi

  message="$1"
  git add .
  git commit -m "$message"
  git push origin HEAD
}

# Staged all files and create a commit and push --no-verify: cgcn "commit message"
cgcn() {
  # Use a default commit message if none is provided
  message=${1:-"chore: clean up"}

  # Staged all files
  git add .

  # Commit and Open PR
  push_and_open_pr
}

# Create a commit and push --no-verify: gcn "commit message"
ccn() {
  # Use a default commit message if none is provided
  message=${1:-"chore: clean up"}

  # Commit and Open PR
  push_and_open_pr
}

# Copy current branch name to clipboard
ccb() {
  current_branch=$(git branch --show-current)
  echo "$current_branch" | pbcopy
  echo -e "\033[32mCopied current branch to clipboard 📝 \033[0m"
}

# Create a branch and copy branch name to clipboard
cgb() {
  if [ -z "$1" ]; then
    echo -e "\033[31mPlease provide a branch name \033[0m"
    return 1
  fi

  branch_name="$1"
  git branch $branch_name
  echo "$branch_name" | pbcopy
  echo -e "\033[32mCopied branch $branch_name to clipboard 📝 \033[0m"
}

# Reset master branch
reset_master() {
  git reset --hard origin/master
  git push origin -f
}

# Clear all local branches except given branches: ex clear_all_local_branches_except "master|development"
clear_all_local_branches_except() {
  excluded_branches="$1"

  if [ -z "$excluded_branches" ]; then
    echo -e "\033[31mPlease provide a branch \033[0m"
    return 1
  fi

  git switch $excluded_branches

  # Loop through all local branches except given branches
  for branch in $(git branch --format='%(refname:short)' | grep -vE "^($excluded_branches)"); do
    echo "Deleting local branch: $branch 🟠"
    git branch -D $branch
  done
}

# Open PR: oprb <branch_name>
oprb() {
  local branch_name="$1"

  if [ -z "$branch_name" ]; then
    branch_name=$(git rev-parse --abbrev-ref HEAD)
  fi

  # Check if gh CLI is installed
  if ! command -v gh &>/dev/null; then
    echo -e "\033[31mGitHub CLI (gh) is not installed. Please install it to use this function. \033[0m"
    return 1
  fi

  # Get the PR URL using the GitHub CLI and open it in the browser
  local pr_url
  pr_url=$(gh pr view "$branch_name" --json url --jq '.url')

  if [ -n "$pr_url" ]; then
    echo "⛳ Opening PR in Browser \033[32m$pr_url \033[0m"
    open "$pr_url"
  else
    return 1
  fi
}

# Open GitHub Actions workflow
oga() {
  local workflow="$1"

  if [ -n "$workflow" ]; then
    echo -e "\033[32m📦 Opening GitHub Actions $EH_MOBILE_PRO_REPO workflow: $workflow \033[0m"
    open "https://github.com/Thinkei/$EH_MOBILE_PRO_REPO/actions/workflows/$workflow"
  else
    echo -e "\033[31mPlease enter workflow name \033[0m"
    return 1
  fi
}

sta() {
  local index=${1:-0} # Default index is 0 if not provided
  echo -e "\n\033[32mApplying stash $index... \033[0m\n"
  git stash apply stash@{$index}
}
