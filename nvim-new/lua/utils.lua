local M = {}

local function mapper_factory(mode)
  local default_opts = { silent = true }

  return function(lhs, rhs, opts)
    local final_opts = vim.tbl_extend('force', default_opts, opts or {})
    vim.keymap.set(mode, lhs, rhs, final_opts)
  end
end

M.env = {
  DOTFILES = os.getenv('DOTFILES'),
  GITHUB_USERNAME = os.getenv('GITHUB_USERNAME'),
  NVIM_CONFIG_DIR = os.getenv('NVIM_CONFIG_DIR'),
  REFERENCES_DIR = os.getenv('REFERENCES_DIR') or '~/p/references',
  NOTES_DIR = os.getenv('PERSONAL_NOTES'),
  SECRET_ENV_FILE = os.getenv('SECRET_ENV_FILE'),
  LOCAL_SHARE_DIR = '~/.local/share/',

  -- Company env
  COMPANY_CONFIG_DIR = os.getenv('EH_CONFIG_DIR'),
  COMPANY_CONFIG_FILE = os.getenv('EH_CONFIG_FILE'),
  COMPANY_REPO_DIR = os.getenv('EH_REPOSITORY_DIR'),
}

M.icons = {
  diagnostics = {
    error = ' ',
    warn = ' ',
    info = ' ',
    hint = ' ',
  },
}

M.colors = {
  gruvbox_dark = {
    bright_bg = '#3c3836',
    bright_fg = '#fbf1c7',
    red = '#cc241d',
    dark_red = '#9d0006',
    green = '#b8bb26',
    blue = '#458588',
    light_blue = '#83a598',
    purple = '#d3869b',
    orange = '#fe8019',
    yellow = '#fabd2f',
    aqua = '#8ec07c',
    gray = '#a89984',
    black = '#282828',
  },
}

M.nmap = mapper_factory('n')
M.vmap = mapper_factory('v')
M.imap = mapper_factory('i')
M.xmap = mapper_factory('x')
M.omap = mapper_factory('o')
M.mapper = mapper_factory

return M
