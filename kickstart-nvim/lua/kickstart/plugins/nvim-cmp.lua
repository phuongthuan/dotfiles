-- Autocompletion
return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load { paths = { require('env').dotfiles_path .. '/snippets' } }
          end,
        },
      },
    },
    'saadparwaiz1/cmp_luasnip',

    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require 'lspkind'

    luasnip.config.setup()

    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
        return false
      end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match '^%s*$' == nil
    end

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },
      mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm {
                select = true,
              }
            end
          else
            fallback()
          end
        end),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      formatting = {
        format = lspkind.cmp_format {
          mode = 'symbol',
          max_width = 50,
          symbol_map = {
            Text = '󰉿',
            Method = '󰆧',
            Function = '󰊕',
            Constructor = '',
            Field = '󰜢',
            Variable = '󰀫',
            Class = '󰠱',
            Interface = '',
            Module = '',
            Property = '󰜢',
            Unit = '󰑭',
            -- Value = '󰎠',
            Value = '🔤',
            Enum = '',
            -- Keyword = '󰌋',
            Keyword = '🔑',
            Snippet = '🔥',
            -- Color = '󰏘',
            Color = '🌈',
            File = '󰈙',
            Reference = '󰈇',
            -- Folder = '󰉋',
            Folder = '📁',
            EnumMember = '',
            Constant = '󰏿',
            Struct = '󰙅',
            Event = '',
            Operator = '󰆕',
            -- Copilot = '',
            Copilot = '👽',
            TypeParameter = '',
          },
          before = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = ' [LSP]',
              buffer = ' [Buffer]',
              path = ':virgo: [Path]',
              luasnip = ' [Snippet]',
            })[entry.source.name]
            return vim_item
          end,
        },
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          require('copilot_cmp.comparators').prioritize,

          -- Below is the default comparitor list and order for nvim-cmp
          cmp.config.compare.offset,
          -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      sources = {
        { name = 'copilot', group_index = 2 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'luasnip', group_index = 2 },
        { name = 'path', group_index = 2 },
        { name = 'emoji', group_index = 2 },
      },
    }
  end,
}
