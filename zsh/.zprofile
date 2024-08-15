echo ".zprofile loaded 🚀"
# Setting PATH for Python 2.7
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

eval "$(/opt/homebrew/bin/brew shellenv)"

# Export path for EH herocli
export PATH=$PATH:$HOME/.local/bin

# Setting editor
export EDITOR="nvim"
export NVIM_CONFIG_DIR="~/.config/nvim"
export NVIM_USE_TSSERVER=false
export NVIM_USE_VTSLS=true
export LAZYVIM_CONFIG="~/.config/lazyvim/init.lua"
export LAZYVIM_CONFIG_DIR="~/.config/lazyvim"

export GITHUB_USERNAME="phuongthuan"

export ZSH="$HOME/.oh-my-zsh"

export DOTFILES="~/.dotfiles"

# Java JDK
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# iCloud Drive
export ICLOUD_DRIVE="~/Library/Mobile Documents/com~apple~CloudDocs"
export ICLOUD_DRIVE_OBSIDIAN_DIR="~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"
