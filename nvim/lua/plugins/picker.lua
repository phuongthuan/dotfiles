local env = require('core.env')
local mapper = require('core.utils').mapper_factory
local picker = require('core.my-picker')

local nmap = mapper('n')

return {
  'echasnovski/mini.pick',
  version = false,
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

    -- Custom pickers
    nmap('<leader>,', function()
      picker.find_files({ tool = 'fd' }, { source = { name = ' Files (fd)' } })
    end, { desc = 'Search all files in current working directory' })

    nmap('<leader>m', function()
      picker.open_music()
    end, { desc = 'Open MPC' })

    nmap('<leader>pw', function()
      -- current word under cursor in the current buffer
      local word = vim.fn.expand('<cword>')
      picker.grep_literal({ pattern = word }, { source = { name = 'Grep (rg): ' .. word } })
    end, { desc = 'Search word under cursor' })

    nmap('<leader>ps', function()
      local string = vim.fn.input('Input String')

      -- If input is empty, hide the input prompt instead of showing empty window
      if string == '' then
        return
      end

      picker.grep_literal({ pattern = string }, { source = { name = 'Grep literal string (rg)' } })
    end, { desc = 'Search for a literal string' })

    nmap('<leader>fr', function()
      picker.find_files({ tool = 'fd' }, {
        source = {
          cwd = env.REFERENCES_DIR,
          name = ' References (fd)',
        },
      })
    end, { desc = 'Search all files in references' })

    -- MiniPick builtin pickers
    nmap('<leader>fg', function()
      MiniPick.builtin.files({ tool = 'git' }, { source = { name = ' Files (git)' } })
    end, { desc = 'Search all files in current working directory' })

    nmap('<leader>fl', function()
      MiniPick.builtin.files(
        { tool = 'fd' },
        { source = { cwd = env.LOCAL_SHARE_CONFIG_DIR .. 'nvim', name = ' Local share nvim files (fd)' } }
      )
    end, { desc = 'Search all files in local share nvim' })

    nmap('<leader>fm', function()
      MiniPick.builtin.files(
        { tool = 'git' },
        { source = { cwd = '~/p/eh/worktree/eh-mobile-pro/development', name = ' Files (master)' } }
      )
    end, { desc = 'Search files in mobile development branch' })

    nmap('<leader>;', function()
      MiniPick.builtin.buffers()
    end, { desc = 'All loaded buffers' })

    nmap('<leader>rs', function()
      MiniPick.builtin.resume()
    end, { desc = 'Resume search' })

    nmap('<leader>sh', function()
      MiniPick.builtin.help(nil, { source = { name = 'Help 🙌' } })
    end, { desc = 'Search help' })

    -- Search for a string in the current opened buffer
    nmap('<leader>f', function()
      MiniExtra.pickers.buf_lines({
        scope = 'current',
      }, {
        source = { name = ' Fuzzy search current buffer' },
      })
    end, { desc = 'Fuzzy search a string in current buffer' })

    -- Search for a string in the all loaded buffers
    nmap('<leader>F', function()
      MiniExtra.pickers.buf_lines()
    end, { desc = 'Search for a string in all loaded buffers' })

    -- Search old files
    nmap('<leader>?', function()
      MiniExtra.pickers.oldfiles()
    end, { desc = 'Search old files' })

    -- Search for a string in the current open buffers and get results live as typed
    nmap(';r', function()
      MiniPick.builtin.grep_live({ tool = 'rg' }, { source = { name = 'Grep buffers (rg)' } })
    end, { desc = 'Search for a string in the current open buffers' })

    -- Search all files in env.DOTFILES
    nmap('<leader>fc', function()
      MiniPick.builtin.files({ tool = 'fd' }, { source = { name = '.dotfiles (fd)', cwd = env.DOTFILES } })
    end, { desc = 'Search all files in .dotfiles' })

    -- Search for a string in .dotfiles
    nmap('<leader>sd', function()
      MiniPick.builtin.grep_live({ tool = 'rg' }, {
        source = { name = 'Grep .dotfiles (rg)', cwd = env.DOTFILES },
      })
    end, { desc = 'Search for a string in .dotfiles' })

    nmap('<leader>fn', function()
      MiniPick.builtin.files({ tool = 'fd' }, {
        source = { name = 'Notes (fd)', cwd = env.PERSONAL_NOTES },
      })
    end, { desc = ' All notes (fd)' })

    nmap('<leader>sn', function()
      MiniPick.builtin.grep_live(nil, {
        source = { name = 'Grep Notes', cwd = env.PERSONAL_NOTES },
      })
    end, { desc = 'Search for a string in Notes' })

    nmap('<leader>gbr', function()
      MiniExtra.pickers.git_branches(nil, { source = { name = ' Git branches' } })
    end, { desc = 'List all git branches' })

    nmap('<leader>d', function()
      MiniExtra.pickers.diagnostic({ scope = 'current' }, { source = { name = '  Diagnostics (current)' } })
    end, { desc = 'List all diagnostics in current buffer' })

    nmap('<leader>D', function()
      MiniExtra.pickers.diagnostic(nil, { source = { name = '  Diagnostics (all)' } })
    end, { desc = 'List all diagnostics in loaded buffers' })

    mapper({ 'n', 'v' })('<leader>sk', function()
      MiniExtra.pickers.keymaps()
    end, { desc = 'Search keymaps' })

    nmap('<leader>sg', function()
      MiniExtra.pickers.spellsuggest({ n_suggestions = 15 })
    end, { desc = 'Spell suggest word under cursor' })

    nmap('<leader>r', function()
      MiniExtra.pickers.visit_paths(nil, { source = { name = ' Frecently accessed files' } })
    end, { desc = 'MiniVisits List Paths' })
  end,
}
