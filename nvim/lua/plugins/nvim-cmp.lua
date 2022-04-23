local cmp = require('cmp')
local lspkind = require('lspkind')

-- Plugin: nvim-cmp
--- https://github.com/hrsh7th/nvim-cmp

cmp.setup {
    completion = {completeopt = 'menu,menuone,noinsert'},
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true}),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn['vsnip#available']() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
            else
                fallback()
            end
        end
    },
    formatting = {
        format = function(entry, vim_item)
            -- vim_item.kind = lspkind.presets.default[vim_item.kind] .. " "
            vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
            vim_item.menu = ({
                buffer = " [Buffer]",
                path = " [Path]",
                nvim_lsp = " [LSP]",
                vsnip = " [Snippet]",
                nvim_lua = "[Lua]",
                calc = " [Calc]"
            })[entry.source.name]
            return vim_item
        end
    },
    sources = {
      {name = 'nvim_lsp'},
      {name = 'nvim_lua'},
      {name = 'path'},
      -- {name = 'copilot'},
      {name = 'vsnip'},
      {name = 'path'},
      {name = 'buffer',
        option = {
          get_bufnrs = function() return { vim.api.nvim_get_current_buf() } end
        }
      }
    }
}

