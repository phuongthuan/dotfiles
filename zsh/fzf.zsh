# Custom PATH for FZF, ignore node_modules and .git directories
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'

# Open file with Vim
v() {
  local file
  file=$(fzf --query="$1") && nvim "$file"
}
