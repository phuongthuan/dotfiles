vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://www.github.com/zbirenbaum/copilot.lua',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  { src = 'https://www.github.com/olimorris/codecompanion.nvim', version = vim.version.range('^18.0.0') },
  'https://www.github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://www.github.com/ravitemer/codecompanion-history.nvim',
  'https://www.github.com/franco-ruggeri/codecompanion-spinner.nvim',
})

local nmap = require('utils').nmap
local mapper = require('utils').mapper

require('copilot').setup({
  copilot_node_command = vim.fn.expand('$HOME') .. '/.asdf/installs/nodejs/22.20.0/bin/node',
  suggestion = { enabled = false, auto_trigger = true },
  panel = { enabled = false },
  filetypes = {
    javascript = true,
    javascriptreact = true,
    typescript = true,
    typescriptreact = true,
    lua = true,
    json = true,
    yaml = true,
    markdown = true,
    http = true,
    sh = function()
      if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
        -- disable for .env files
        return false
      end
      return true
    end,
    -- Disable all other file types
    ['*'] = false,
  },
})

require('render-markdown').setup({
  render_modes = true,
  sign = {
    enabled = false,
  },
})

vim.g.codecompanion_yolo_mode = true
require('codecompanion').setup({
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
        model = 'claude-haiku-4.5',
        -- model = 'claude-opus-4.5',
        -- model = 'claude-sonnet-4.5',
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
        auto_generate_title = true,
        continue_last_chat = false,
        delete_on_clearing_chat = false,
        picker = 'mini.pick', -- mini.pick, snacks
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
        -- '~/.dotfiles/nvim/lua/plugins/ai/codecompanion/prompts',
      },
    },
  },

  -- GENERAL OPTIONS --
  opts = {
    log_level = 'DEBUG',
  },
})
vim.cmd([[cab cc CodeCompanion]])

nmap('<leader>at', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle CodeCompanionChat' })
mapper({ 'n', 'v' })('<leader>av', '<cmd>CodeCompanion<cr>', { desc = 'New CodeCompanionChat' })
mapper({ 'n', 'v' })('<leader>ac', '<cmd>CodeCompanionActions<cr>', { desc = 'List All CodeCompanion Actions' })
mapper({ 'n', 'v' })('<leader>ap', '<cmd>CodeCompanionChat Add<cr>', { desc = 'Paste Selected Code To Chat' })
nmap('<leader>ah', '<cmd>CodeCompanionHistory<cr>', { desc = 'Open CodeCompanion History' })
