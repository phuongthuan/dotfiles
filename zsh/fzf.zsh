export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "

# Disable ALT-C binding, and rebind it with a new key
# Because ALT key is conflicting with aerospace configuration
export FZF_ALT_C_COMMAND='fd --type=d --hidden --strip-cwd-prefix --exclude .git'

# Setup fzf previews
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

# Load FZF keybindings
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

# Rebind fuzzy cd to Ctrl-F, fzf-cd-widget is the function behind ALT-C
bindkey '^F' fzf-cd-widget

# HACK
# Tip: Use bindkey to inspect current bindings
# bindkey | grep '\^F'

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Custom PATH for FZF, ignore node_modules and .git directories
# export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'
