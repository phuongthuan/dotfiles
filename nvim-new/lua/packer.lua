-- ============================================================
-- PLUGIN MANAGER INTRO
-- ============================================================
--
-- [[ Intro to `vim.pack` ]]
-- `vim.pack` is a new plugin manager built into Neovim,
--  which provides a Lua interface for installing and managing plugins.
--
--  See `:help vim.pack`, `:help vim.pack-examples` or the
--  excellent blog post from the creator of vim.pack and mini.nvim:
--  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
--
--  To inspect plugin state and pending updates, run
--    :lua vim.pack.update(nil, { offline = true })
--
--  To update plugins, run
--    :lua vim.pack.update()
--
--
--  Throughout the rest of the config there will be examples
--  of how to install and configure plugins using `vim.pack`.
--
-- This autocommand runs after a plugin is installed or updated and
--  runs the appropriate build command for that plugin if necessary.
--
-- See `:help vim.pack-events`

local autocmd = vim.api.nvim_create_autocmd --[[@type function]]
local command = vim.api.nvim_create_user_command --[[@type function]]

autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then
      return
    end

    if name == 'nvim-treesitter' then
      if not ev.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
      return
    end
  end,
})

command('PackUpdate', ':lua vim.pack.update()', { desc = 'Update Plugins' })
command('PackStatus', ':lua vim.pack.update(nil, { offline = true })', { desc = 'Check Plugins State And Updates' })

-- PackDelete plugin1 plugin2
command('PackDelete', function(opts)
  local plugins = vim.split(opts.args, '%s+', { trimempty = true })
  if #plugins == 0 then
    vim.notify('PackDelete: provide plugin name(s) to delete', vim.log.levels.WARN)
    return
  end
  vim.pack.del(plugins)
end, { desc = 'Delete Plugin(s)', nargs = '*' })
