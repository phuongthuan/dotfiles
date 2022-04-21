# Simple commit :D
function gcm() {
  git add .;
  git commit -m $1;
  branch_name=$(git symbolic-ref --short -q HEAD);
  git push origin $branch_name;
}

# Kill background process
function bgkill() {
  kill -9 $(jobs -l | head -1 | awk '{print $3}')
}
