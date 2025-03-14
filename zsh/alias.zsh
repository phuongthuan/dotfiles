alias nvim='~/nvim-macos-arm64/bin/nvim'
alias lz='NVIM_APPNAME="lazyvim" ~/nvim-macos-arm64/bin/nvim'
alias nks='NVIM_APPNAME="kickstart-nvim" ~/nvim-macos-arm64/bin/nvim'

alias arm="arch -arm64"
alias intel="arch -x86_64"

alias rv="ruby -v"
alias nv="node -v"
alias ni="npm install"
alias ns="npm start"

# Kill all node process
alias nka="killall node && killall eslint_d && killall prettierd; echo ' Killed all node processes 🚀';"

# Source zshrc
alias rl="source ~/.zshrc; echo ' Source .zshrc completed 🚀';"

# Open iCloud Drive
alias ic='eval nvim $ICLOUD_DRIVE'

# Open iCloud Obsidian
alias obs='eval nvim $ICLOUD_DRIVE_OBSIDIAN_DIR'

# Open dotfiles
alias dot='cd ~/.dotfiles/ && nvim'

# Homebrew
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'
alias bl='brew services list'
alias bs='brew services'
alias bd='brew doctor'

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
alias ga='git add'
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
alias pull='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias push='git push origin HEAD'
alias pushm='git push origin master'
alias pushf='git push origin HEAD -f'
alias pushn='git push origin HEAD --no-verify'
alias gcl='git clone'
alias pick='git cherry-pick'
alias sts='git stash -u'
alias stl='git stash list'
alias stp='git stash pop'
alias gcm='git checkout origin/master'
alias gmm='git merge master'
alias gfo='git fetch origin'
alias gco='git checkout origin/master'
alias gcg='git config --global'
alias gpm='git pull origin master'

# Github CLI
alias ghpr='gh pr list --state open --author phuongthuan --repo Thinkei/frontend-core'

# Docker
alias dps='docker ps -a'
alias ds='docker stop'
alias drm='docker rm'
alias drmi='docker rmi'
alias dl='docker logs'
alias di='docker inspect'
alias drM='docker container prune -f'
alias dc='docker-compose'

# Yarn
alias yd='yarn dev'
alias ys='yarn start'
alias yt='yarn test'
alias yi='yarn install'
alias yb='yarn build'
alias yp='yarn pack'
alias yl='yarn link'
alias yx='yarn nx'

# mpd
alias mpd_start="mpd --no-daemon --verbose ~/.config/mpd/mpd.conf; echo ' Server was stopped 🔻';" # start mpd server
alias mpd_stop="mpd --kill ~/.config/mpd/mpd.conf; echo ' Stopped mpd server ✅';"                 # stop mpd server

# mpc
alias mpa='mpc add'
alias mpcl='mpc clear'
alias mpl='mpc clear && mpc load'
alias mps='mpc stop && mpc clear'

alias nls='npm ls --depth=0'
alias nd='npm run dev'

# Mobile Development
alias bad='npx expo run:android'
alias bi='npx expo run:ios'

alias xc='xcrun simctl'
alias xcl='xcrun simctl list devices'
alias xcb='xcrun simctl boot 6790E0DD-55BB-42CA-97D2-7239DEF37A78'
alias xcs='xcrun simctl shutdown 6790E0DD-55BB-42CA-97D2-7239DEF37A78'
