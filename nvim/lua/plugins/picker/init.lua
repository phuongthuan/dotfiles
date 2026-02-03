local env = require('core.env')
local functions = require('core.functions')

local mapper = require('core.utils').mapper_factory
local Picker = require('plugins.picker.custom')

local nmap = mapper('n')

local _mobile_repo_globs = { '!ContractPdfPreview', '!*.cjs', '!coverage/' }

local _mobile_repo_excludes = {
  'ContractPdfPreview/',
  '*.cjs',
  'coverage/',
  'android/',
  'fastlane/',
  'ios/**/Contents.json',
  'ios/**/*.ttf',
  'ios/**/*.xcassets*/*',
}

-- Centered on screen
-- Adaptive width based on screen size:
--   - Small monitors (<=200 cols): Use full width
--   - Large monitors (>200 cols): Use 55% width for better focus
local window_config = function()
  local height = math.floor(0.55 * vim.o.lines)
  local columns = vim.o.columns
  local width_threshold = 200 -- Threshold to distinguish small vs large monitors

  -- Use full width for small monitors, 55% for large monitors
  local width = columns <= width_threshold and columns or math.floor(0.45 * columns)

  return {
    anchor = 'NW',
    height = height,
    width = width,

    -- row = math.floor(0.5 * (vim.o.lines - height)),
    -- positions the window 0 row down from the top of the editor.
    row = 0,
    col = math.floor(0.5 * (columns - width)),
    border = 'rounded',
  }
end

