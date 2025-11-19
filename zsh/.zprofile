export ZSH="$HOME/.oh-my-zsh"

export EDITOR="nvim"
export REACT_EDITOR="nvim"
export NVIM_CONFIG_DIR="$HOME/.config/nvim"
export DOTFILES="$HOME/.dotfiles"

# Set XDG config home
export XDG_CONFIG_HOME="$HOME/.config"

# secret env
export SECRET_ENV_FILE="$HOME/.dotfiles/zsh/secret.zsh"

# Add Ruby Gem executables directory to PATH
export PATH="$HOME/.asdf/installs/ruby/3.1.4/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"

export TMUX_CONF="$HOME/.config/tmux/tmux.conf"

# EH herocli
export PATH=$PATH:$HOME/.local/bin

# Java JDK
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"

# Android SDK
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export PATH="$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$PATH"

# iCloud Drive
export ICLOUD_DRIVE="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
export ICLOUD_DRIVE_OBSIDIAN_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"

# Notes
export PERSONAL_NOTES="$HOME/Documents/Notes"
