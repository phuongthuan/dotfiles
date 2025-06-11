local nmap = require('core.utils').mapper_factory('n')

return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'onsails/lspkind-nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Attach LSP to current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('nvim-lsp-attach', { clear = true }),
        callback = function(event)
          require('plugins.lsp.autocmds').setup(event)
          require('plugins.lsp.mappings').setup(event)
        end,
      })

      require('plugins.lsp.diagnostics').setup()

      -- Add nvim-cmp capabilities for LSP
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        yamlls = {
          schemas = {
            kubernetes = 'k8s-*.yaml',
            ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
            ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
            ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'ts_ls',
          'bashls',
          -- 'yamlls',
          -- 'pyright',
        },
        automatic_enable = {
          'lua_ls',
          'ts_ls',
          'bashls',
        },
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })

      -- Keymaps
      nmap('<leader>ms', '<cmd>Mason<cr>')
      nmap('<leader>li', '<cmd>LspInfo<cr>')
      nmap('<leader>ll', '<cmd>LspLog<cr>')
    end,
  },
}
