# Kill background process
function bgkill() {
  kill -9 $(jobs -l | head -1 | awk '{print $3}')
}

# Open Github PR
function mypr() {
  open https://github.com/thinkei/frontend-core/pulls/phuongthuan
}

