local env = require('core.env')
local colors = require('core.colors')
local icons = require('core.icons')
local conditions = require('heirline.conditions')
local common = require('plugins.heirline.common')
local Overseer = require('plugins.heirline.overseer')
local CodeCompanionChatBuffer = require('plugins.heirline.codecompanion')

local disabled_filetypes = function(self)
  return not conditions.buffer_matches({
    filetype = self.filetypes,
  }) and not common.IsCodeCompanion()
end

local Spacer = { provider = ' ' }

local ViMode = {
  static = {
    mode_names = {
      n = '',
      no = '?',
      nov = '?',
      noV = '?',
      ['no\22'] = '?',
      niI = 'i',
      niR = 'r',
      niV = 'v',
      nt = 't',
      v = '',
      vs = '',
      V = '',
      Vs = '',
      ['\22'] = '^V',
      ['\22s'] = '^V',
      s = 'S',
      S = 'S_',
      ['\19'] = '^S',
      i = 'I',
      ic = 'Ic',
      ix = 'Ix',
      R = 'R',
      Rc = 'Rc',
      Rx = 'Rx',
      Rv = 'Rv',
      Rvc = 'Rv',
      Rvx = 'Rv',
      c = 'C',
      cv = 'Ex',
      r = '...',
      rm = 'M',
      ['r?'] = '?',
      ['!'] = '!',
      t = '  ',
    },
    mode_colors = {
      n = colors.aqua,
      i = colors.green,
      v = colors.purple,
      V = colors.purple,
      ['\22'] = colors.purple,
      c = colors.orange,
      s = colors.purple,
      S = colors.purple,
      ['\19'] = colors.purple,
      R = colors.red,
      r = colors.red,
      ['!'] = colors.red,
      t = colors.dark_red,
    },
  },
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  provider = function(self)
    return '%2(' .. self.mode_names[self.mode] .. '%) '
  end,
  hl = function(self)
    local mode = self.mode
    return {
      bg = self.mode_colors[mode],
      fg = colors.black,
      bold = true,
    }
  end,
  update = {
    'ModeChanged',
    pattern = '*:*',
    callback = vim.schedule_wrap(function()
      vim.cmd('redrawstatus')
    end),
  },
}

local GitIcon = {
  provider = function()
    return '  '
  end,
  hl = { fg = colors.purple },
  on_click = {
    callback = function(self)
      local branch = self.status_dict.head
      if branch then
        vim.fn.setreg('+', branch)
        vim.notify('Copied branch  "' .. branch .. '" to clipboard ✔', vim.log.levels.INFO)
      else
        vim.notify('Could not determine branch name', vim.log.levels.WARN)
      end
    end,
    name = 'sl_git_branch_icon_click',
  },
}

local GitHubActionsIcon = {
  condition = function(self)
    return conditions.is_git_repo() and not conditions.buffer_matches({
      filetype = self.filetypes,
    })
  end,
  provider = function()
    return '  '
  end,
  hl = { fg = colors.bright_fg, bold = true },
  on_click = {
    callback = function()
      local repo = 'eh-mobile-pro'
      local user = env.GITHUB_USERNAME

      -- Build the URL (no workflow specified)
      local url = string.format('https://github.com/Thinkei/%s/actions?query=actor%%3A%s', repo, user)

      vim.fn.system({ 'open', url })

      vim.notify(' Opening GitHub Actions: ' .. url, vim.log.levels.INFO)
    end,
    name = 'sl_gha_click',
  },
}

local Git = {
  condition = function(self)
    return conditions.is_git_repo() and not conditions.buffer_matches({
      filetype = self.filetypes,
    })
  end,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.added_count = self.status_dict.added or 0
    self.removed_count = self.status_dict.removed or 0
    self.changed_count = self.status_dict.changed or 0
  end,
  hl = { fg = colors.orange },
  GitIcon,
  {
    provider = function(self)
      return self.status_dict.head
    end,
    on_click = {
      callback = function(self)
        -- Get PR URL using gh CLI
        local branch = self.status_dict.head
        local pr_url_id = vim.trim(vim.fn.system({ 'gh', 'pr', 'view', branch, '--json', 'url', '--jq', '.url' }))

        if pr_url_id ~= '' then
          vim.fn.system({ 'open', pr_url_id })
          vim.notify(' Opening PR: ' .. pr_url_id, vim.log.levels.INFO)
        else
          vim.notify('No PR found !', vim.log.levels.WARN)
        end
      end,
      name = 'sl_git_branch_name_click',
    },
  },
  {
    condition = function(self)
      return self.added_count > 0 or self.removed_count > 0 or self.changed_count > 0
    end,
    provider = '(',
  },
  {
    provider = function(self)
      local count = self.added_count
      return count > 0 and ('+' .. count)
    end,
    hl = { fg = colors.green },
  },
  {
    provider = function(self)
      local count = self.removed_count
      return count > 0 and ('-' .. count)
    end,
    hl = { fg = colors.red },
  },
  {
    provider = function(self)
      local count = self.changed_count
      return count > 0 and ('~' .. count)
    end,
    hl = { fg = colors.yellow },
  },
  {
    condition = function(self)
      return self.added_count > 0 or self.removed_count > 0 or self.changed_count > 0
    end,
    provider = ')',
  },
}

