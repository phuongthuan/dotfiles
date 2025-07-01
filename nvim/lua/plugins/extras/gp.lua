return {
  'robitx/gp.nvim',
  dependencies = { 'zbirenbaum/copilot.lua' },
  event = 'VeryLazy',
  keys = {
    -- Chat commands
    { '<leader>ac', '<cmd>GpChatNew<cr>', mode = 'n', desc = 'New Chat' },
    { '<leader>at', '<cmd>GpChatToggle tabnew<cr>', mode = 'n', desc = 'Toggle Chat' },
    { '<leader>af', '<cmd>GpChatFinder<cr>', mode = 'n', desc = 'Chat Finder' },

    { '<leader>ac', ":<C-u>'<,'>GpChatNew<cr>", mode = 'v', desc = 'Chat New' },
    { '<leader>ap', ":<C-u>'<,'>GpChatPaste<cr>", mode = 'v', desc = 'Chat Paste' },
    { '<leader>at', ":<C-u>'<,'>GpChatToggle<cr>", mode = 'v', desc = 'Toggle Chat' },

    { '<leader>a<C-h>', '<cmd>GpChatNew split<cr>', mode = 'n', desc = 'New Chat Horizontal Split' },
    { '<leader>a<C-v>', '<cmd>GpChatNew vsplit<cr>', mode = 'n', desc = 'New Chat Vertical Split' },
    { '<leader>a<C-t>', '<cmd>GpChatNew tabnew<cr>', mode = 'n', desc = 'New Chat Tab' },

    { '<leader>a<C-h>', ":<C-u>'<,'>GpChatNew split<cr>", mode = 'v', desc = 'Chat New Horizontal Split' },
    { '<leader>a<C-v>', ":<C-u>'<,'>GpChatNew vsplit<cr>", mode = 'v', desc = 'Chat New Vertical Split' },
    { '<leader>a<C-t>', ":<C-u>'<,'>GpChatNew tabnew<cr>", mode = 'v', desc = 'Chat New Tab' },

    -- Prompt commands
    { '<leader>ar', '<cmd>GpRewrite<cr>', mode = 'n', desc = 'Inline Rewrite' },
    { '<leader>aa', '<cmd>GpAppend<cr>', mode = 'n', desc = 'Append (after)' },
    { '<leader>ab', '<cmd>GpPrepend<cr>', mode = 'n', desc = 'Prepend (before)' },

    { '<leader>ar', ":<C-u>'<,'>GpRewrite<cr>", mode = 'v', desc = 'Visual Rewrite' },
    { '<leader>aa', ":<C-u>'<,'>GpAppend<cr>", mode = 'v', desc = 'Visual Append (after)' },
    { '<leader>ab', ":<C-u>'<,'>GpPrepend<cr>", mode = 'v', desc = 'Visual Prepend (before)' },
    { '<leader>ai', ":<C-u>'<,'>GpImplement<cr>", mode = 'v', desc = 'Implement selection' },

    { '<leader>agp', '<cmd>GpPopup<cr>', mode = 'n', desc = 'Prompt Popup' },
    { '<leader>age', '<cmd>GpEnew<cr>', mode = 'n', desc = 'Prompt Replace' },
    { '<leader>agn', '<cmd>GpNew<cr>', mode = 'n', desc = 'Prompt Horizontal Split' },
    { '<leader>agv', '<cmd>GpVnew<cr>', mode = 'n', desc = 'Prompt Vertical Split' },
    { '<leader>agt', '<cmd>GpTabnew<cr>', mode = 'n', desc = 'Prompt Tab' },

    { '<leader>agp', ":<C-u>'<,'>GpPopup<cr>", mode = 'v', desc = 'Visual Popup' },
    { '<leader>age', ":<C-u>'<,'>GpEnew<cr>", mode = 'v', desc = 'Visual Replace' },
    { '<leader>agn', ":<C-u>'<,'>GpNew<cr>", mode = 'v', desc = 'Visual Horizontal Split' },
    { '<leader>agv', ":<C-u>'<,'>GpVnew<cr>", mode = 'v', desc = 'Visual Vertical Split' },
    { '<leader>agt', ":<C-u>'<,'>GpTabnew<cr>", mode = 'v', desc = 'Visual Tab' },

    { '<leader>ax', '<cmd>GpContext<cr>', mode = 'n', desc = 'Toggle Context' },
    { '<leader>ax', ":<C-u>'<,'>GpContext<cr>", mode = 'v', desc = 'Toggle Context' },

    { '<leader>as', '<cmd>GpStop<cr>', mode = { 'n', 'v', 'x' }, desc = 'Stop' },
    { '<leader>an', '<cmd>GpNextAgent<cr>', mode = { 'n', 'v', 'x' }, desc = 'Next Agent' },

    -- Speech to Text (Whisper)
    { '<leader>awi', '<cmd>GpWhisper<cr>', mode = 'n', desc = 'Whisper Inline' },
    { '<leader>awi', ":<C-u>'<,'>GpWhisper<cr>", mode = 'v', desc = 'Visual Whisper Inline' },

    { '<leader>awr', '<cmd>GpWhisperRewrite<cr>', mode = 'n', desc = 'Whisper Inline Rewrite' },
    { '<leader>awa', '<cmd>GpWhisperAppend<cr>', mode = 'n', desc = 'Whisper Append (after)' },
    { '<leader>awb', '<cmd>GpWhisperPrepend<cr>', mode = 'n', desc = 'Whisper Prepend (before)' },

    { '<leader>awr', ":<C-u>'<,'>GpWhisperRewrite<cr>", mode = 'v', desc = 'Whisper Rewrite' },
    { '<leader>awa', ":<C-u>'<,'>GpWhisperAppend<cr>", mode = 'v', desc = 'Whisper Append (after)' },
    { '<leader>awb', ":<C-u>'<,'>GpWhisperPrepend<cr>", mode = 'v', desc = 'Whisper Prepend (before)' },

    { '<leader>awp', '<cmd>GpWhisperPopup<cr>', mode = 'n', desc = 'Whisper Popup' },
    { '<leader>awe', '<cmd>GpWhisperEnew<cr>', mode = 'n', desc = 'Whisper Replace' },
    { '<leader>awn', '<cmd>GpWhisperNew<cr>', mode = 'n', desc = 'Whisper Horizontal Split' },
    { '<leader>awv', '<cmd>GpWhisperVnew<cr>', mode = 'n', desc = 'Whisper Vertical Split' },
    { '<leader>awt', '<cmd>GpWhisperTabnew<cr>', mode = 'n', desc = 'Whisper Tab' },

    { '<leader>awp', ":<C-u>'<,'>GpWhisperPopup<cr>", mode = 'v', desc = 'Whisper Popup' },
    { '<leader>awe', ":<C-u>'<,'>GpWhisperEnew<cr>", mode = 'v', desc = 'Whisper Replace' },
    { '<leader>awn', ":<C-u>'<,'>GpWhisperNew<cr>", mode = 'v', desc = 'Whisper Horizontal Split' },
    { '<leader>awv', ":<C-u>'<,'>GpWhisperVnew<cr>", mode = 'v', desc = 'Whisper Vertical Split' },
    { '<leader>awt', ":<C-u>'<,'>GpWhisperTabnew<cr>", mode = 'v', desc = 'Whisper Tab' },
  },
  config = function()
    --- @module 'gp'
    --- @type GpConfig
    local cfg = {
      chat_user_prefix = '💬',
      chat_assistant_prefix = { ' ', '[{{agent}}]' },
      chat_template = require('gp.defaults').short_chat_template,
      chat_confirm_delete = false,
      providers = {
        openai = { disable = true },
        copilot = { disable = false },
      },
      agents = {
        -- {
        --   provider = 'copilot',
        --   name = 'Claude Sonnet 4',
        --   chat = true,
        --   command = true,
        --   model = 'anthropic/claude-sonnet-4',
        --   system_prompt = require('gp.defaults').chat_system_prompt,
        -- },
        {
          provider = 'copilot',
          name = 'ChatGPT-4o',
          chat = true,
          command = false,
          model = { model = 'gpt-4o', temperature = 1.1, top_p = 1 },
          system_prompt = require('gp.defaults').chat_system_prompt,
        },
        -- Disable defaults
        { name = 'ChatGPT4o', disable = true },
        { name = 'ChatGPT4o-mini', disable = true },
        { name = 'ChatGPT-o3-mini', disable = true },
        { name = 'CodeGPT4o', disable = true },
        { name = 'CodeGPT-o3-mini', disable = true },
        { name = 'CodeGPT4o-mini', disable = true },
      },

      style_popup_border = 'rounded',
      style_chat_finder_border = 'rounded',

      hooks = {
        -- example of making :%GpChatNew a dedicated command which
        -- opens new chat with the entire current buffer as a context
        BufferChatNew = function(gp, _)
          -- call GpChatNew command in range mode on whole buffer
          vim.api.nvim_command('%' .. gp.config.cmd_prefix .. 'ChatNew')
        end,
      },
    }

    require('gp').setup(cfg)
  end,
}
