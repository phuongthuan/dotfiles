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
