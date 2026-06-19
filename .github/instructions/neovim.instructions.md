---
applyTo: 'nvim/**/*.lua'
---

# Neovim Lua Configuration Guidelines

## Coding Styles

- Use StyLua formatter settings from `nvim/.stylua.toml`
- 2 spaces indentation, 120 max line width
- Single quotes for strings
- Always use parentheses for function calls

## Adding a new keymap

This project uses a custom `mapper` utility from `core.utils` for keymaps.

### Setup mappers

```lua
local mapper = require('core.utils').mapper_factory

local nmap = mapper('n')  -- Normal mode
local vmap = mapper('v')  -- Visual mode
local imap = mapper('i')  -- Insert mode
local xmap = mapper('x')  -- Visual block mode
local omap = mapper('o')  -- Operator pending mode
```

### Single mode mapping

```lua
-- Basic mapping
nmap('<BS>', '<C-^>')  -- Switch between last two files

-- With options
imap('jk', '<Esc>', { noremap = true })  -- Map Esc to jk

-- With description (for which-key)
nmap('<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
```

### Multi-mode mapping

```lua
-- Apply same mapping to multiple modes
mapper({ 'n', 'x' })('x', '"_x')  -- Delete without changing registers
```

### Alternative: vim.keymap.set

```lua
-- Standard Neovim API (also acceptable)
vim.keymap.set('n', '<leader>xx', function()
  -- action
end, { desc = 'Description for which-key' })
```

## Adding a new plugin

### Core plugins (`nvim/lua/plugins/`)

For essential, always-loaded plugins:

```lua
-- nvim/lua/plugins/plugin-name.lua
return {
  {
    'author/plugin-name',
    dependencies = { 'dep1', 'dep2' }, -- optional
    event = 'VeryLazy', -- optional
    opts = {},
  },
}
```

### Extras plugins (`nvim/lua/plugins/extras/`)

For optional or experimental plugins. Use `enabled` to toggle:

```lua
-- nvim/lua/plugins/extras/plugin-name.lua
return {
  'author/plugin-name',
  enabled = true,  -- set to false to disable
  event = 'VeryLazy',
  opts = {},
}
```

**Note:** All extras plugins are auto-imported. Just toggle `enabled = true/false` to activate/deactivate.

## API Preferences

- Use `vim.keymap.set` instead of `vim.api.nvim_set_keymap`
- Use `vim.o` / `vim.opt` for options
- Use `vim.api.nvim_create_autocmd` for autocommands
- Use `require('core.utils')` for shared utilities

## LSP Plugins

- mason.nvim for LSP server management
- blink.cmp for completions
- lazydev.nvim for Lua development
