local env = require('core.env')
local colors = require('core.colors')
local conditions = require('heirline.conditions')
local common = require('plugins.heirline.common')

local VimLogo = { provider = ' ', hl = 'VimLogo' }

local GitHubActionWorkflowIcon = {
  condition = common.IsGitHubActionWorkflow,
  provider = function()
    return ' '
  end,
  hl = { fg = colors.purple, bold = true },
  on_click = {
    callback = function()
      local repo = 'eh-mobile-pro'
      local user = env.GITHUB_USERNAME
      local workflow = vim.fn.expand('%:t')

      -- Build the URL (no workflow specified)
      local url =
        string.format('https://github.com/Thinkei/%s/actions/workflows/%s?query=actor%%3A%s', repo, workflow, user)

      vim.fn.system({ 'open', url })

      vim.notify('📦 Opening GitHub Actions: ' .. url, vim.log.levels.INFO)
    end,
    name = 'wb_gha_workflow_click',
  },
}

local FileIcon = {
  init = function(self)
    self.icon, self.icon_color = common.GetFileIcons()
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
  init = function(self)
    self.is_gha_workflow = common.IsGitHubActionWorkflow()
    self.icon, self.icon_color = common.GetFileIcons()
  end,
  provider = function(self)
    if self.is_gha_workflow then
      return GitHubActionWorkflowIcon.provider()
    else
      return FileIcon.provider(self)
    end
  end,
  hl = function(self)
    if self.is_gha_workflow then
      return GitHubActionWorkflowIcon.hl
    else
      return FileIcon.hl(self)
    end
  end,
  on_click = {
    callback = function(self)
      if self.is_gha_workflow then
        GitHubActionWorkflowIcon.on_click.callback()
      end
    end,
    name = 'wb_filetype_click',
  },
}

local FileName = {
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

    return filename
  end,
  hl = function()
    if vim.bo.modified then
      return { fg = colors.aqua, bold = true, force = true }
    else
      return { fg = colors.bright_fg }
    end
  end,
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

return {
  FileType,
  FileName,
  FileSize,
  FileFlags,
  { provider = '%=' },
  VimLogo,
}
