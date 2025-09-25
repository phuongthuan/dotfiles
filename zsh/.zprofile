export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export REACT_EDITOR="nvim"
export NVIM_CONFIG_DIR="$HOME/.config/nvim"
export DOTFILES="$HOME/.dotfiles"

# Set XDG config home
export XDG_CONFIG_HOME="$HOME/.config"

# secret env
export SECRET_ENV_FILE="$HOME/.dotfiles/zsh/secret.zsh"

# Setting PATH for Python 2.7
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Add Ruby Gem executables directory to PATH
PATH="$HOME/.asdf/installs/ruby/3.1.4/bin:$PATH"
export PATH

# bun
export BUN_INSTALL="$HOME/.bun"
PATH="$BUN_INSTALL/bin:$PATH"
export PATH

eval "$(/opt/homebrew/bin/brew shellenv)"

export TMUX_CONF="$HOME/.config/tmux/tmux.conf"

# EH herocli
export PATH=$PATH:$HOME/.local/bin

# Java JDK
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# iCloud Drive
export ICLOUD_DRIVE="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
export ICLOUD_DRIVE_OBSIDIAN_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"

# Notes
export PERSONAL_NOTES="$HOME/Documents/Notes"
