vim.pack.add({
  'https://github.com/nvim-mini/mini.pick',
  'https://github.com/nvim-mini/mini.extra',
  'https://github.com/nvim-mini/mini.visits',
})

local MiniPick = require('mini.pick')
local MiniExtra = require('mini.extra')
local MiniVisits = require('mini.visits')

local env = require('utils').env
local nmap = require('utils').nmap
local mapper = require('utils').mapper

-- Custom picker
local _default_source_opts = {
  source = {
    show = function(buf_id, items, query)
      MiniPick.default_show(buf_id, items, query, { show_icons = true })
    end,
  },
}

local _default_excludes = {
  '.DS_Store',
  '.git/',
  'node_modules/',
  '.next/',
  '.yarn/cache',
  'coverage/',
}

-- Picker for searching a literal string instead of regular expression (-F or --fixed-strings)
local grep_literal = function(local_opts, opts)
  local command = {
    'rg',
    '--column',
    '--line-number',
    '--no-heading',
    '--field-match-separator',
    '\\x00',
    '--no-follow',
    '--color=never',
    '--fixed-strings',
    '--hidden',
  }

  local globs = local_opts.globs or {}

  -- Add glob patterns to command
  for _, glob in ipairs(globs) do
    table.insert(command, '--glob=' .. glob)
  end

  opts = vim.tbl_deep_extend('force', _default_source_opts, opts or {})
  vim.list_extend(command, { '--', local_opts.pattern })

  return MiniPick.builtin.cli({ command = command }, opts)
end

-- Picker for searching files (include hidden files)
local find_files = function(local_opts, opts)
  local command = {
    'fd',
    '--type=f',
    '--no-follow',
    '--color=never',
    '--hidden',
  }

  local command_opts = local_opts.command_opts or {}
  local excludes = local_opts.excludes or _default_excludes

  -- Add --exclude option
  for _, ex in ipairs(excludes) do
    table.insert(command, '--exclude=' .. ex)
  end

  -- Add other options
  for _, co in ipairs(command_opts) do
    table.insert(command, co)
  end

  opts = vim.tbl_deep_extend('force', _default_source_opts, opts or {})
  vim.list_extend(command, { '--', local_opts.pattern })

  return MiniPick.builtin.cli({ command = command }, opts)
end

-- Picker for searching files (include hidden files)
local grep = function(local_opts, opts)
  local command = {
    'rg',
    '--type=f',
    '--no-follow',
    '--color=never',
    '--hidden',
  }
  opts = vim.tbl_deep_extend('force', _default_source_opts, opts or {})
  vim.list_extend(command, { '--', local_opts.pattern })

  return MiniPick.builtin.cli({ command = command }, opts)
end

-- Picker for controlling Music Player Client (MPC) using mpc commands
local open_music = function()
  MiniPick.start({
    source = {
      name = '  Music Player ',
      items = function()
        return {
          'Music',
          'Play',
          'Status',
          'Toggle',
          'Next',
          'Prev',
          'Repeat',
          'Single',
          'Random',
          'Consume',
          'Volume Up',
          'Volume Down',
        }
      end,
      choose = function(item)
        local selected_command = string.lower(item)

        local mapped_command = function(i)
          if i == 'Volume Up' then
            return 'volume +10'
          elseif i == 'Volume Down' then
            return 'volume -10'
          else
            return selected_command
          end
        end

        if selected_command == 'status' then
          vim.system({ 'mpc', selected_command }, { text = true }, function(res)
            vim.notify(res.stdout)
          end)
          return
        else
          vim.system(
            {
              'mpc',
              unpack(vim.split(mapped_command(item), ' ')),
            }
            -- { text = true }
            -- function()
            -- vim.notify('  ' .. item .. ' (Music Player)')
            -- end
          )
        end
      end,
    },
  })
end

