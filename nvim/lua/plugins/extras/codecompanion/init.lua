-- https://github.com/olimorris/dotfiles/blob/main/.config/nvim/lua/plugins/coding.lua

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
    version = '17.33.0',
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'folke/edgy.nvim',
      'ravitemer/codecompanion-history.nvim',
    },
    init = function()
      local spinner = require('plugins.extras.codecompanion.spinner')
      spinner:init()
    end,
    opts = {
      ignore_warnings = true,
      adapters = {
        http = {
          copilot = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = {
                model = {
                  -- default = 'gpt-5',
                  default = 'claude-sonnet-4.5',
                  -- default = 'gpt-4o',
                },
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          enabled = true,
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
          slash_commands = {
            ['buffer'] = {
              keymaps = {
                modes = {
                  i = '<C-b>',
                },
              },
            },
            ['file'] = {
              keymaps = {
                modes = {
                  i = '<C-f>',
                },
              },
            },
            ['memory'] = {
              keymaps = {
                modes = {
                  i = '<C-m>',
                },
              },
            },
          },
        },
        inline = {
          adapter = {
            name = 'copilot',
            model = 'gpt-4.1',
          },
          keymaps = {
            accept_change = {
              modes = { n = 'ga' },
            },
            reject_change = {
              modes = { n = 'gr' },
              opts = { nowait = true },
            },
          },
        },
      },

      -- DISPLAY OPTIONS --
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

      -- EXTENSIONS --
      extensions = {
        history = {
          enabled = true,
          opts = {
            auto_save = false,
            auto_generate_title = true,
            continue_last_chat = false,
            delete_on_clearing_chat = false,
            picker = 'snacks',
            enable_logging = false,
            dir_to_save = vim.fn.stdpath('data') .. '/codecompanion-history',
          },
        },
      },

      -- GENERAL OPTIONS --
      opts = {
        log_level = 'DEBUG',
        system_prompt = PROMPTS.SYSTEM_PROMPT,
      },

      -- PROMPT LIBRARY --
      prompt_library = PROMPTS.PROMPT_LIBRARY,

      -- MEMORY --
      memory = {
        default = { is_default = false },
        ['eh-mobile-pro-unit-test'] = {
          description = 'Memory files for generating unit test',
          files = {
            'app/components/testUtils/createTestStore.js',
            'app/components/testUtils/renderWithRedux.tsx',
            'app/components/testUtils/renderHookWithRedux.tsx',
            '~/Documents/Notes/employmenthero/eh_mobile_pro_unit_test.md',
            -- 'app/state/createStore.js',
          },
        },
      },
    },
    keys = {
      {
        '<leader>at',
        '<cmd>CodeCompanionChat Toggle<cr>',
        desc = 'Toggle CodeCompanionChat',
        silent = true,
      },
      {
        '<leader>av',
        '<cmd>CodeCompanion<cr>',
        desc = 'New CodeCompanionChat',
        silent = true,
        mode = { 'n', 'v' },
      },
      {
        '<leader>ac',
        '<cmd>CodeCompanionActions<cr>',
        silent = true,
        mode = { 'n', 'v' },
      },
      {
        '<leader>ah',
        '<cmd>CodeCompanionHistory<cr>',
        desc = 'Open CodeCompanion History',
        silent = true,
      },
      -- {
      --   '<leader>am',
      --   '<cmd>MCPHub<cr>',
      --   desc = 'Open MCPHub',
      --   silent = true,
      -- },
      -- {
      --   '<leader>ap',
      --   '<cmd>CodeCompanionChat Add<cr>',
      --   desc = 'Paste Select To CodeCompanionChat',
      --   silent = true,
      --   mode = { 'n', 'v' },
      -- },
    },
  },
}
