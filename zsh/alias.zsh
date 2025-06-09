alias vim='/usr/bin/vim'
alias vi='~/nvim-0.11.2/bin/nvim'
alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" vi'

alias arm='arch -arm64'
alias intel='arch -x86_64'

alias rv='ruby -v'
alias nv='node -v'
alias lv='lua -v'

alias ni='npm install'
alias ns='npm start'

# Kill all node process
alias nka='killall node && killall eslint_d && killall prettierd; echo ' Killed all node processes 🚀';'

# Open iCloud Drive
alias ic='eval vi $ICLOUD_DRIVE'

# Open iCloud Obsidian
alias obs='eval vi $ICLOUD_DRIVE_OBSIDIAN_DIR'

# Open dotfiles
alias dot='cd ~/.dotfiles/ && vi'

alias c='clear'
alias e='exit'

# Binding zoxide to j - because I'm the autojump user :)
alias j='z'

# Homebrew
alias br='brew'
alias brup='brew update; brew upgrade; brew cleanup; brew doctor'
alias bri='brew install'
alias bru='brew uninstall'
alias brsl='brew services list'
alias brs='brew services'
alias brd='brew doctor'

# Tmux
alias t='tmux'
alias ta='tmux attach -t'

# How do I ....
alias how='howdoi'

# Ruby
alias bi='bundle install'
alias be='bundle exec'
alias rub='bundle exec rubocop'
alias rsp='bundle exec rspec'

# Gitmoji
alias gj='gitmoji'

# Git ;)
alias gs='git status -sb'
alias ga='git add .'
alias gw='git worktree'
alias gb='git branch'
alias gc='git commit -m'
alias gd='git diff'
alias gdn='git diff --name-only master'
alias sw='git switch'
alias new='git switch -c'
alias glo='git log --oneline -10'
alias reflog='git reflog --relative-date'
alias del='git branch -D'
alias rsh='git reset --hard'
alias rss='git reset --soft'
alias grm='git checkout --'

alias gp='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gpm='git pull origin master'
alias gpd='git pull origin development'
alias gps='git push origin HEAD'
alias gpsm='git push origin master'
alias gpsf='git push origin HEAD -f'
alias gpsn='git push origin HEAD --no-verify'

alias gcl='git clone'
alias pick='git cherry-pick'
alias sts='git stash -u'
alias stl='git stash list'
alias stp='git stash pop'
alias gcm='git checkout origin/master'
alias gmm='git merge master'
alias gfo='git fetch origin'
alias gcg='git config --global'
alias gh-create='gh repo create --private --source=. --remote=origin && git push -u --all && gh browse'

# Docker
# alias dps='docker ps -a'
# alias ds='docker stop'
# alias drm='docker rm'
# alias drmi='docker rmi'
# alias dl='docker logs'
# alias di='docker inspect'
# alias drM='docker container prune -f'
# alias dc='docker-compose'

# Yarn
alias yd='yarn dev'
alias ys='yarn start'
alias yt='yarn test'
alias yi='yarn install'
alias yb='yarn build'
alias yp='yarn pack'
alias yl='yarn link'
alias yx='yarn nx'

alias xc='xcrun simctl'
alias xcl='xcrun simctl list devices'
alias xcb='xcrun simctl boot 6790E0DD-55BB-42CA-97D2-7239DEF37A78'
alias xcs='xcrun simctl shutdown 6790E0DD-55BB-42CA-97D2-7239DEF37A78'

# Bitwarden CLI
alias bwf='bw list items --search'
alias bwd='bw delete item'
alias bws='bw sync'
