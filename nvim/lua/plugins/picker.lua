local env = require('core.env')
local mapper = require('core.utils').mapper_factory
local Picker = require('core.my-picker')

local nmap = mapper('n')

local _is_mobile_repo = function()
  local current_dir = vim.fn.getcwd()
  local eh_mobile_pro_path = env.EH_REPOSITORY_DIR .. '/eh-mobile-pro'
  return current_dir == eh_mobile_pro_path
end

return {
  'echasnovski/mini.pick',
  version = false,
  config = function()
    -- Extra pickers for mini.pick
    require('mini.extra').setup()
    require('mini.visits').setup()

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

    nmap('<leader>,', function()
      local excludes = _is_mobile_repo() and { 'ContractPdfPreview/', '*.cjs' } or nil
      local command_opts = _is_mobile_repo() and {} or { '--no-ignore' }

      Picker.find_files(
        { tool = 'fd', excludes = excludes, command_opts = command_opts },
        { source = { name = ' Files (fd)' } }
      )
    end, { desc = 'Current Directory (fd)' })

    nmap('<leader>m', function()
      Picker.open_music()
    end, { desc = 'Open MPC' })

    nmap('<leader>pw', function()
      -- current word under cursor in the current buffer
      local word = vim.fn.expand('<cword>')

      local globs = _is_mobile_repo() and { '!ContractPdfPreview', '!*.cjs' } or nil

      Picker.grep_literal({ pattern = word, globs = globs }, { source = { name = 'Grep (rg): ' .. word } })
    end, { desc = 'Word Under Cursor' })

    nmap('<leader>pl', function()
      local globs = _is_mobile_repo() and { '!ContractPdfPreview', '!*.cjs' } or nil

      Picker.grep_literal({ pattern = ':>> ', globs = globs }, { source = { name = '  Grep console.log (rg)' } })
    end, { desc = 'console.log' })

    nmap('<leader>ps', function()
      local string = vim.fn.input('Input String')

      -- If input is empty, hide the input prompt instead of showing empty window
      if string == '' then
        return
      end

      local globs = _is_mobile_repo() and { '!ContractPdfPreview', '!*.cjs' } or nil

      Picker.grep_literal(
        { pattern = string, globs = globs },
        { source = { name = 'Grep literal string (rg): ' .. string } }
      )
    end, { desc = 'Literal String' })

    nmap('<leader>fe', function()
      Picker.find_files({ tool = 'fd' }, {
        source = {
          cwd = env.EH_REPOSITORY_DIR,
          name = 'Files EH (fd)',
        },
      })
    end, { desc = 'Files EH (fd)' })

    nmap('<leader>fR', function()
      Picker.find_files({ tool = 'fd' }, {
        source = {
          cwd = env.REFERENCES_DIR,
          name = 'References (fd)',
        },
      })
    end, { desc = 'Files References (fd)' })

    nmap('<leader>fg', function()
      MiniPick.builtin.files({ tool = 'git' }, { source = { name = ' Files (git)' } })
    end, { desc = 'Git (git)' })

    nmap('<leader>fl', function()
      local excludes = {
        'mason/packages/**',
        '**/tests/screenshots/**',
        '**/tests/**',
        '*.node',
        '*.history',
        '*.png',
      }

      Picker.find_files(
        { tool = 'fd', excludes = excludes },
        { source = { cwd = env.LOCAL_SHARE_CONFIG_DIR .. 'nvim', name = ' Local share nvim files (fd)' } }
      )
    end, { desc = '~/.local/share/nvim' })

    nmap('<leader>fm', function()
      local excludes = _is_mobile_repo() and { 'ContractPdfPreview/', '*.cjs' } or nil
      Picker.find_files(
        { tool = 'fd', excludes = excludes },
        { source = { cwd = '~/p/eh/worktree/eh-mobile-pro/development', name = ' Files (eh-mobile-pro)' } }
      )
    end, { desc = 'eh-mobile-pro (dev)' })

    nmap('<leader>;', function()
      MiniPick.builtin.buffers()
    end, { desc = 'Opened Buffers' })

    nmap('<leader>rs', function()
      MiniPick.builtin.resume()
    end, { desc = 'Resume Search' })

    mapper({ 'n', 'v' })('<leader>sh', function()
      MiniPick.builtin.help(nil, { source = { name = 'Helps  ' } })
    end, { desc = 'Search Helps' })

    nmap('<leader>bs', function()
      MiniExtra.pickers.buf_lines({
        scope = 'current',
      }, {
        source = { name = ' Fuzzy Search Current Buffer' },
      })
    end, { desc = 'Fuzzy Search (current buffer)' })

    nmap('<leader>F', function()
      MiniExtra.pickers.buf_lines()
    end, { desc = 'Grep String (buffers)' })

    nmap('<leader>fo', function()
      MiniExtra.pickers.oldfiles()
    end, { desc = 'Old' })

    nmap(';r', function()
      MiniPick.builtin.grep_live({ tool = 'rg' }, { source = { name = 'Grep buffers (rg)' } })
    end, { desc = 'Grep Live (buffers)' })

    nmap('<leader>fc', function()
      Picker.find_files({ tool = 'fd' }, {
        source = {
          cwd = env.DOTFILES,
          name = '.dotfiles (fd)',
        },
      })
    end, { desc = 'Config (.dotfiles)' })

    nmap('<leader>sd', function()
      MiniPick.builtin.grep_live({ tool = 'rg' }, {
        source = { name = 'Grep .dotfiles (rg)', cwd = env.DOTFILES },
      })
    end, { desc = 'Grep Live (.dotfiles)' })

    nmap('<leader>fn', function()
      MiniPick.builtin.files({ tool = 'fd' }, {
        source = { name = 'Notes (fd)', cwd = env.PERSONAL_NOTES },
      })
    end, { desc = 'Notes (fd)' })

    nmap('<leader>sn', function()
      MiniPick.builtin.grep_live(nil, {
        source = { name = 'Grep Notes', cwd = env.PERSONAL_NOTES },
      })
    end, { desc = 'Grep Live Notes' })

    nmap('<leader>gbr', function()
      MiniExtra.pickers.git_branches(nil, { source = { name = ' Git branches' } })
    end, { desc = 'All Branches' })

    mapper({ 'n', 'v' })('<leader>sk', function()
      MiniExtra.pickers.keymaps()
    end, { desc = 'Search Keymaps' })

    nmap('<leader>us', function()
      MiniExtra.pickers.spellsuggest({ n_suggestions = 15 })
    end, { desc = 'Spell Suggest Word' })

    nmap('<leader>fr', function()
      MiniExtra.pickers.visit_paths(nil, { source = { name = ' Frecently accessed files' } })
    end, { desc = 'Frecently Accessed' })
  end,
}
