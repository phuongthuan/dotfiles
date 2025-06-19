return {
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = (function()
        if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load({
          -- exclude = { 'javascript' },
          paths = { require('core.env').DOTFILES .. '/snippets' },
        })
      end,
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'chrisgrieser/cmp-nerdfont',
    -- 'hrsh7th/cmp-emoji',
    -- 'hrsh7th/cmp-nvim-lua',
    -- 'octaltree/cmp-look',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')
    local icons = require('core.icons')
    -- local copilot_cmp = require('copilot_cmp.comparators')

    luasnip.config.setup()

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    local select_next_item = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end

    local select_prev_item = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end

    cmp.setup({
      completion = {
        completeopt = 'menu,menuone,noinsert,popup',
      },
      window = {
        documentation = {
          border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        },
      },
      -- config nvim cmp to work with snippet engine
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<C-n>'] = cmp.mapping(select_next_item),
        ['<C-p>'] = cmp.mapping(select_next_item),
        ['<C-j>'] = cmp.mapping(select_next_item),
        ['<C-k>'] = cmp.mapping(select_prev_item),
        ['<Down>'] = cmp.mapping(select_next_item),
        ['<Up>'] = cmp.mapping(select_prev_item),

        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping.abort(),

        ['<CR>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({
                select = true,
              })
            end
          else
            fallback()
          end
        end),

        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
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
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol',
          max_width = 50,
          symbol_map = icons.lspkind,
          before = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = '[LSP]',
              buffer = ' [Buffer]',
              path = '[Path]',
              luasnip = '[Snippet]',
              -- copilot = '[Copilot]',
            })[entry.source.name]
            return vim_item
          end,
        }),
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          -- copilot_cmp.prioritize,

          cmp.config.compare.offset,
          cmp.config.compare.scopes,
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
      sources = cmp.config.sources({
        -- { name = 'copilot' },
        { name = 'luasnip' },
        { name = 'lazydev' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nerdfont' },
        -- {
        --   name = 'look',
        --   keyword_length = 3,
        --   option = {
        --     convert_case = true,
        --     loud = true,
        --     -- dict = '/usr/share/dict/words',
        --   },
        -- },
      }),
    })
  end,
}
