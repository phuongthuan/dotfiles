# # GPG TTY
# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key
if ! grep -q "export GPG_TTY=\$(tty)" ~/.zshrc; then
  echo -e '\nexport GPG_TTY=$(tty)' >>~/.zshrc
fi

# Open repo by project name: github_project_url <project_name>
github_project_url() {
  if [ -z "$1" ]; then
    echo "Please provide a project name 🔴"
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

# Open workflows: oga <env> <project_name> <branch_name>
# oga() {
#   if [ -z "$1" ]; then
#     open "https://github.com/Thinkei/${EH_DEFAULT_PROJECT}/actions/workflows/build-sandbox--hr-web-app.yml?query=actor%3Aphuongthuan"
#   else
#     project="$1"
#     open "https://github.com/Thinkei/${project}/actions/workflows/build-sandbox--hr-web-app.yml?query=actor%3Aphuongthuan"
#   fi
# }

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

  # Push to origin
  response=$(git push origin HEAD --no-verify 2>&1)

  # Extract the URL from the output
  url=$(echo "$response" | grep -oE 'https://github\.com/[^[:space:]]+/pull/new/[^[:space:]]+')

  echo "⛳ Opening PR in Browser..."
  echo -e "\033[32m$url \033[0m"

  # Open the URL in the default browser if it exists
  [ -n "$url" ] && open "$url"
}

# Create a commit: cgc "commit message"
cgc() {
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
  echo "Copied current branch to clipboard 📝"
}

# Create a branch and copy branch name to clipboard
cgb() {
  if [ -z "$1" ]; then
    echo "Please provide a branch name 🔴"
    return 1
  fi

  branch_name="$1"
  git branch $branch_name
  echo "$branch_name" | pbcopy
  echo "Copied branch '$branch_name' to clipboard 📝"
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
oprb() {
  local branch_name="$1"

  if [ -z "$branch_name" ]; then
    branch_name=$(git rev-parse --abbrev-ref HEAD)
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

# Open GitHub Actions workflow
oga() {
  local workflow="$1"

  if [ -n "$workflow" ]; then
    echo "📦 Opening GitHub Actions talent-marketplace-app workflow: $workflow"
    open "https://github.com/Thinkei/talent-marketplace-app/actions/workflows/$workflow"
  else
    echo "Please enter workflow name"
    return 1
  fi
}

# Running linter in given directory (default dir is apps/hr-web-app)
# fe_test <directory>
#
# fe_test apps/hr-web-app
# fe_test libs/eh-marketing-ui
fe_lint() {

  # Use the provided argument or default to 'apps/hr-web-app'
  directory=${1:-apps/hr-web-app}

  # Extract 'hr-web-app' from 'apps/hr-web-app'
  app_name=$(basename "$directory")

  echo "Start linting on $app_name 🧪"

  executed_files=$(
    # Lists all files that have been added, modified, copied, renamed, or had type changes compared to the master branch.
    git diff --name-only --diff-filter=ACMRT master |
      grep "^$directory/" |          # Filter all files that start with a directory (eg: apps/hr-web-app)
      grep -E '\.(js|jsx|ts|tsx)$' | # Only included js,jsx,ts,tsx file
      sed "s|$directory/||"          # Remove path directory (eg: apps/hr-web-app)
  )

  if [[ -n "$executed_files" ]]; then
    yarn nx lint:ci $app_name $(echo "$executed_files" | xargs)
  else
    echo "No matching files to lint 🔴"
  fi
}

# Running unit test on given directory (default dir is apps/hr-web-app)
# fe_test <directory>
#
# fe_test apps/hr-web-app
# fe_test libs/eh-marketing-ui
fe_test() {

  # Use the provided argument or default to 'apps/hr-web-app'
  directory=${1:-apps/hr-web-app}

  # Extract 'hr-web-app' from 'apps/hr-web-app'
  app_name=$(basename "$directory")

  echo "Start testing on $app_name 🧪"

  executed_files=$(
    # Lists all files that have been added, modified, copied, renamed, or had type changes compared to the master branch.
    git diff --name-only --diff-filter=ACMRT master |
      grep "^$directory/" |                       # Filter all files that start with a directory (eg: apps/hr-web-app)
      grep -E '\.(spec|test)\.(js|jsx|ts|tsx)$' | # Only included test files
      sed "s|$directory/||"                       # Remove path directory (eg: apps/hr-web-app)
  )

  if [[ -n "$executed_files" ]]; then
    yarn nx test:ci $app_name $(echo "$executed_files" | xargs) --skip-nx-cache
  else
    echo "No matching files to test 🔴"
  fi
}
