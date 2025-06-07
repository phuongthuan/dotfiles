return {
  'MeanderingProgrammer/render-markdown.nvim',
  enabled = true,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  ---@module 'render-markdown'
  -- ft = { "markdown", "norg", "rmd", "org" },
  init = function()
    --     set -g @hard-black "#282828"
    -- set -g @black "#3c3836"
    -- set -g @gray "#a89984"
    -- set -g @orange "#fe8019"
    -- set -g @purple "#d3869b"
    -- set -g @blue "#458588"
    -- set -g @light-blue "#83a598"
    -- set -g @green "#b8bb26"
    -- set -g @aqua "#8ec07c"
    -- set -g @red "#cc241d"
    -- set -g @yellow "#fabd2f"
    --
    -- set -g @btc "#f7931a"

    -- Define colors
    local color1_bg = '#b8bb26'
    local color2_bg = '#8ec07c'
    local color3_bg = '#83a598'

    local color_fg = '#282828'

    -- Heading background
    vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s gui=bold]], color_fg, color1_bg))
    vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s gui=bold]], color_fg, color2_bg))
    vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s gui=bold]], color_fg, color3_bg))

    -- Heading fg
    -- vim.cmd(string.format([[highlight Headline1Fg guifg=%s gui=bold]], colors.color1_bg))
    -- vim.cmd(string.format([[highlight Headline2Fg guifg=%s gui=bold]], colors.color2_bg))
    -- vim.cmd(string.format([[highlight Headline3Fg guifg=%s gui=bold]], colors.color3_bg))
  end,
  opts = {
    heading = {
      sign = false,
      icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' },
      backgrounds = {
        'Headline1Bg',
        'Headline2Bg',
        'Headline3Bg',
      },
      foregrounds = {
        'Headline1Fg',
        'Headline2Fg',
        'Headline3Fg',
      },
    },
    code = {
      sign = false,
      width = 'block',
      right_pad = 1,
    },
    bullet = {
      -- Turn on / off list bullet rendering
      enabled = true,
    },
    -- checkbox = {
    --     -- Turn on / off checkbox state rendering
    --     enabled = true,
    --     -- Determines how icons fill the available space:
    --     --  inline:  underlying text is concealed resulting in a left aligned icon
    --     --  overlay: result is left padded with spaces to hide any additional text
    --     position = "inline",
    --     unchecked = {
    --         -- Replaces '[ ]' of 'task_list_marker_unchecked'
    --         icon = "   󰄱 ",
    --         -- Highlight for the unchecked icon
    --         highlight = "RenderMarkdownUnchecked",
    --         -- Highlight for item associated with unchecked checkbox
    --         scope_highlight = nil,
    --     },
    --     checked = {
    --         -- Replaces '[x]' of 'task_list_marker_checked'
    --         icon = "   󰱒 ",
    --         -- Highlight for the checked icon
    --         highlight = "RenderMarkdownChecked",
    --         -- Highlight for item associated with checked checkbox
    --         scope_highlight = nil,
    --     },
    -- },
  },
}
