# Create new branch based on master
function gcc() {
  git checkout master;
  git checkout -b $1;
}

# Simple commit :D
function gcm() {
  git add .;
  git commit -m $1;
  branch_name=$(git symbolic-ref --short -q HEAD);
  git push origin $branch_name;
}

function bgkill() {
  kill -9 $(jobs -l | head -1 | awk '{print $3}')
}
