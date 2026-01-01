local colors = require('core.colors')
local icons = require('core.icons')
local conditions = require('heirline.conditions')

local Spacer = { provider = ' ' }

local IsCodeCompanion = function()
  return vim.bo.filetype == 'codecompanion'
end

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

local Git = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,
  hl = { fg = colors.orange },
  Spacer,
  {
    provider = function(self)
      return ' ' .. self.status_dict.head
    end,
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = '[',
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ('+' .. count)
    end,
    hl = { fg = colors.green },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ('-' .. count)
    end,
    hl = { fg = colors.red },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ('~' .. count)
    end,
    hl = { fg = colors.yellow },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ']',
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
  conditifn = function(self)
    return not conditions.buffer_matches({
      filetype = self.filetypes,
    }) and not IsCodeCompanion() and not vim.bo.filetype == 'minifiles'
  end,
  provider = function()
    local filename = vim.fn.expand('%:t')
    if filename == '' then
      return ' [No Name] '
    end
    return ' ' .. filename .. ' '
  end,
  hl = { fg = colors.bright_fg, bold = true },
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

-- FILETYPE --
local FileType = {
  provider = function()
    return ' ' .. vim.bo.filetype .. ' '
  end,
  hl = { fg = colors.purple },
}

-- LINE & COLUMN --
local LineCol = {
  provider = function()
    local line = vim.fn.line('.')
    local col = vim.fn.col('.')
    return string.format(' L%d:C%d ', line, col)
  end,
  hl = { fg = colors.black, bg = colors.bright_fg },
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
    return ' 󰿘 [' .. table.concat(names, ' ') .. ']'
  end,
  hl = { fg = colors.yellow, bold = true },
}

-- I take no credits for this! 🦁
local ScrollBar = {
  static = {
    sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
    -- Another variant, because the more choice the better.
    -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = colors.blue, bg = colors.bright_bg },
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
  },
}

return {
  static = {
    left_pad = Spacer,
    right_pad = Spacer,
  },
  hl = function()
    if conditions.is_active() then
      return { bg = colors.bright_bg, fg = colors.bright_fg }
    else
      return { bg = colors.black, fg = colors.gray }
    end
  end,
  ViMode,
  Git,
  FileName,
  Diagnostics,
  { provider = '%=' },
  LSP,
  FileType,
  -- FileEncoding,
  -- ScrollBar,
  Ruler,
}
