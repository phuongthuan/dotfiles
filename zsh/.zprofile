export ZSH="$HOME/.oh-my-zsh"

export EDITOR="nvim"
export REACT_EDITOR="nvim"
export NVIM_CONFIG_DIR="$HOME/.config/nvim"
export DOTFILES="$HOME/.dotfiles"
export PERSONAL_NOTES="$HOME/Documents/Notes"
export ICLOUD_DRIVE="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
export ICLOUD_DRIVE_OBSIDIAN_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"

# set XDG config home
export XDG_CONFIG_HOME="$HOME/.config"

# secret env
export SECRET_ENV_FILE="$HOME/.dotfiles/zsh/secret.zsh"

# add Ruby Gem executables directory to PATH
export PATH="$HOME/.asdf/installs/ruby/3.1.4/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"

# tmux
export TMUX_CONF="$HOME/.config/tmux/tmux.conf"

# herocli
export PATH=$PATH:$HOME/.local/bin

# opencode
export PATH=/Users/thuan/.opencode/bin:$PATH

# java JDK
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"

# android SDK
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export PATH="$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$PATH"

# postgresql@16
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# ===================================================
# asdf shims must be last so they prepend to the front of PATH,
# Explaination
# When you install Node (or Ruby, Python, etc.) via Homebrew, brew shellenv (in your .zprofile) puts /opt/homebrew/bin on your PATH. If you also manage those same tools with asdf, Homebrew's version would win because it comes first.
#
# asdf works by placing "shim" executables in ~/.asdf/shims/. When you run node, the shim intercepts it and delegates to whichever version asdf has set for that directory (via .tool-versions). But this only works if the shim directory comes before Homebrew on your PATH.
#
# Your .zprofile load order:
#
# brew shellenv          → adds /opt/homebrew/bin to PATH  (line 21)
# ...
# postgresql@16 PATH     → /opt/homebrew/opt/postgresql@16/bin
# asdf shims             → $HOME/.asdf/shims:$HOME/.asdf/bin  ← appended LAST = highest priority
#
# Because each export PATH="...:$PATH" prepends to the front, the last one wins. Putting asdf at the bottom of .zprofile ensures it sits at the front of $PATH, overriding Homebrew's node/ruby/python.
#
# Without it: node -v would give you Homebrew's global Node instead of the project-specific version asdf selected — breaking per-project version switching entirely.
export PATH="$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH"
# ===================================================
