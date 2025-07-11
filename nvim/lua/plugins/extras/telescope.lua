local env = require('core.env')
local nmap = require('core.utils').mapper_factory('n')

-- Recipes
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-file-browser.nvim',

    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup({
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        prompt_prefix = ' 🔍 ',
        winblend = 0,
        file_ignore_patterns = { 'node_modules', '.git/' },
        layout_strategy = 'vertical',
        layout_config = {
          width = 0.95,
          height = 0.85,
          horizontal = {
            preview_width = function(_, cols, _)
              if cols > 200 then
                return math.floor(cols * 0.4)
              else
                return math.floor(cols * 0.6)
              end
            end,
          },
          vertical = {
            width = 0.9,
            height = 0.95,
            preview_height = 0.5,
          },
          flex = {
            horizontal = {
              preview_width = 0.9,
            },
          },
        },
        mappings = {
          i = {
            ['<C-x>'] = false,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            -- ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
            ['<Esc>'] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          previewer = false,
          hidden = true,
        },
        buffers = {
          theme = 'ivy',
          previewer = false,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'file_browser')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require('telescope.builtin')
    nmap('<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    nmap('<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    nmap('<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    nmap('<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    nmap('<leader>rs', builtin.resume, { desc = '[S]earch [R]esume' })
    nmap('<leader>r', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    nmap('<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    nmap('<leader>f', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = '[/] Fuzzily search in current buffer' })

    nmap('<leader>sdf', function()
      builtin.find_files({
        prompt_title = '🔭 Dotfiles',
        cwd = env.DOTFILES,
        hidden = true,
      })
    end, { desc = '[S]earch [D]ot[F]iles' })

    nmap('<leader>fn', function()
      builtin.find_files({
        prompt_title = '🔭 Note Files',
        cwd = env.PERSONAL_NOTES,
        hidden = true,
      })
    end, { desc = '[S]earch all [N]ote files' })

    nmap('<leader>sn', function()
      builtin.live_grep({
        prompt_title = '🔭 Grep Notes',
        cwd = env.PERSONAL_NOTES,
        -- layout_config = { preview_width = 0.65 },
        hidden = true,
      })
    end, { desc = '[S]earch for a string in the [N]ote folder' })

    nmap(';f', function()
      builtin.find_files({
        propmt_title = '🔭 Files',
        no_ignore = false,
        hidden = true,
      })
    end, {
      desc = 'Search all [F]iles in the current working directory, respects .gitignore',
    })

    nmap(';r', function()
      builtin.live_grep({
        propmt_title = '🔭 Live Grep String',
        additional_args = { '--hidden' },
        grep_open_files = true,
        layout_strategy = 'vertical',
      })
    end, {
      desc = '[S]earch for a string in the current open buffers and get results live as typed, respects .gitignore',
    })

    nmap('<leader>ps', function()
      builtin.grep_string({
        search = vim.fn.input('Grep >'),
        additional_args = { '--hidden' },
        layout_strategy = 'vertical',
        propmt_title = '🔭 Grep String',
      })
    end, {
      desc = '[S]earch for a input string in the current working directory, respects .gitignore',
    })

    nmap(';d', function(path)
      local _path = path or vim.fn.input('📁 Directory ▶️ ')
      builtin.live_grep({
        search_dirs = { _path },
        prompt_title = '🔭 Grep in Directory',
        additional_args = { '--hidden' },
      })
    end, {
      desc = 'Search for a input string in the given directory, respects .gitignore',
    })

    nmap('<leader>fb', function()
      require('telescope').extensions.file_browser.file_browser({
        prompt_title = '🔭 File Browser',
        path_display = { 'smart' },
        cwd = '~',
      })
    end, { desc = '[F]ind files in [B]rowser' })

    nmap('<leader>gb', function()
      builtin.git_branches({
        propmt_title = '🔭 Git Branches',
      })
    end, { desc = '[S]earch git [B]ranches' })
  end,
}
