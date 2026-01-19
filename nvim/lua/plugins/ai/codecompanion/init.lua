-- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
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
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'ravitemer/codecompanion-history.nvim',
      'franco-ruggeri/codecompanion-spinner.nvim',
      -- {
      --   'ravitemer/mcphub.nvim',
      --   cmd = 'MCPHub',
      --   build = 'npm install -g mcp-hub@latest',
      --   config = true,
      -- },
    },
    init = function()
      -- https://codecompanion.olimorris.dev/usage/chat-buffer/tools#yolo-mode
      vim.g.codecompanion_yolo_mode = true
    end,
    opts = {
      -- RULES --
      rules = {
        opts = {
          chat = {
            enabled = true,
            default_rules = 'default',
          },
        },
        eh_unit_tests = {
          description = 'Rules for React Unit testing',
          files = {
            '~/.dotfiles/.github/instructions/react-unit-test.instructions.md',
          },
        },
        custom_instructions = {
          description = 'Custom Instructions File Guidelines',
          files = {
            '~/p/references/awesome-copilot/instructions/instructions.instructions.md',
          },
        },
        maestro_e2e_tests = {
          description = 'Rules for Maestro E2E testing',
          files = {
            '~/.dotfiles/.github/instructions/maestro.instructions.md',
          },
        },
        dotfiles = {
          description = 'Rules for .dotfiles',
          files = {
            '~/.dotfiles/.github/copilot-instructions.md',
          },
        },
        neovim = {
          description = 'Rules for Neovim config',
          files = {
            '~/.dotfiles/.github/instructions/neovim.instructions.md',
          },
        },
      },

      -- INTERACTIONS --
      interactions = {
        chat = {
          enabled = true,
          -- adapter = 'gemini_cli',
          adapter = {
            name = 'copilot',
            -- model = 'gpt-4.1',
            -- model = 'claude-haiku-4.5',
            -- model = 'claude-opus-4.5',
            model = 'claude-sonnet-4.5',
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
            ['fetch'] = {
              keymaps = {
                modes = {
                  i = '<C-e>',
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
            ['image'] = {
              opts = {
                dirs = {
                  '~/Pictures/Screenshots/',
                  '~/Downloads/',
                },
              },
              keymaps = {
                modes = {
                  i = '<C-i>',
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
        background = {
          chat = {
            opts = {
              enabled = true,
            },
          },
        },
      },

      -- ADAPTERS --
      adapters = {
        acp = {
          gemini_cli = function()
            return require('codecompanion.adapters').extend('gemini_cli', {
              defaults = {
                auth_method = 'gemini-api-key',
              },
              env = {
                GEMINI_API_KEY = 'GEMINI_API_KEY',
              },
            })
          end,
        },
      },

      -- DISPLAY OPTIONS --
      display = {
        action_palette = {
          provider = 'default',
        },
        chat = {
          icons = {
            tool_success = '󰸞 ',
            tool_failure = '',
            tool_in_progress = '󰔟',
          },
          -- show_settings = true,
          show_reasoning = false,
        },
        inline = {
          layout = 'buffer',
        },
      },

      -- EXTENSIONS --
      extensions = {
        -- mcphub = {
        --   callback = 'mcphub.extensions.codecompanion',
        --   opts = {
        --     make_vars = true,
        --     make_slash_commands = true,
        --     show_result_in_chat = true,
        --   },
        -- },
        history = {
          enabled = true,
          opts = {
            auto_save = false,
            -- auto_generate_title = true,
            continue_last_chat = false,
            delete_on_clearing_chat = false,
            picker = 'snacks', -- mini.pick
            enable_logging = false,
            dir_to_save = vim.fn.stdpath('data') .. '/codecompanion-history',
          },
        },
        spinner = {},
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

      -- GENERAL OPTIONS --
      opts = {
        log_level = 'DEBUG',
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
      -- {
      --   '<leader>am',
      --   '<cmd>MCPHub<cr>',
      --   desc = 'Open MCPHub',
      --   silent = true,
      -- },
    },
  },
}
