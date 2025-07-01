return {
  'olimorris/codecompanion.nvim',
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
            return '  ' .. adapter.formatted_name .. model_name
          end,
          user = '💬',
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
        display = {
          chat = {
            -- Change to true to show the current model
            show_settings = false,
            window = {
              layout = 'vertical', -- float|vertical|horizontal|buffer
            },
          },
        },
      },
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function(_, opts)
    local spinner = require('plugins.extras.codecompanion.spinner')
    spinner:init()

    require('codecompanion').setup(opts)
  end,
  keys = {
    {
      '<leader>cc',
      '<cmd>CodeCompanionChat Toggle<cr>',
      desc = 'Toggle CodeCompanionChat',
      silent = true,
    },
    {
      '<leader>cn',
      '<cmd>CodeCompanionChat<cr>',
      desc = 'New CodeCompanionChat',
      silent = true,
    },
  },
}