local Diagnostics = {
  condition = conditions.has_diagnostics,
  static = {
    error_icon = icons.diagnostics.error,
    warn_icon = icons.diagnostics.warn,
    info_icon = icons.diagnostics.info,
    hint_icon = icons.diagnostics.hint,
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  end,
  Spacer,
  {
    condition = function(self)
      return self.errors > 0
    end,
    provider = function(self)
      return self.error_icon .. self.errors .. ' '
    end,
    hl = { fg = colors.red },
  },
  {
    condition = function(self)
      return self.warnings > 0
    end,
    provider = function(self)
      return self.warn_icon .. self.warnings .. ' '
    end,
    hl = { fg = colors.yellow },
  },
  {
    condition = function(self)
      return self.infos > 0
    end,
    provider = function(self)
      return self.info_icon .. self.infos .. ' '
    end,
    hl = { fg = colors.light_blue },
  },
  {
    condition = function(self)
      return self.hints > 0
    end,
    provider = function(self)
      return self.hint_icon .. self.hints .. ' '
    end,
    hl = { fg = colors.aqua },
  },
}

local FileName = {
  condition = disabled_filetypes,
  provider = function()
    local filename = vim.fn.expand('%:t')

    if filename == '' then
      return '[No Name]'
    end

    return ' ' .. filename .. ' '
  end,
  hl = { fg = colors.bright_fg, bold = true },
  on_click = {
    callback = function()
      require('aerial').toggle()
    end,
    name = 'wb_filename_click',
  },
}

local Filepath = {
  condition = disabled_filetypes,
  provider = function()
    local filename

    if package.loaded.oil then
      filename = require('oil').get_current_dir()
    end

    if not filename then
      filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
    end

    if filename == '' then
      return '[No Name]'
    end

    if not conditions.width_percent_below(#filename, 0.90) then
      filename = vim.fn.pathshorten(filename)
    end

    return ' ' .. filename .. ' '
  end,
  hl = { fg = colors.bright_fg, bold = true },
  on_click = {
    callback = function()
      require('aerial').toggle()
    end,
    name = 'wb_filename_click',
  },
}

local FileIcon = {
  condition = function()
    return vim.bo.filetype ~= ''
  end,
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (' ' .. self.icon)
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileType = {
  provider = function()
    return ' ' .. vim.bo.filetype .. ' '
  end,
  hl = { fg = colors.purple },
}

local FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
    return enc ~= 'utf-8' and enc:upper()
  end,
  hl = { fg = colors.gray },
}

local LSP = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },
  provider = function()
    local names = {}
    for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      table.insert(names, server.name)
    end
    -- return ' 󰿘 [' .. table.concat(names, ' ') .. ']'
    return '  [' .. table.concat(names, ' ') .. ']'
  end,
  hl = { fg = colors.yellow, bold = true },
  on_click = {
    callback = function()
      vim.defer_fn(function()
        vim.cmd('LspInfo')
      end, 100)
    end,
    name = 'sl_lsp_click',
  },
}

local ScrollBar = {
  static = {
    -- sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
    sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' },
  },
  condition = disabled_filetypes,
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = colors.purple },
}

local Ruler = {
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    })
  end,
  {
    provider = '',
    hl = { fg = colors.bright_fg },
  },
  {
    -- %L = number of lines in the buffer
    -- %P = percentage through file of displayed window
    provider = ' %P% /%2L ',
    hl = {
      fg = colors.bright_bg,
      bg = colors.bright_fg,
    },
    on_click = {
      callback = function()
        local line = vim.api.nvim_win_get_cursor(0)[1]
        local total_lines = vim.api.nvim_buf_line_count(0)

        if math.floor((line / total_lines)) > 0.5 then
          vim.cmd('normal! gg')
        else
          vim.cmd('normal! G')
        end
      end,
      name = 'sl_ruler_click',
    },
  },
}

return {
  static = {
    filetypes = {
      '^git.*',
      '^minifiles$',
      '^toggleterm$',
      '^Neogit',
      '^health',
      'oil',
    },
    force_inactive_filetypes = {
      '^netrw$',
    },
  },
  condition = function(self)
    return not conditions.buffer_matches({
      filetype = self.force_inactive_filetypes,
    })
  end,
  {
    ViMode,
    ScrollBar,
    Git,
    GitHubActionsIcon,
    FileName,
    Diagnostics,
    CodeCompanionChatBuffer,
    { provider = '%=' },
    Overseer,
    LSP,
    FileType,
    Ruler,
  },
}
