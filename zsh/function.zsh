# Kill background process
function bgkill() {
  kill -9 $(jobs -l | head -1 | awk '{print $3}')
}

# Open Github PR: mypr <project_name>
function opr() {
  if [ -z "$1" ]; then
    open 'https://github.com/thinkei/frontend-core/pulls/phuongthuan'
  else
    project="$1"
    open "https://github.com/thinkei/${project}/pulls/phuongthuan"
  fi
}

# Open Circle CI: myci <project_name>
function oci() {
  if [ -z "$1" ]; then
    open 'https://app.circleci.com/pipelines/github/Thinkei?filter=mine'
  else
    project="$1"
    open "https://app.circleci.com/pipelines/github/Thinkei/${project}?filter=mine"
  fi
}

function opl() {
  open "https://github.com/Thinkei/employment-hero/actions/workflows/release_pipeline.yml"
}

# Simple Git commit: mygcm "commit message"
function cgc() {
  # Check if a commit message is provided as an argument
  if [ -z "$1" ]; then
    echo "Please provide a commit message."
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
    echo "Please provide a branch name."
    return 1
  fi

  branch_name="$1"
  git branch $branch_name
  echo "$branch_name" | pbcopy
  echo "Copied branch '$branch_name' to clipboard."
}

# Checkout and pull current master branch
function swm() {
  branch_name=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

  if [ -z "$branch_name" ]; then
    echo "Error: No branch name found."
    return 1
  fi

  echo "Switching to branch: $branch_name"
  git checkout "$branch_name"
  git pull origin "$branch_name"
}
