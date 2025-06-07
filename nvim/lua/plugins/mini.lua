local env = require('core.env')
local nmap = require('core.utils').mapper_factory('n')

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

      -- vim.ui.select = MiniPick.ui_select

      local builtin = MiniPick.builtin
      local extra = MiniExtra.pickers

      -- Search all file in the current working directory
      nmap('<leader>,', function()
        builtin.files({ tool = 'git' }, { source = { name = 'Search all files' } })
      end, { desc = 'Search all files in current working directory' })

      -- Search all loaded buffers
      nmap(';f', function()
        builtin.buffers()
      end, { desc = 'Search all loaded buffers' })

      -- Resume search
      nmap('<leader>rs', function()
        builtin.resume()
      end, { desc = 'Resume search' })

      -- Search help
      nmap('<leader>sh', function()
        builtin.help()
      end, { desc = 'Search help' })

      -- Search for a input string in the current working directory, respects .gitignore
      nmap('<leader>ps', function()
        local pattern = vim.fn.input('Search string')

        -- If input is empty, then hide the input prompt instead of showing empty window
        if pattern == '' then
          return
        end

        builtin.grep({ pattern = pattern }, {
          source = { name = 'Search for: ' .. pattern },
        })
      end, { desc = 'Search for a input string' })

      nmap('<leader>pw', function()
        -- current word under cursor in the current buffer
        local pattern = vim.fn.expand('<cword>')

        builtin.grep({ pattern = pattern }, {
          source = { name = 'Search for: ' .. pattern },
        })
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
        builtin.grep_live(nil, { source = { name = 'Grep buffers' } })
      end, { desc = 'Search for a string in the current open buffers' })

      -- Search all files in env.DOTFILES
      nmap('<leader>fc', function()
        builtin.files(nil, { source = { name = '.dotfiles', cwd = env.DOTFILES } })
      end, { desc = 'Search all files in .dotfiles' })

      -- Search for a string in .dotfiles
      nmap('<leader>sd', function()
        builtin.grep_live(nil, {
          source = { name = 'Grep .dotfiles', cwd = env.DOTFILES },
        })
      end, { desc = 'Search for a string in .dotfiles' })

      -- Search all files in env.PERSONAL_NOTES
      nmap('<leader>fn', function()
        builtin.files(nil, {
          source = { name = 'Notes', cwd = env.PERSONAL_NOTES },
        })
      end, { desc = 'Search all files in Notes' })

      -- Search for a string in env.PERSONAL_NOTES
      nmap('<leader>sn', function()
        builtin.grep_live(nil, {
          source = { name = 'Grep Notes', cwd = env.PERSONAL_NOTES },
        })
      end, { desc = 'Search for a string in Notes' })

      -- List all git branches
      nmap('<leader>gb', function()
        extra.git_branches()
      end, { desc = 'List all git branches' })

      -- List all diagnostics in current buffer
      nmap('<leader>d', function()
        extra.diagnostic({ scope = 'current' }, { source = { name = 'Diagnostics (current) 🐛' } })
      end, { desc = 'List all diagnostics in current buffer' })

      -- List all diagnostics in loaded buffers
      nmap('<leader>D', function()
        extra.diagnostic(nil, { source = { name = 'Diagnostics (all) 🐛' } })
      end, { desc = 'List all diagnostics in loaded buffers' })

      -- List all available keymaps
      nmap('<leader>sk', function()
        extra.keymaps()
      end, { desc = 'List all available keymaps' })
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
}
