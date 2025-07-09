local PROMPTS = require('plugins.extras.codecompanion.prompts')

return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion' },
    opts = {
      render_modes = true,
      sign = {
        enabled = false,
      },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'folke/edgy.nvim',
      'ravitemer/codecompanion-history.nvim',
      {
        'ravitemer/mcphub.nvim',
        cmd = 'MCPHub',
        build = 'npm install -g mcp-hub@latest',
        config = true,
      },
    },
    init = function()
      local spinner = require('plugins.extras.codecompanion.spinner')
      spinner:init()
    end,
    opts = {
      adapters = {
        copilot = function()
          return require('codecompanion.adapters').extend('copilot', {
            schema = {
              model = {
                default = 'claude-sonnet-4',
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = 'copilot',
          roles = {
            llm = function(adapter)
              local model_name = ''
              if adapter.schema and adapter.schema.model and adapter.schema.model.default then
                local model = adapter.schema.model.default
                if type(model) == 'function' then
                  model = model(adapter)
                end
                model_name = ' (' .. model .. ')'
              end
              return '  [' .. adapter.formatted_name .. ']' .. model_name
            end,
            user = '  [thuan]',
          },
          keymaps = {
            send = {
              callback = function(chat)
                vim.cmd('stopinsert')
                chat:submit()
                chat:add_buf_message({ role = 'llm', content = '' })
              end,
              index = 1,
              description = 'Send',
            },
            toggle = {
              modes = { n = 'q' },
              index = 3,
              callback = function()
                vim.cmd('CodeCompanionChat Toggle')
              end,
              description = 'Toggle Chat',
            },
            stop = {
              modes = {
                n = '<C-c>',
              },
              index = 4,
              callback = 'keymaps.stop',
              description = 'Stop Request',
            },
          },
        },
      },

      -- DISPLAY OPTIONS ----------------------------------------------------------
      display = {
        chat = {
          -- Change to true to show the current model
          show_settings = false,
          window = {
            layout = 'vertical', -- float|vertical|horizontal|buffer
          },
          intro_message = 'Welcome to Copilot Chat ✨! Press ? for options',
        },
        inline = { layout = 'buffer' },
      },

      -- EXTENSIONS ------------------------------------------------------
      extensions = {
        history = {
          enabled = true,
          opts = {
            auto_save = true,
            auto_generate_title = true,
            continue_last_chat = false,
            delete_on_clearing_chat = false,
            picker = 'snacks',
            enable_logging = false,
            dir_to_save = vim.fn.stdpath('data') .. '/codecompanion-history',
          },
        },
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },
      },

      -- GENERAL OPTIONS ----------------------------------------------------------
      opts = {
        log_level = 'DEBUG',
        system_prompt = PROMPTS.SYSTEM_PROMPT,
      },

      prompt_library = PROMPTS.PROMPT_LIBRARY,
    },
    keys = {
      {
        '<leader>at',
        '<cmd>CodeCompanionChat Toggle<cr>',
        desc = 'Toggle CodeCompanionChat',
        silent = true,
      },
      {
        '<leader>ac',
        '<cmd>CodeCompanionChat<cr>',
        desc = 'New CodeCompanionChat',
        silent = true,
      },
      {
        '<leader>ap',
        '<cmd>CodeCompanionChat Add<cr>',
        desc = 'Paste Select To CodeCompanionChat',
        silent = true,
        mode = { 'n', 'v' },
      },
      {
        '<leader>ah',
        '<cmd>CodeCompanionHistory<cr>',
        desc = 'Open CodeCompanion History',
        silent = true,
      },
      {
        '<leader>am',
        '<cmd>MCPHub<cr>',
        desc = 'Open MCPHub',
        silent = true,
      },
    },
  },
}