-- Check if current working directory is the eh-mobile-pro repository
-- Returns true for:
--   - Main repo: ~/p/eh/eh-mobile-pro
--   - Any worktree: ~/p/eh/worktree/eh-mobile-pro/*
local _is_mobile_repo = function()
  local current_dir = vim.fn.getcwd()
  local eh_mobile_pro_path = env.COMPANY_REPO_DIR .. '/eh-mobile-pro'
  local worktree_base = env.COMPANY_REPO_DIR .. '/worktree/eh-mobile-pro'

  -- Check main repo or any path under worktree/eh-mobile-pro/
  return current_dir == eh_mobile_pro_path or current_dir:find(worktree_base, 1, true) == 1
end

local _mobile_repo_globs = { '!ContractPdfPreview', '!*.cjs', '!coverage/' }

-- Centered on screen
-- Adaptive width based on screen size:
--   - Small monitors (<=200 cols): Use full width
--   - Large monitors (>200 cols): Use 55% width for better focus
local window_config = function()
  local height = math.floor(0.55 * vim.o.lines)
  local columns = vim.o.columns
  local width_threshold = 200 -- Threshold to distinguish small vs large monitors

  -- Use full width for small monitors, 55% for large monitors
  local width = columns <= width_threshold and columns or math.floor(0.55 * columns)

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

MiniExtra.setup()
MiniVisits.setup()
MiniPick.setup({
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

local nvim_excludes = {
  'karabiner/automatic_backups/',
  'nvim-pack-lock.json',
  'lazy-lock.json',
}

local nvim_globs = {
  '!karabiner/automatic_backups/',
  '!nvim-pack-lock.json',
  '!lazy-lock.json',
}

nmap('<leader>,', function()
  local excludes = _is_mobile_repo()
      and {
        'ContractPdfPreview/',
        '*.cjs',
        'coverage/',
        'android/',
        'fastlane/',
        'ios/**/Contents.json',
        'ios/**/*.ttf',
      }
    or nvim_excludes

  local command_opts = _is_mobile_repo() and {} or { '--no-ignore' }

  find_files(
    { tool = 'fd', excludes = excludes, command_opts = command_opts },
    { source = { name = ' Files (fd)' } }
  )
end, { desc = 'Current Directory (fd)' })

nmap('<leader>fA', function()
  local command_opts = _is_mobile_repo() and {} or { '--no-ignore' }
  find_files({ tool = 'fd', command_opts = command_opts }, { source = { name = ' Files (fd)' } })
end, { desc = 'Current Directory (fd) without excludes' })

nmap('<leader>m', function()
  open_music()
end, { desc = 'Open MPC' })

nmap('<leader>pw', function()
  -- current word under cursor in the current buffer
  local word = vim.fn.expand('<cword>')
  local globs = _is_mobile_repo() and _mobile_repo_globs or nil
  grep_literal({ pattern = word, globs = globs }, { source = { name = 'Grep (rg): ' .. word } })
end, { desc = 'Word Under Cursor' })

nmap('<leader>pl', function()
  local globs = _is_mobile_repo() and _mobile_repo_globs or nil
  grep_literal({ pattern = ':>> ', globs = globs }, { source = { name = '  Grep console.log (rg)' } })
end, { desc = 'console.log' })

nmap('<leader>ps', function()
  local string = vim.fn.input('Grep String: ')

  -- If input is empty, hide the input prompt instead of showing empty window
  if string == '' then
    return
  end

  local globs = _is_mobile_repo() and _mobile_repo_globs or nvim_globs

  grep_literal({ pattern = string, globs = globs }, { source = { name = 'Grep literal string (rg): ' .. string } })
end, { desc = 'Literal String' })

nmap('<leader>fe', function()
  find_files({ tool = 'fd' }, {
    source = {
      cwd = env.EH_REPOSITORY_DIR,
      name = 'Files EH (fd)',
    },
  })
end, { desc = 'Files EH (fd)' })

nmap('<leader>fr', function()
  find_files({ tool = 'fd' }, {
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

  find_files(
    { tool = 'fd', excludes = excludes },
    { source = { cwd = env.LOCAL_SHARE_CONFIG_DIR .. 'nvim', name = ' Local share nvim files (fd)' } }
  )
end, { desc = '~/.local/share/nvim' })

nmap('<leader>fm', function()
  local excludes = _is_mobile_repo() and { 'ContractPdfPreview/', '*.cjs' } or nil
  find_files(
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
  MiniExtra.pickers.oldfiles()
end, { desc = 'Old' })

nmap(';r', function()
  MiniPick.builtin.grep_live({ tool = 'rg' }, { source = { name = 'Grep buffers (rg)' } })
end, { desc = 'Grep Live (buffers)' })

nmap('<leader>fd', function()
  find_files({ tool = 'fd' }, {
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
