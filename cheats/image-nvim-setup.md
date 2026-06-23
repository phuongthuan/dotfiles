# image.nvim Setup

## Requirements

- Ghostty terminal (supports Kitty graphics protocol)
- tmux with `allow-passthrough on` (already in `tmux/tmux.conf`)
- ImageMagick

```bash
brew install imagemagick
```

## Plugin file

`nvim/plugin/ui.lua` — auto-sourced at startup.

## First-time installation gotcha

Running `:lua vim.pack.update()` on a machine where image.nvim is not yet installed
will trigger a confirmation dialog, then `vim.cmd.redraw()`. This redraw evaluates
heirline mid-startup and crashes with:

```
bad argument #1 to 'provider' (string expected, got nil)
heirline/statusline.lua:381
```

**Root causes:**

1. Provider functions in `nvim/plugin/heirline.lua` returning `nil` instead of `""`
2. Stale Lua bytecode cache (`vim.loader`) serving old compiled code

**Fix — do this on the new machine:**

### Step 1: Clear the heirline Lua cache

```bash
rm ~/.cache/nvim/luac/%2fUsers%2f<username>%2fp%2fdotfiles%2fnvim%2fplugin%2fheirline.luac
```

Replace `<username>` with the actual macOS username. Or clear all caches:

```bash
rm -rf ~/.cache/nvim/luac/
```

### Step 2: Manually clone image.nvim

This bypasses the first-install confirmation dialog (and the problematic redraw):

```bash
git clone https://github.com/3rd/image.nvim \
  ~/.local/share/nvim/site/pack/core/opt/image.nvim
```

### Step 3: Start Neovim and update the lock file

```bash
nvim
```

Then inside Neovim:

```
:lua vim.pack.update()
```

This will update `nvim-pack-lock.json` with image.nvim's commit hash. Since
the plugin is already cloned, no confirmation dialog appears.

## Verify it works

Open a markdown file containing an image link:

```markdown
![test](https://url-to-image.png)
```

Image should render inline. Run `:checkhealth image` to confirm the backend is working.
