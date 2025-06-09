local env = require('core.env')
local picker = require('core.picker')
local mapper = require('core.utils').mapper_factory
local nmap = mapper('n')

return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.ai').setup({ n_lines = 500 })
      require('mini.pairs').setup()
      require('mini.starter').setup()
      require('mini.indentscope').setup()
    end,
  },
  {
    'echasnovski/mini.pick',
    config = function()
      -- Extra pickers for mini.pick
      require('mini.extra').setup()

      -- Centered on screen
      local window_config = function()
        local height = math.floor(0.65 * vim.o.lines)
        -- local width = math.floor(0.95 * vim.o.columns) -- 95% of full width
        local full_width = vim.o.columns

        -- native Neovim window, check :h nvim_open_win()
        return {
          anchor = 'NW',
          height = height,
          width = full_width,

          -- row = math.floor(0.5 * (vim.o.lines - height)),
          -- positions the window 0 row down from the top of the editor.
          row = 0,
          col = math.floor(0.5 * (vim.o.columns - full_width)),
          border = 'rounded',
        }
      end

      require('mini.pick').setup({
        mappings = {
          choose_in_split = '<C-h>',

          move_down = '<C-j>',
          move_up = '<C-k>',

          scroll_down = '<C-d>',
          scroll_left = '<C-sl>',
          scroll_right = '<C-sr>',
          scroll_up = '<C-u>',

          delete_left = '<C-dl>',
        },
        window = { config = window_config, prompt_prefix = ' 🔍' },
        options = { content_from_bottom = true },
      })

      vim.ui.select = MiniPick.ui_select

      local builtin = MiniPick.builtin
      local extra = MiniExtra.pickers

      nmap('<leader>,', function()
        builtin.files({ tool = 'fd' }, { source = { name = 'All files (fd)' } })
      end, { desc = 'Search all files in current working directory' })

      nmap(';f', function()
        builtin.buffers()
      end, { desc = 'All loaded buffers' })

      nmap('<leader>rs', function()
        builtin.resume()
      end, { desc = 'Resume search' })

      nmap('<leader>sh', function()
        builtin.help(nil, { source = { name = 'Help 🙌' } })
      end, { desc = 'Search help' })

      nmap('<leader>ps', function()
        local pattern = vim.fn.input('String  ')

        -- If input is empty, then hide the input prompt instead of showing empty window
        if pattern == '' then
          return
        end

        -- picker.grep({ pattern = pattern })
        picker.grep_literal({ pattern = pattern }, { source = { name = 'Grep literal (rg)' } })
      end, { desc = 'Search for a input string' })

      nmap('<leader>pw', function()
        -- current word under cursor in the current buffer
        local pattern = vim.fn.expand('<cword>')

        builtin.grep({ tool = 'rg', pattern = pattern })
      end, { desc = 'Search for the word under cursor' })

      -- Search for a string in the current opened buffer
      nmap('<leader>f', function()
        extra.buf_lines({
          scope = 'current',
        }, {
          source = { name = 'Grep current buffer' },
        })
      end, { desc = 'Search for a string in the current opened buffer' })

      -- Search for a string in the all loaded buffers
      nmap('<leader>F', function()
        extra.buf_lines()
      end, { desc = 'Search for a string in all loaded buffers' })

      -- Search recent files
      nmap('<leader>r', function()
        extra.oldfiles()
      end, { desc = 'Search recent files' })

      -- Search for a string in the current open buffers and get results live as typed
      nmap(';r', function()
        builtin.grep_live({ tool = 'rg' }, { source = { name = 'Grep buffers (rg)' } })
      end, { desc = 'Search for a string in the current open buffers' })

      -- Search all files in env.DOTFILES
      nmap('<leader>fc', function()
        builtin.files({ tool = 'fd' }, { source = { name = '.dotfiles (fd)', cwd = env.DOTFILES } })
      end, { desc = 'Search all files in .dotfiles' })

      -- Search for a string in .dotfiles
      nmap('<leader>sd', function()
        builtin.grep_live({ tool = 'rg' }, {
          source = { name = 'Grep .dotfiles (rg)', cwd = env.DOTFILES },
        })
      end, { desc = 'Search for a string in .dotfiles' })

      nmap('<leader>fn', function()
        builtin.files({ tool = 'fd' }, {
          source = { name = 'Notes (fd)', cwd = env.PERSONAL_NOTES },
        })
      end, { desc = 'All notes (fd)' })

      nmap('<leader>sn', function()
        builtin.grep_live(nil, {
          source = { name = 'Grep Notes', cwd = env.PERSONAL_NOTES },
        })
      end, { desc = 'Search for a string in Notes' })

      nmap('<leader>gb', function()
        extra.git_branches()
      end, { desc = 'List all git branches' })

      nmap('<leader>d', function()
        extra.diagnostic({ scope = 'current' }, { source = { name = 'Diagnostics (current) 🐛' } })
      end, { desc = 'List all diagnostics in current buffer' })

      nmap('<leader>D', function()
        extra.diagnostic(nil, { source = { name = 'Diagnostics (all) 🐛' } })
      end, { desc = 'List all diagnostics in loaded buffers' })

      mapper({ 'n', 'v' })('<leader>sk', function()
        extra.keymaps()
      end, { desc = 'List all available keymaps' })

      nmap('<leader>sg', function()
        extra.spellsuggest({ n_suggestions = 15 })
      end, { desc = 'Spell suggest word under cursor' })

      nmap('<leader>mc', function()
        picker.mpc_commands()
      end, { desc = 'Open MPC' })
    end,
  },
  {
    'echasnovski/mini.hipatterns',
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
  {
    'echasnovski/mini.bufremove',
    config = function()
      local bufremove = require('mini.bufremove')
      bufremove.setup()

      -- Kill the current buffer
      nmap('<leader>z', function()
        local bd = bufremove.delete
        if vim.bo.modified then
          local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
          if choice == 1 then -- Yes
            vim.cmd.write()
            bd(0)
          elseif choice == 2 then -- No
            bd(0, true)
          end
        else
          bd(0)
        end
      end, { desc = 'Kill current buffer' })
    end,
  },
  {
    'echasnovski/mini.files',
    config = function()
      require('mini.files').setup({
        mappings = {
          go_in = '<CR>',
          go_in_plus = 'L',
          go_out = '-',
          go_out_plus = 'H',
        },
      })

      -- Toggle mini files explorer
      nmap('<leader>ee', function()
        MiniFiles.open()
      end, { desc = 'Toggle mini files explorer' })

      -- Toggle current opened file
      nmap('<leader>ef', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        MiniFiles.reveal_cwd()
      end, { desc = 'Toggle current opened file' })
    end,
  },
  {
    'echasnovski/mini.comment',
    version = false,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      -- skip backwards compatibility routines and speed up loading
      vim.g.skip_ts_context_commentstring_module = true

      -- disable the autocommand from ts-context-commentstring
      require('ts_context_commentstring').setup({
        enable_autocmd = false,
      })

      require('mini.comment').setup({
        -- tsx, jsx, html , svelte comment support
        options = {
          custom_commentstring = function()
            ---@diagnostic disable-next-line: missing-fields
            return require('ts_context_commentstring.internal').calculate_commentstring({
              key = 'commentstring',
            }) or vim.bo.commentstring
          end,
        },
      })
    end,
  },
}
