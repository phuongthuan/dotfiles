# ~/.zshrc

export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Load seperated config files
for conf in "$HOME/.config/zsh/config.d/"*.zsh; do
  source "${conf}"
done
unset conf

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export ZSH="/Users/thuan/.oh-my-zsh"

ZSH_THEME="lambda-gitster"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting colored-man-pages colorize brew osx docker)

source $ZSH/oh-my-zsh.sh

function bgkill() {
  kill -9 $(jobs -l | head -1 | awk '{print $3}')
}

# Custom PATH for FZF, ignore node_modules and .git directories
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias luamake=/Users/thuan/.config/nvim/lua-language-server/3rd/luamake/luamake
