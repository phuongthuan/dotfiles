# AGENTS.md

This file provides guidance to AI coding agents (Claude Code, GitHub Copilot,
etc.) when working with code in this repository. `CLAUDE.md` and
`.github/copilot-instructions.md` are symlinks to this file — edit this file
only; the others will always stay in sync.

## Overview

Personal dotfiles for macOS development environment. No traditional build/test
process — this repo is managed via symlinks to `~/.config/` directories.

**Target OS:** macOS (Darwin) | **Package Manager:** Homebrew | **Font:**
VictorMono Nerd Font | **Theme:** Gruvbox Dark (consistent across all tools)

## Tool Stack

| Category        | Tools                                                       |
| --------------- | ----------------------------------------------------------- |
| Editor          | Neovim (Lua, `vim.pack` — Neovim's built-in plugin manager) |
| Terminal        | Ghostty (primary), Alacritty, Kitty, WezTerm                |
| Multiplexer     | Tmux + TPM plugins + tmuxinator sessions                    |
| Shell           | Zsh + oh-my-zsh + Starship prompt                           |
| Window Manager  | AeroSpace (i3-like tiling for macOS)                        |
| Version Manager | mise — Node.js 20.19.4, Ruby 3.1.4, Lua 5.1                 |

## Commands

```bash
# Format Lua files
stylua nvim/lua/**/*.lua

# Check Lua formatting without writing
stylua --check nvim/lua/**/*.lua

# Install all Homebrew packages
brew bundle

# Reload tmux config
tmux source-file ~/.dotfiles/tmux/tmux.conf

# Source zsh config
source ~/.dotfiles/zsh/zshrc

# List installed tool versions
mise ls

# Install tools from config
mise install
```

## Worktrees (treehouse)

Repos may be checked out as `treehouse` worktrees, not just plain git worktrees.
Treehouse worktree paths follow this convention:

```
~/.treehouse/<repo-name>-<hash>/<worktree-id>/<repo-name>
```

e.g. `~/.treehouse/eh-mobile-pro-3958c1/2/eh-mobile-pro`. The `<hash>` and
`<worktree-id>` segments are opaque and vary per checkout, so repo-detection
helpers must match on the pattern rather than an exact path — see
`is_mobile_repo`/`is_frontend_core_repo` in `nvim/lua/functions.lua`.

## Neovim Version Management (nvimv)

Neovim versions are managed via
[nvimv](https://github.com/nicholasgasior/nvimv). Tags are stored in
`~/.local/share/nvimv/tags/`. The `nn` alias runs the stable tag:
`nvimv exec stable` (uses default `NVIM_APPNAME=nvim` → `~/.config/nvim`).

```bash
# List installed tags
nvimv list

# Install a tag (stable or nightly)
nvimv install stable

# Upgrade an existing tag to the latest release
nvimv upgrade stable

# Remove a tag
nvimv remove stable

# Execute nvim with a tag
nvimv exec stable
```

**Upgrading Neovim:** run `nvimv upgrade stable`. If `vim.health` reports stale
`$VIMRUNTIME` files, remove and reinstall the tag:

```bash
nvimv remove stable && nvimv install stable
```

## Neovim Architecture

Primary config: `nvim/` (uses `vim.pack`, Neovim's built-in plugin manager).
`nvim-legacy/` is a backup — don't touch it unless explicitly asked.

**Load order:** `init.lua` → `config` → `packer` → `keymaps` → `autocmds` →
`commands` → `functions` → `gh-cli`

```
nvim/
├── init.lua                  # Entry point; sets mapleader = ' ', global table _G.t
├── lua/
│   ├── config.lua            # All vim options and globals
│   ├── keymaps.lua           # Global keymaps
│   ├── autocmds.lua          # Autocommands
│   ├── commands.lua          # Custom Ex commands
│   ├── functions.lua         # Shared Lua functions
│   ├── gh-cli.lua            # GitHub CLI integration
│   ├── packer.lua            # vim.pack setup + PackUpdate/PackStatus/PackDelete commands
│   ├── utils.lua             # Shared module: mapper_factory, env vars, icons, colors
│   └── overseer/template/    # Overseer task templates (yarn, mobile, maestro, etc.)
├── plugin/                   # Plugin configs, each file is a domain
│   ├── lsp.lua               # LSP + mason.nvim setup
│   ├── completion.lua        # Completion engine (blink.cmp)
│   ├── treesitter.lua        # Treesitter
│   ├── picker.lua            # File/symbol picker (MiniPick)
│   ├── git.lua               # Git integration
│   ├── coding.lua            # Editing utilities (pairs, jump, ai, autotag)
│   ├── format.lua            # Formatting
│   ├── harpoon.lua           # Harpoon file marks
│   ├── heirline.lua          # Status line
│   ├── ui.lua                # UI plugins
│   ├── colorscheme.lua       # Colorscheme
│   └── folding.lua           # Folding
├── lsp/                      # Per-language LSP configs (loaded by plugin/lsp.lua)
│   └── *.lua                 # basedpyright, bashls, lua_ls, ruby_lsp, ts_ls, yamlls
├── extras/                   # Optional plugins (e.g. ai.lua for copilot/codecompanion)
└── .stylua.toml               # Formatter: 120 cols, 2-space indent, single quotes
```

### Keymap convention

`utils.lua` exports pre-built mode mappers — use these instead of calling
`vim.keymap.set` directly:

```lua
local utils = require('utils')
local nmap = utils.nmap
local vmap = utils.vmap
local imap = utils.imap

nmap('<leader>ff', '<cmd>lua MiniPick.builtin.files()<cr>', { desc = 'Find files' })

-- Or use the factory for other modes:
local xmap = utils.mapper('x')
```

### Plugin convention

Each `plugin/*.lua` file calls `vim.pack.add({...})` at the top, then configures
the plugins inline. No return value needed.

```lua
vim.pack.add({
  'https://github.com/author/plugin-name',
})

-- configure inline below
```

Pin a version when needed:

```lua
vim.pack.add({
  { src = 'https://github.com/author/plugin-name', version = vim.version.range('^1') },
})
```

For optional plugins, add to `extras/` and `vim.pack.add` there.

### Neovim conventions

- No line numbers (`vim.o.number = false`) — intentional
- No Python/Perl providers — disabled intentionally
- Use `vim.o`/`vim.opt` for options, `vim.api.nvim_create_autocmd` for autocmds
- `require('utils')` is the single shared module (env, icons, colors, mappers)
- Global table `_G.t = {}` available for shared state
  (`t.home = os.getenv('HOME')`)
- Autocmd groups go through the `augroup(name)` helper in `autocmds.lua`, which
  prefixes every group with `user` (e.g. `userhighlight_yanked_text`)
- Cursor stays centered after `n`/`N` search jumps (`nzzzv`/`Nzzzv`)
- `.env` / `.env.*` files are auto-detected as filetype `sh`

## Code Style

- **Lua:** 2-space indent, 120-col width, single quotes, always use parentheses
  — enforced by StyLua
- **Shell/TOML/YAML:** 2-space indent; no tabs anywhere
- **Paths:** always use `$HOME` or `~`, never hardcode absolute paths
- **Naming:** module tables as `M`, mode mappers as `nmap`/`vmap`/`imap`,
  constants as `UPPER_SNAKE_CASE`, private functions prefixed with `_`

## Gruvbox Colors

Use these across all configs (tmux, terminal, Starship, etc.):

```
hard-black: #282828   black:      #3c3836   white:   #fbf1c7
gray:       #a89984   orange:     #fe8019   purple:  #d3869b
blue:       #458588   light-blue: #83a598   green:   #b8bb26
aqua:       #8ec07c   red:        #cc241d   yellow:  #fabd2f
```

In tmux configs, reference via variables: `#{@aqua}`, `#{@purple}`, etc. Tmux
prefix key is `` ` `` (backtick); window/pane navigation is integrated with
Neovim (C-h/j/k/l); `allow-rename` is off.

## Reference Files

- LSP configs: `nvim/lsp/*.lua` (basedpyright, bashls, lua_ls, ruby_lsp, ts_ls,
  yamlls)
- Snippets (VS Code format): `snippets/` — lua, typescript, shell, html, json,
  markdown
