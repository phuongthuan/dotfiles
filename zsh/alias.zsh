alias nvim='~/nvim-macos/bin/nvim'

# Source zshrc
alias reload="source ~/.zshrc; echo 'Source zshrc complete!';"

# Open EH config
alias ehconf='nvim ~/.config/zsh/eh.zsh'

# Open dotfiles
alias dot='nvim ~/.dotfiles'

# Homebrew
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
alias bl='brew services list'
alias bs='brew services'
alias bd='brew doctor'

# I'm lazy, sorry :(
alias p='cd ~/Programming'
alias d='cd ~/Desktop'
alias dl='cd ~/Downloads'

# Tmux
alias t='tmux'
alias ta='tmux attach -t'

# How do I ....
alias how='howdoi'

# Ruby
alias bi='bundle install'
alias be='bundle exec'

# Gitmoji
alias gj='gitmoji'

# Git ;)
alias gs='git status -sb'
alias ga='git add'
alias gw='git worktree'
alias gb='git branch'
alias gc='git commit -m'
alias gd='git diff'
alias sw='git checkout'
alias swm='git checkout master && git pull origin master'
alias new='git checkout -b'
alias glo='git log --oneline -10'
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
alias gcl='git clone'
alias pick='git cherry-pick'
alias stl='git stash list'
alias pop='git stash pop'

# Docker
alias dps='docker ps -a'
alias ds='docker stop'
alias drm='docker rm'
alias drmi='docker rmi'
alias dl='docker logs'
alias di='docker inspect'
alias drM='docker container prune -f'

alias dc='docker-compose'
