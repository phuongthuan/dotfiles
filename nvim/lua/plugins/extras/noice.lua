-- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes
return {
  'folke/noice.nvim',
  enabled = false,
  event = 'VeryLazy',
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    lsp = {
      progress = {
        enabled = true,
      },
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
        cmdline = { pattern = '^:', lang = 'vim' },
        search_down = {
          kind = 'search',
          pattern = '^/',
          icon = ' ',
          lang = 'regex',
        },
        search_up = {
          kind = 'search',
          pattern = '^%?',
          icon = ' ',
          lang = 'regex',
        },
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
    popupmenu = {
      enabled = true,
    },
  },
  keys = {
    { '<leader>om', '<cmd>NoiceAll<cr>', desc = 'Open Messages' },
    { '<leader>dn', '<cmd>NoiceDismiss<cr>', desc = 'Dismiss Notification' },
  },
}
