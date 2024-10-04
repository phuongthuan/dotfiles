-- To use env in Neovim, create a env variable in ~/.zshrc => source
-- vim.env only works in neovim
return {
  NVIM_USE_TSSERVER = vim.env.NVIM_USE_TSSERVER and true or false,
  NVIM_USE_VTSLS = vim.env.NVIM_USE_VTSLS and true or false,
  DOTFILES = vim.env.DOTFILES or '~/.dotfiles',
  NVIM_CONFIG_DIR = vim.env.NVIM_CONFIG_DIR or '~/.config/nvim',
  LAZYVIM_CONFIG_DIR = vim.env.LAZYVIM_CONFIG_DIR or '~/.config/lazyvim',
  EH_CONFIG_DIR = vim.env.EH_CONFIG_DIR or '~/.config/eh',
  REFERENCES_DIR = vim.env.REFERENCES_DIR or '~/Programming/References',
  PERSONAL_NOTES = vim.env.PERSONAL_NOTES or '~/Documents/Notes',
  ICLOUD_DRIVE_OBSIDIAN_DIR = vim.env.ICLOUD_DRIVE_OBSIDIAN_DIR
    or '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes',

  -- Company env
  EH_CONFIG_FILE = vim.env.EH_CONFIG_FILE or '~/.dotfiles/zsh/eh.zsh',
  EH_REPOSITORY_DIR = vim.env.EH_REPOSITORY_DIR
    or '~/Programming/EmploymentHero',
}