return {
  {
    'nvim-mini/mini.pick',
    version = false,
    dependencies = {
      { 'nvim-mini/mini.extra', opts = {} },
      { 'nvim-mini/mini.visits', opts = {} },
    },
    config = function()
      require('mini.pick').setup({
        mappings = {
          choose_in_split = '<C-s>',
          move_down = '<C-j>',
          move_up = '<C-k>',
          scroll_down = '<C-d>',
          scroll_left = '<C-sl>',
          scroll_right = '<C-sr>',
          scroll_up = '<C-u>',
          delete_left = '<C-dl>',
        },
        window = {
          prompt_prefix = '  ',
          config = window_config,
        },
        options = { content_from_bottom = true },
      })

      vim.ui.select = MiniPick.ui_select

      nmap('<leader>,', function()
        local excludes = functions.is_eh_mobile_pro_repo() and _mobile_repo_excludes or nil

        local command_opts = functions.is_eh_mobile_pro_repo() and {} or { '--no-ignore' }

        Picker.find_files(
          { tool = 'fd', excludes = excludes, command_opts = command_opts },
          { source = { name = ' Files (fd)' } }
        )
      end, { desc = 'Current Directory (fd)' })

      nmap('<leader>fA', function()
        local command_opts = functions.is_eh_mobile_pro_repo() and {} or { '--no-ignore' }
        Picker.find_files({ tool = 'fd', command_opts = command_opts }, { source = { name = ' Files (fd)' } })
      end, { desc = 'Current Directory (fd) without excludes' })

      nmap('<leader>om', function()
        Picker.open_music()
      end, { desc = 'Open MPC' })

      nmap('<leader>pw', function()
        -- current word under cursor in the current buffer
        local word = vim.fn.expand('<cword>')

        local globs = functions.is_eh_mobile_pro_repo() and _mobile_repo_globs or nil

        Picker.grep_literal({ pattern = word, globs = globs }, { source = { name = 'Grep (rg): ' .. word } })
      end, { desc = 'Word Under Cursor' })

      nmap('<leader>pl', function()
        local globs = functions.is_eh_mobile_pro_repo() and _mobile_repo_globs or nil

        Picker.grep_literal({ pattern = ':>> ', globs = globs }, { source = { name = '  Grep console.log (rg)' } })
      end, { desc = 'console.log' })

      nmap('<leader>ps', function()
        local string = vim.fn.input('Grep String: ')

        -- If input is empty, hide the input prompt instead of showing empty window
        if string == '' then
          return
        end

        local globs = functions.is_eh_mobile_pro_repo() and _mobile_repo_globs or nil

        Picker.grep_literal(
          { pattern = string, globs = globs },
          { source = { name = 'Grep literal string (rg): ' .. string } }
        )
      end, { desc = 'Literal String' })

      nmap('<leader>fe', function()
        Picker.find_files({ tool = 'fd', excludes = _mobile_repo_excludes }, {
          source = {
            cwd = env.EH_REPOSITORY_DIR,
            name = 'Files EH (fd)',
          },
        })
      end, { desc = 'Files EH (fd)' })

      nmap('<leader>fr', function()
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
          'harpoon/**',
          'karabiner/automatic_backups/**',
          'codecompanion/**/*.json',
          'codecompanion-history/**/*.json',
          '**/tests/screenshots/**',
          '**/tests/**',
          '**/spec/**',
          '*.node',
          '*.spec.lua',
          '*spec.lua',
          '*.rockspec',
          '*.history',
          '*.png',
        }

        Picker.find_files(
          { tool = 'fd', excludes = excludes },
          { source = { cwd = env.LOCAL_SHARE_CONFIG_DIR .. 'nvim', name = ' Local share nvim files (fd)' } }
        )
      end, { desc = '~/.local/share/nvim' })

      nmap('<leader>fmd', function()
        local excludes = functions.is_eh_mobile_pro_repo() and _mobile_repo_excludes or nil
        Picker.find_files(
          { tool = 'fd', excludes = excludes },
          { source = { cwd = '~/p/eh/worktree/eh-mobile-pro/dev', name = ' Files (eh-mobile-pro)' } }
        )
      end, { desc = 'eh-mobile-pro (development)' })

      nmap('<leader>fmm', function()
        local excludes = functions.is_eh_mobile_pro_repo() and _mobile_repo_excludes or nil
        Picker.find_files(
          { tool = 'fd', excludes = excludes },
          { source = { cwd = '~/p/eh/worktree/eh-mobile-pro/master', name = ' Files (eh-mobile-pro)' } }
        )
      end, { desc = 'eh-mobile-pro (master)' })

      nmap('<leader>pm', function()
        local string = vim.fn.input('Grep eh-mobile-pro(development): ')

        -- If input is empty, hide the input prompt instead of showing empty window
        if string == '' then
          return
        end

        Picker.grep_literal(
          { pattern = string, globs = _mobile_repo_globs },
          { source = { name = 'Grep literal string (rg): ' .. string } }
        )
      end, { desc = 'Literal String (eh-mobile-pro)' })

      nmap('<leader>;', function()
        MiniPick.builtin.buffers()
      end, { desc = 'Opened Buffers' })

      nmap('<leader>rs', function()
        local ok = pcall(MiniPick.builtin.resume)
        if not ok then
          vim.notify('No picker to resume  ', vim.log.levels.WARN)
        end
      end, { desc = 'Resume Search' })

      mapper({ 'n', 'v' })('<leader>sh', function()
        MiniPick.builtin.help(nil, { source = { name = 'Helps ' } })
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
        local ok = pcall(MiniExtra.pickers.oldfiles)
        if not ok then
          vim.notify('No old files found  ', vim.log.levels.WARN)
        end
      end, { desc = 'Old files' })

      nmap(';r', function()
        MiniPick.builtin.grep_live({ tool = 'rg' }, { source = { name = 'Grep buffers (rg)' } })
      end, { desc = 'Grep Live (buffers)' })

      nmap('<leader>fd', function()
        Picker.find_files({ tool = 'fd' }, {
          source = {
            cwd = env.DOTFILES,
            name = '.dotfiles (fd)',
          },
        })
      end, { desc = '.dotfiles' })

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

      nmap('<leader>ff', function()
        MiniExtra.pickers.visit_paths(nil, { source = { name = ' Frecently accessed files' } })
      end, { desc = 'Frecently Accessed' })
    end,
  },
}
