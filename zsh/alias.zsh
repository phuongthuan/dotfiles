alias vi="nvim"
alias reload="source ~/.zshrc"

# I'm lazy, sorry :(
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
alias p="cd ~/Programming"
alias d="cd ~/Desktop"
alias dl="cd ~/Downloads"

# Tmux
alias t="tmux"
alias ta="tmux attach -t"

# Git ;)
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git commit -m '
alias gca='git add . && git commit --amend --no-edit'
alias gd='git diff'
alias sw='git checkout'
alias log='git log'
alias glo='git log --oneline'
alias reflog='git reflog --relative-date'
alias del='git branch -D'
alias rsh='git reset --hard'
alias rss='git reset --soft'
alias grm='git checkout --'
alias pull='git pull origin HEAD'
alias pullm='git pull origin master'
alias push='git push origin HEAD'
alias pushm='git push origin master'
alias pushf='git push origin HEAD -f'
alias gcl='git clone '
alias pick='git cherry-pick '
alias grn='git branch -m '
