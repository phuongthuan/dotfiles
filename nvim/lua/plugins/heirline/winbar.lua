local colors = require('core.colors')
local utils = require('heirline.utils')
local conditions = require('heirline.conditions')

local Spacer = { provider = ' ' }

local VimLogo = { provider = ' ', hl = 'VimLogo' }

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. ' ')
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileType = {
  condition = function()
    return vim.bo.filetype ~= ''
  end,
  FileIcon,
}

local FileName = {
  provider = function(self)
    -- first, trim the pattern relative to the current directory. For other
    -- options, see :h filename-modifers
    local filename = vim.fn.fnamemodify(self.filename, ':.')
    if filename == '' then
      return '[No Name]'
    end
    -- now, if the filename would occupy more than 1/4th of the available
    -- space, we trim the file path to its initials
    -- See Flexible Components section below for dynamic truncation
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
  hl = { fg = colors.bright_fg },
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = ' ',
    hl = { fg = colors.red },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = ' ',
    hl = { fg = colors.orange },
  },
}

local FileNameModifer = {
  hl = function()
    if vim.bo.modified then
      return { fg = colors.aqua, bold = true, force = true }
    end
  end,
}

local FileSize = {
  provider = function()
    -- stackoverflow, compute human readable file size
    local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
    fsize = (fsize < 0 and 0) or fsize
    if fsize < 1024 then
      return ' [~' .. fsize .. suffix[1] .. '] '
    end
    local i = math.floor((math.log(fsize) / math.log(1024)))
    return ' [~' .. string.format('%.2g%s', fsize / math.pow(1024, i), suffix[i + 1]) .. '] '
  end,
  hl = { fg = colors.purple },
}

return utils.insert(
  FileNameBlock,
  FileType,
  utils.insert(FileNameModifer, FileName),
  FileSize,
  FileFlags,
  { provider = '%=' },
  VimLogo
)
