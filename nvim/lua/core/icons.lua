local M = {}

M.lspkind = {
  Text = '󰉿',
  -- Method = "󰆧",
  Method = '💎',
  Function = '󰊕',
  -- Constructor = "",
  Constructor = '🛞',
  -- Field = '󰜢',
  Field = '🔗',
  Variable = '󰀫',
  Class = '󰠱',
  Interface = '',
  Module = '📦',
  -- Module = '💎',
  Property = '󰜢',
  -- Unit = '󰑭',
  Unit = '📏',
  -- Value = '󰎠',
  Value = '🔤',
  Enum = '',
  -- Keyword = '󰌋',
  Keyword = '🔑',
  Snippet = '🔥',
  -- Color = '󰏘',
  Color = '🌈',
  File = '󰈙',
  -- File = '📄',
  Reference = '󰈇',
  -- Folder = '󰉋',
  Folder = '📁',
  EnumMember = '',
  Constant = '󰏿',
  Struct = '󰙅',
  -- Event = '',
  Event = '⚡',
  Operator = '󰆕',
  Copilot = '🤖',
  TypeParameter = '',
}

M.diagnostics = {
  error = ' ',
  warn = ' ',
  info = ' ',
  hint = ' ',
}

M.icons = {
  format = '󰉼',
  lock = '',
  download = '',
  flash = '',
  file = '',
  folder = ' ',
  search = '',
  files = '',
  update = '󰚰',
  check = '',
  speedometer = '󰾅',
  plus_circle = '󰐗',
  check_fidget = '✔',
  neovim = '',
  bug = '',
  music = '',
  fire = '',
  link = '',
}

M.git = {
  untracked = '',
  github = '',
  branch = '',
}

M.ui = {
  cmd = '⌘',
  config = '🛠',
  event = '📅',
  ft = '📂',
  init = '⚙️',
  keys = '🗝',
  plugin = '🔌',
  runtime = '💻',
  require = '🌙',
  source = '📄',
  start = '🚀',
  task = '📌',
  lazy = '💤 ',
}

return M
