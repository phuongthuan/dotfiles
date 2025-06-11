local M = {}

-- Picker for searching a literal string instead of regular expression (-F or --fixed-strings)
M.grep_literal = function(local_opts, opts)
  local pick = require('mini.pick')
  local res = {
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
  vim.list_extend(res, { '--', local_opts.pattern })
  return pick.builtin.cli({ command = res }, opts)
end

-- Picker for searching files (include hidden files)
M.find_files = function(local_opts, opts)
  local pick = require('mini.pick')
  local res = {
    'fd',
    '--type=f',
    '--no-follow',
    '--color=never',
    '--hidden',
    '--exclude=.git/',
  }
  vim.list_extend(res, { '--', local_opts.pattern })
  return pick.builtin.cli({ command = res }, opts)
end

-- Picker for searching files (include hidden files)
M.grep = function(local_opts, opts)
  local pick = require('mini.pick')
  local res = {
    'rg',
    '--type=f',
    '--no-follow',
    '--color=never',
    '--hidden',
  }
  vim.list_extend(res, { '--', local_opts.pattern })
  return pick.builtin.cli({ command = res }, opts)
end

-- Picker for controlling Music Player Client (MPC) using mpc commands
M.open_music = function()
  local pick = require('mini.pick')

  pick.start({
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
            },
            { text = true }
            -- function()
            -- vim.notify('  ' .. item .. ' (Music Player)')
            -- end
          )
        end
      end,
    },
  })
end

return M
