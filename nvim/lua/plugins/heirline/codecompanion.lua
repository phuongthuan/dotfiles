local colors = require('core.colors')
local common = require('plugins.heirline.common')

local CodeCompanionChatBuffer = {
  condition = common.IsCodeCompanion,
  static = {
    chat_metadata = {},
  },
  init = function(self)
    local bufnr = vim.api.nvim_get_current_buf()
    if _G.codecompanion_chat_metadata then
      self.chat_metadata = _G.codecompanion_chat_metadata[bufnr]
    end
  end,
  update = {
    'User',
    pattern = {
      'CodeCompanionChatModel',
      'CodeCompanionChatOpened',
      'CodeCompanionRequest*',
      'CodeCompanionContextChanged',
    },
    callback = vim.schedule_wrap(function()
      vim.cmd('redrawstatus')
    end),
  },
  -- MODEL BLOCK --
  {
    condition = function(self)
      return self.chat_metadata
        and self.chat_metadata.adapter
        and self.chat_metadata.adapter.model
        and not _G.codecompanion_processing
    end,
    {
      provider = function(self)
        return '  ' .. self.chat_metadata.adapter.model .. ' '
      end,
      hl = { fg = colors.orange },
    },
  },
  -- CYCLES BLOCK --
  {
    condition = function(self)
      return self.chat_metadata and self.chat_metadata.cycles and self.chat_metadata.cycles > 0
    end,
    {
      provider = function(self)
        return '  ' .. self.chat_metadata.cycles .. ' '
      end,
      hl = { fg = colors.purple },
    },
  },
  {
    condition = function(self)
      return self.chat_metadata and self.chat_metadata.tokens and self.chat_metadata.tokens > 0
    end,
    {
      provider = function(self)
        return ' 󰔖 ' .. self.chat_metadata.tokens .. ' '
      end,
      hl = { fg = colors.aqua },
    },
  },
}

return { CodeCompanionChatBuffer }
