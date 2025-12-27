-- https://github.com/olimorris/dotfiles/blob/main/.config/nvim/lua/plugins/coding.lua

local PROMPTS = require('plugins.ai.codecompanion.prompts')

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
      { 'nvim-lua/plenary.nvim', branch = 'master' },
      'nvim-treesitter/nvim-treesitter',
      'folke/edgy.nvim',
      {
        'ravitemer/codecompanion-history.nvim',
        commit = 'eb99d256352144cf3b6a1c45608ec25544a0813d',
      },
      {
        'ravitemer/mcphub.nvim',
        cmd = 'MCPHub',
        build = 'npm install -g mcp-hub@latest',
        config = true,
        commit = '8ff40b5edc649959bb7e89d25ae18e055554859a',
      },
    },
    init = function()
      -- https://codecompanion.olimorris.dev/usage/chat-buffer/tools#yolo-mode
      -- vim.g.codecompanion_yolo_mode = true

      local spinner = require('plugins.ai.codecompanion.spinner')
      spinner:init()
    end,
    opts = {
      ignore_warnings = true,
      adapters = {
        http = {
          opts = {
            show_defaults = false,
          },
          copilot = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = {
                model = {
                  default = 'claude-opus-4.5',
                },
              },
            })
          end,
        },
        acp = {
          opts = {
            show_defaults = false,
          },
          gemini_cli = function()
            return require('codecompanion.adapters').extend('gemini_cli', {
              defaults = {
                auth_method = 'gemini-api-key',
                timeout = 20000,
              },
              env = {
                GEMINI_API_KEY = 'GEMINI_API_KEY',
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          tools = {
            opts = {
              default_tools = {
                'files',
              },
            },
          },
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
              -- return '  [' .. adapter.formatted_name .. ']' .. model_name
              return '  [AI]' .. model_name
            end,
            user = '  [thuan]',
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
          intro_message = 'Welcome to CodeCompanion ✨!',
        },
        inline = { layout = 'buffer' },
      },

      -- EXTENSIONS --
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
        history = {
          enabled = true,
          opts = {
            auto_save = false,
            auto_generate_title = true,
            continue_last_chat = false,
            delete_on_clearing_chat = false,
            picker = 'snacks', -- mini.pick
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
        opts = {
          chat = {
            enabled = true,
          },
        },
        eh_mobile_pro_unit_test = {
          description = 'Contexts for generating unit test',
          files = {
            '~/Documents/Notes/employmenthero/eh_mobile_pro_unit_test.md',
          },
        },
        eh_mobile_pro_maestro_e2e_test = {
          description = 'Contexts for working with Maestro E2E test',
          files = {
            'maestro/common/authenticate.yml',
            'maestro/common/launch_app.yml',
            'maestro/common/restart_app.yml',
            'maestro/common/clear_state.yml',
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
        desc = 'List All CodeCompanion Actions',
        silent = true,
        mode = { 'n', 'v' },
      },
      {
        '<leader>ap',
        '<cmd>CodeCompanionChat Add<cr>',
        desc = 'Paste Selected Code To Chat',
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
