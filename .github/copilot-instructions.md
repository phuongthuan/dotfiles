# Dotfiles Repository - Copilot Instructions

## Project Overview

This is a personal **dotfiles repository** for macOS development environment. It contains configuration files for terminal tools, Neovim, window management, and productivity applications.

**Author:** phuongthuan  
**Target OS:** macOS (Darwin)  
**Package Manager:** Homebrew (via `Brewfile`)

## Tech Stack & Tools

| Category | Tools |
|----------|-------|
| Editor | Neovim (Lua config, lazy.nvim) |
| Terminal | Ghostty, Alacritty, Kitty |
| Multiplexer | Tmux + TPM plugins |
| Shell | Zsh + Starship prompt |
| Window Manager | AeroSpace (i3-like) |
| Version Manager | asdf (Node.js, Ruby, Lua) |
| Theme | Gruvbox Dark (consistent across all tools) |

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

## Coding Standards

### Lua (Neovim configs)

- Use **StyLua** for formatting (config in `nvim/.stylua.toml`)
- Indent: 2 spaces
- Max line width: 120 characters
- Quote style: Single quotes preferred
- Always use parentheses for function calls

```lua
-- Good
local nmap = require('core.utils').mapper_factory('n')

-- Bad
local nmap = require "core.utils".mapper_factory "n"
```

### Neovim Plugin Structure

- Each plugin in `nvim/lua/plugins/` returns a table for lazy.nvim
- Use `opts = {}` for simple configs, `config = function()` for complex ones
- Group related functionality (e.g., `lsp/init.lua`, `lsp/mappings.lua`)
- Experimental plugins go in `plugins/extras/`

```lua
-- Standard plugin format
return {
  {
    'author/plugin-name',
    dependencies = { 'dep1', 'dep2' },
    event = 'VeryLazy',  -- or ft, cmd, keys
    opts = {
      -- configuration
    },
  },
}
```

### Key Mappings Convention

- Leader key: `<Space>`
- Use descriptive `desc` for which-key integration
- Prefer `vim.keymap.set` over `vim.api.nvim_set_keymap`

```lua
vim.keymap.set('n', '<leader>ff', function()
  -- action
end, { desc = 'Find files' })
```

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

```
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
```

## Version Requirements

- Node.js: 22.20.0
- Lua: 5.1
- Ruby: 3.1.4
- Neovim: 0.9+ (0.10+ recommended)

## Important Notes

1. **Nerd Font Required**: Configs use `VictorMono Nerd Font` and `Hack Nerd Font`
2. **macOS Specific**: Some configs are macOS-only (AeroSpace, Karabiner)
3. **Symlinks**: Files should be symlinked to `~/.config/` directories
4. **AI Integration**: Neovim has CodeCompanion and Copilot plugins in `plugins/extras/`

## Do NOT

- Add line numbers in Neovim (disabled intentionally)
- Use Python/Perl providers (disabled)
- Use tabs (always spaces, 2-width)
- Hardcode paths (use `$HOME` or `~`)

## Common Tasks

### Adding a new Neovim plugin
1. Create file in `nvim/lua/plugins/` or `nvim/lua/plugins/extras/`
2. Return lazy.nvim spec table
3. Run `:Lazy` to install

### Adding a new Homebrew package
1. Add to `Brewfile` with appropriate comment
2. Run `brew bundle` to install

### Formatting Lua code
```bash
stylua nvim/
```

