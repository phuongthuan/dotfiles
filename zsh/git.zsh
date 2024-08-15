# # GPG TTY
# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key
if ! grep -q "export GPG_TTY=\$(tty)" ~/.zshrc; then
  echo -e '\nexport GPG_TTY=$(tty)' >>~/.zshrc
fi

# Open repo by project name: github_project_url <project_name>
function github_project_url() {
  if [ -z "$1" ]; then
    echo "Please provide a project name 🔴"
    return 1
  fi
  echo "$EH_GITHUB_URL/$1"
}

# Open PR: oprl <project:optional> <author:optional>
function oprl() {
  if [ -z "$1" ] && [ -z "$2" ]; then # if non arguments were provided, default project and author would be frontend-core, me
    echo "Open $project's Github PR ✅"
    open "https://github.com/thinkei/${EH_DEFAULT_PROJECT}/pulls/${GITHUB_USERNAME}"
  elif [ -n $1 ] && [ -z "$2" ]; then # if project is provided but author is not
    project="$1"
    echo "Open $project's Github PR "
    open "https://github.com/thinkei/${project}/pulls/${GITHUB_USERNAME}"
  else # if all arguments were provided
    project="$1"
    author="$2"
    open "https://github.com/thinkei/${project}/pulls/${author}"
  fi
}

# Open PR ID: opr <pr_id> <author>
function opr() {
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
function orp() {
  # https://github.com/Thinkei/frontend-core/actions/workflows/build-dev.yml?query=actor%3Aphuongthuan
  if [ -z "$1" ]; then
    open "https://github.com/Thinkei/${EH_DEFAULT_PROJECT}"
  else
    repo_name="$1"
    open "https://github.com/Thinkei/${repo_name}"
  fi
}

# Open workflows: oga <env> <project_name> <branch_name>
function oga() {
  if [ -z "$1" ]; then
    open "https://github.com/Thinkei/${EH_DEFAULT_PROJECT}/actions/workflows/build-sandbox--hr-web-app.yml?query=actor%3Aphuongthuan"
  else
    project="$1"
    open "https://github.com/Thinkei/${project}/actions/workflows/build-sandbox--hr-web-app.yml?query=actor%3Aphuongthuan"
  fi
}

# Open Run NPM release workflow: orl <env> <project_name> <branch_name>
function orl() {
  if [ -z "$1" ]; then
    open "https://github.com/Thinkei/${EH_DEFAULT_PROJECT}/actions/workflows/run-npm-release.yml"
  else
    project="$1"
    open "https://github.com/Thinkei/${project}/actions/workflows/run-npm-release.yml"
  fi
}

# Open main app release
function opl() {
  open "https://github.com/Thinkei/${EH_MAIN_APP_PROJECT}/actions/workflows/release_pipeline.yml"
}

# Create a commit: cgc "commit message"
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

# Create a commit and push --no-verify: cgcn "commit message"
function cgcn() {
  # Check if a commit message is provided as an argument
  if [ -z "$1" ]; then
    git add .
    git commit -m "chore: clean up"
    git push origin HEAD --no-verify
  else
    message="$1"
    git add .
    git commit -m "$message"
    git push origin HEAD --no-verify
  fi
}

# Copy current branch name to clipboard
function ccb() {
  current_branch=$(git branch --show-current)
  echo "$current_branch" | pbcopy
  echo "Copied current branch to clipboard 📝"
}

# Create a branch and copy branch name to clipboard
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
  git switch "$branch_name"
  git pull origin "$branch_name"
}

# Reset master branch
function reset_master() {
  git reset --hard origin/master
  git push origin -f
}

# Clear all local branches except given branches: ex clear_all_local_branches_except "master|development"
function clear_all_local_branches_except() {
  excluded_branches="$1"

  if [ -z "$excluded_branches" ]; then
    echo "Please provide a branch 🔴"
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
function oprb() {
  local branch_name="$1"

  if [ -z "$branch_name" ]; then
    echo "Branch name is required"
    return 1
  fi

  # Check if gh CLI is installed
  if ! command -v gh &>/dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it to use this function."
    return 1
  fi

  # Get the PR URL using the GitHub CLI and open it in the browser
  local pr_url
  pr_url=$(gh pr view "$branch_name" --json url --jq '.url')

  if [ -n "$pr_url" ]; then
    echo "Opening PR: $pr_url"
    open "$pr_url"
  else
    echo "No PR found for branch '$branch_name'"
    return 1
  fi
}
