# Dotfiles Repository - Agent Guidelines

## Project Overview

Personal dotfiles repository for macOS development environment. Contains configuration files for terminal tools, Neovim, window management, and productivity applications.

**Author:** phuongthuan
**Target OS:** macOS (Darwin)
**Package Manager:** Homebrew (via Brewfile)

## Version Requirements

- Node.js: 22.20.0
- Lua: 5.1
- Ruby: 3.1.4
- Neovim: 0.11+

## Repository Structure

```
.
├── nvim/                 # Neovim configuration (Lua)
│   ├── lua/
│   │   ├── options.lua   # Vim options
│   │   ├── keymaps.lua   # Key mappings
│   │   ├── commands.lua  # Custom commands
│   │   ├── core/         # Utilities, helpers
│   │   └── plugins/      # Plugin configurations
│   │       ├── ai/       # AI plugins
│   │       ├── lsp/      # LSP setup
│   │       └── extras/   # Optional plugins
│   └── .stylua.toml      # Lua formatter config
├── tmux/                 # Tmux configuration
├── ghostty/              # Ghostty terminal config
├── zsh/                  # Zsh shell configuration
├── aerospace/            # AeroSpace window manager
├── karabiner/            # Keyboard customization
├── tmuxinator/           # Tmux session templates
├── Brewfile              # Homebrew dependencies
└── .tool-versions        # asdf version pinning
```

## Build/Lint/Test Commands

This is a dotfiles repository with no traditional build process. However, there are specific tools and commands:

### Neovim Lua Formatting
```bash
# Format Lua files with StyLua
stylua nvim/lua/**/*.lua

# Check formatting
stylua --check nvim/lua/**/*.lua
```

### Shell Testing
```bash
# Source zsh configuration
source ~/.dotfiles/zsh/zshrc

# Test tmux configuration
tmux source-file ~/.dotfiles/tmux/tmux.conf
```

### Homebrew Package Management
```bash
# Install all packages from Brewfile
brew bundle

# Update packages
brew bundle --force cleanup
```

### Running Tests (from Neovim keymaps)
```bash
# Run unit tests (triggered from Neovim with <leader>ut)
ytc <path/to/test.spec.js>

# Run Maestro E2E tests (triggered from Neovim with <leader>mt)
mte <path/to/test.yaml>
```

## Code Style Guidelines

### Neovim Lua Configuration

#### Formatting (StyLua)
- 2 spaces indentation
- 120 character line width
- Unix line endings
- Single quotes preferred (AutoPreferSingle)
- Always use parentheses for function calls
- No trailing whitespace

#### Import/Require Patterns
```lua
-- Local requires at top of file
local mapper = require('core.utils').mapper_factory
local env = require('core.env')

-- Group related requires together
local nmap = mapper('n')
local vmap = mapper('v')
local imap = mapper('i')
```

#### Naming Conventions
- Module tables: `M` (e.g., `local M = {}`)
- Mode mappers: `nmap`, `vmap`, `imap`, `xmap`, `omap`
- Constants: `UPPER_SNAKE_CASE` (e.g., `NVIM_CONFIG_DIR`)
- Functions: `snake_case` (e.g., `mapper_factory`)
- Private functions: prefix with underscore `_function_name`

#### Plugin Structure
- Core plugins: `nvim/lua/plugins/*.lua` (always loaded)
- Optional plugins: `nvim/lua/plugins/extras/*.lua` (toggle with `enabled`)
- Plugin spec format:
```lua
return {
  'author/plugin-name',
  dependencies = { 'dep1', 'dep2' }, -- optional
  event = 'VeryLazy',                -- lazy load
  enabled = true,                    -- for extras
  opts = {},                         -- plugin options
}
```

#### Keymap Utilities
Use `mapper_factory` from `core.utils`:
```lua
local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')

-- Basic mapping
nmap('<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })

-- Multi-mode mapping
mapper({ 'n', 'x' })('x', '"_x')
```

Alternative: `vim.keymap.set` is also acceptable.

#### API Preferences
- Use `vim.keymap.set` instead of `vim.api.nvim_set_keymap`
- Use `vim.o` / `vim.opt` for options
- Use `vim.api.nvim_create_autocmd` for autocommands
- Use `require('core.utils')` for shared utilities

#### Error Handling
- Use `pcall` for operations that might fail
- Provide descriptive error messages with context
- Use `vim.notify` for user-facing messages

#### Comments and Documentation
- Use LuaLS annotations for functions:
```lua
---@param mode string|table
---@return fun(lhs: string, rhs: string|function, opts: table|nil)
function M.mapper_factory(mode)
  -- implementation
end
```

### Shell/Zsh Configuration

- Use consistent 2-space indentation
- Comment complex logic
- Keep functions focused and reusable
- Use descriptive variable names in UPPER_CASE for exports

### Configuration Files

- TOML: Starship, Ghostty, AeroSpace, StyLua
- YAML: tmuxinator sessions
- Keep configs minimal and well-commented
- Use Gruvbox color palette consistently

## Color Palette (Gruvbox Dark)

Use these colors across all configs:

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

## Important Conventions

### DO
- Use spaces, never tabs (2-width)
- Keep cursor centered when searching (mapped in keymaps.lua)
- Use relative paths with `$HOME` or `~`
- Maintain Gruvbox theme consistency
- Use VictorMono Nerd Font glyphs where applicable
- Symlink configs to `~/.config/` directories

### DO NOT
- Add line numbers in Neovim (disabled intentionally)
- Use Python/Perl providers (disabled in options.lua)
- Use tabs for indentation
- Hardcode absolute paths
- Rename tmux windows automatically (disabled)

## Common Patterns

### Tmux Configuration
- Prefix key: `` ` `` (backtick)
- Use Gruvbox color variables: `#{@aqua}`, `#{@purple}`
- Window/pane navigation: integrated with Neovim (C-h/j/k/l)

### Neovim Options
- No line numbers by default (`vim.o.number = false`)
- Cursor line highlighting enabled
- Smart case-insensitive search
- 2-space tabs, expand to spaces
- Sign column always visible

### Autocommands
- Group all autocmds under 'UserConfig' group
- Highlight on yank (40ms timeout)
- Map 'q' to quit in help/man/lspinfo buffers
- Auto-detect .env files as shell filetype

## File References

When working on specific components:

- Neovim detailed guidelines: `.github/instructions/neovim.instructions.md`
- Copilot instructions: `.github/copilot-instructions.md`
- Lua formatter config: `nvim/.stylua.toml`
- Core utilities: `nvim/lua/core/utils.lua`
- Global keymaps: `nvim/lua/keymaps.lua`
- Vim options: `nvim/lua/options.lua`
