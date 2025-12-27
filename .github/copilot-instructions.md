# Dotfiles Repository - Copilot Instructions

## Project Overview

This is a personal **dotfiles repository** for macOS development environment. It
contains configuration files for terminal tools, [Neovim](https://neovim.io/),
window management, and productivity applications.

**Author:** phuongthuan  
**Target OS:** macOS (Darwin)  
**Package Manager:** [Homebrew](https://brew.sh/) (via `Brewfile`)

## Tech Stack & Tools

| Category        | Tools                                      |
| --------------- | ------------------------------------------ |
| Editor          | Neovim (Lua config, lazy.nvim)             |
| Terminal        | Ghostty, Alacritty, Kitty                  |
| Multiplexer     | Tmux + TPM plugins                         |
| Shell           | Zsh + Starship prompt                      |
| Window Manager  | AeroSpace (i3-like)                        |
| Version Manager | asdf (Node.js, Ruby, Lua)                  |
| Theme           | Gruvbox Dark (consistent across all tools) |

## Repository Structure

```
.
├── .github/              # GitHub configs & Copilot instructions
├── nvim/                 # Neovim configuration
│   ├── init.lua          # Entry point
│   ├── lua/
│   │   ├── options.lua   # Vim options
│   │   ├── keymaps.lua   # Key mappings
│   │   ├── commands.lua  # Custom commands
│   │   ├── lazynvim.lua  # Plugin manager setup
│   │   ├── core/         # Utilities, icons, helpers
│   │   └── plugins/      # Plugin configurations
│   │       ├── ai/       # AI setup (copilot, codecompanion)
│   │       ├── lsp/      # LSP setup (mason, lspconfig)
│   │       └── extras/   # Optional/experimental plugins
│   └── .stylua.toml      # Lua formatter config
├── tmux/                 # Tmux configuration
├── ghostty/              # Ghostty terminal config
├── alacritty/            # Alacritty terminal config
├── kitty/                # Kitty terminal config
├── starship/             # Starship prompt config
├── aerospace/            # AeroSpace window manager
├── karabiner/            # Keyboard customization
├── gemini/               # Gemini CLI settings
├── tmuxinator/           # Tmux session templates
├── cheats/               # Cheat sheets (navi format)
├── Brewfile              # Homebrew dependencies
└── .tool-versions        # asdf version pinning
```

## Version Requirements

- Node.js: 22.20.0
- Lua: 5.1
- Ruby: 3.1.4
- Neovim: 0.11+

## Coding Standards

### Neovim Configuration

> **See:**
> [`.github/instructions/neovim.instructions.md`](./instructions/neovim.instructions.md)
> for detailed Neovim-specific guidelines including:
>
> - Plugin structure (core vs extras)
> - Keymap utilities (`mapper_factory`)
> - LSP setup
> - Coding styles

### Tmux Configuration

- Prefix key: `` ` `` (backtick)
- Use Gruvbox color variables (e.g., `#{@aqua}`, `#{@purple}`)
- Plugins managed via TPM
- Navigation integrated with Neovim (C-h/j/k/l)

### Shell/Terminal Configs

- TOML format for Starship, Ghostty, AeroSpace
- YAML for tmuxinator sessions
- Keep configs minimal and well-commented

## Color Palette (Gruvbox Dark)

Use these colors consistently across all configs:

hard-black: #282828
black:      #3c3836
white:      #fbf1c7
gray:       #a89984
orange:     #fe8019
purple:     #d3869b
blue:       #458588
light-blue: #83a598
green:      #b8bb26
aqua:       #8ec07c
red:        #cc241d
yellow:     #fabd2f

## Version Requirements

- Node.js: 22.20.0
- Lua: 5.1
- Ruby: 3.1.4
- Neovim: 0.11+

## Important Notes

1. **Nerd Font Required**: Configs use `VictorMono Nerd Font`
2. **macOS Specific**: Some configs are macOS-only (AeroSpace, Karabiner)
3. **Symlinks**: Files should be symlinked to `~/.config/` directories

## Do NOT

- Add line numbers in Neovim (disabled intentionally)
- Use Python/Perl providers (disabled)
- Use tabs (always spaces, 2-width)
- Hardcode paths (use `$HOME` or `~`)

## Common Tasks

### Adding a new Homebrew package

1. Add to `Brewfile` with appropriate comment
2. Run `brew bundle` to install
