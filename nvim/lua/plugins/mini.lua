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
        local height = math.floor(0.7 * vim.o.lines)
        local width = math.floor(0.7 * vim.o.columns)
        return {
          anchor = 'NW',
          height = height,
          width = width,
          row = math.floor(0.5 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width)),
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
        window = { config = window_config, prompt_cursor = '█ ', prompt_prefix = ' 🔍' },
        options = { content_from_bottom = true },
      })

      -- vim.ui.select = MiniPick.ui_select

      local builtin = MiniPick.builtin
      local extra = MiniExtra.pickers

      -- Search all file in the current working directory
      nmap('<leader>,', function()
        builtin.files({ tool = 'git' }, { source = { name = 'Find files' } })
      end)

      -- Search all loaded buffers
      nmap(';f', function()
        builtin.buffers()
      end)

      -- Resume search
      nmap('<leader>rs', function()
        builtin.resume()
      end)

      -- Search help
      nmap('<leader>sh', function()
        builtin.help()
      end)

      -- Search for a input string in the current working directory, respects .gitignore
      nmap('<leader>ps', function()
        builtin.grep(nil, {
          source = { name = 'Grep string' },
        })
      end)

      -- Search for a string in the current opened buffer
      nmap('<leader>f', function()
        extra.buf_lines({
          scope = 'current',
        }, {
          source = { name = 'Grep current buffer' },
        })
      end)

      -- Search for a string in the all loaded buffers
      nmap('<leader>F', function()
        extra.buf_lines()
      end)

      -- [S]earch Recent Files
      nmap('<leader>r', function()
        extra.oldfiles()
      end)

      -- Search for a string in the current open buffers and get results live as typed
      nmap(';r', function()
        builtin.grep_live(nil, { source = { name = 'Grep buffers' } })
      end)

      -- Search all files in env.DOTFILES
      nmap('<leader>fc', function()
        builtin.files(nil, { source = { name = '.dotfiles', cwd = env.DOTFILES } })
      end)

      -- Search for a string in .dotfiles
      nmap('<leader>sd', function()
        builtin.grep_live(nil, {
          source = { name = 'Grep .dotfiles', cwd = env.DOTFILES },
        })
      end)

      -- Search all files in env.PERSONAL_NOTES
      nmap('<leader>fn', function()
        builtin.files(nil, {
          source = { name = 'Notes', cwd = env.PERSONAL_NOTES },
        })
      end)

      -- Search for a string in env.PERSONAL_NOTES
      nmap('<leader>sn', function()
        builtin.grep_live(nil, {
          source = { name = 'Grep Notes', cwd = env.PERSONAL_NOTES },
        })
      end)

      -- List all git branches
      nmap('<leader>gb', function()
        extra.git_branches()
      end)

      -- List all diagnostics
      -- nmap('<leader>sd', function()
      --   extra.dianostic()
      -- end)
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
      end)
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
      end)

      -- Toggle current opened file
      nmap('<leader>ef', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        MiniFiles.reveal_cwd()
      end)
    end,
  },
}
