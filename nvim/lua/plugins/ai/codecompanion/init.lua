-- https://github.com/olimorris/dotfiles/blob/main/.config/nvim/lua/plugins/coding.lua

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
    version = '^18.0.0',
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
      'nvim-treesitter/nvim-treesitter',
      'folke/edgy.nvim',
      {
        'ravitemer/codecompanion-history.nvim',
        commit = '8c6ca9f998aeef89f3543343070f8562bf911fb4',
      },
      {
        'ravitemer/mcphub.nvim',
        cmd = 'MCPHub',
        build = 'npm install -g mcp-hub@latest',
        config = true,
        commit = '5193329d510a68f1f5bf189960642c925c177a3a',
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
            show_presets = false,
          },
        },
        acp = {
          opts = {
            show_presets = false,
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
      interactions = {
        chat = {
          enabled = true,
          adapter = {
            name = 'copilot',
            model = 'claude-opus-4.5',
          },
          tools = {
            opts = {
              default_tools = {
                'files',
              },
            },
          },
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
            ['rules'] = {
              keymaps = {
                modes = {
                  i = '<C-r>',
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

      -- GENERAL OPTIONS --
      opts = {
        log_level = 'DEBUG',
      },

      -- RULES --
      rules = {
        opts = {
          chat = {
            enabled = true,
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

      -- PROMPT LIBRARY --
      prompt_library = {
        markdown = {
          dirs = {
            vim.fn.getcwd() .. '/.prompts',
            '~/.dotfiles/nvim/lua/plugins/ai/codecompanion/prompts',
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
