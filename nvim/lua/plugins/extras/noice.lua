-- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes
local nmap = require('core.utils').mapper_factory('n')

return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        presets = {
          bottom_search = true,
          long_message_to_split = true,
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        cmdline = {
          format = {
            cmdline = { pattern = '^:', icon = '💻', lang = 'vim' },
            search_down = {
              kind = 'search',
              pattern = '^/',
              icon = '🔍 ',
              lang = 'regex',
            },
            search_up = {
              kind = 'search',
              pattern = '^%?',
              icon = '🔍 ',
              lang = 'regex',
            },
            input = { view = 'cmdline_input', icon = '📝' }, -- Used by input()
          },
        },
        routes = {
          -- Hide all "" message, eg: message when open a new file
          {
            filter = {
              event = 'msg_show',
              kind = '',
            },
            opts = { skip = true },
          },
        },
      })

      -- Keymaps
      nmap('<leader><leader>n', '<cmd>NoiceAll<cr>', { desc = 'Open messages' })
      nmap('<leader>un', '<cmd>NoiceDismiss<cr>', { desc = 'Dismiss notification' })
    end,
  },
  {
    'rcarriga/nvim-notify',
    opts = {
      background_colour = '#282828',
      stages = 'fade',
      -- icons = { ERROR = '❌' },
      -- top_down = false,
      -- render = 'compact',
    },
  },
}
