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

# Kill background process
function bgkill() {
  kill -9 $(jobs -l | head -1 | awk '{print $3}')
}

# Change cursor color in vi-mode
function cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}
cursor_mode
