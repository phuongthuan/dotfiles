alias vim='/usr/bin/vim'
alias nn='NVIM_APPNAME="nvim-new" nvimv exec nightly'

alias arm='arch -arm64'
alias intel='arch -x86_64'

alias rv='ruby -v'
alias nv='node -v'
alias lv='lua -v'

# opencode
alias oc='opencode'

# Open iCloud Drive
alias ic='eval nvim $ICLOUD_DRIVE'

# Open iCloud Obsidian
alias obs='eval nvim $ICLOUD_DRIVE_OBSIDIAN_DIR'

# Open dotfiles
alias dot='cd ~/.dotfiles/ && nvim'

alias c='clear'
alias e='exit'
alias op='open'
alias db='defaultbrowser'

# brew
alias br='brew'
alias brup='brew update; brew upgrade; brew cleanup; brew doctor'
alias bri='brew install'
alias bru='brew uninstall'
alias brsl='brew services list'
alias brs='brew services'
alias brd='brew doctor'

# tmux
alias t='tmux'
alias ta='tmux attach -t'
alias cc='clear && tmux clear-history'

# ruby
alias bi='bundle install'
alias be='bundle exec'
alias rub='bundle exec rubocop'
alias rsp='bundle exec rspec'

# docker
# alias dps='docker ps -a'
# alias ds='docker stop'
# alias drm='docker rm'
# alias drmi='docker rmi'
# alias dl='docker logs'
# alias di='docker inspect'
# alias drM='docker container prune -f'
# alias dc='docker-compose'

# npm
alias ni='npm install'
alias ns='npm start'

# yarn
alias yv='yarn --version'
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

# crypto coin tracker
alias btc='curl rate.sx'
