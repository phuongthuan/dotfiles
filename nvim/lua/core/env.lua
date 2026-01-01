-- To use env in Neovim, create a env variable in ~/.zshrc => source
-- vim.env only works in neovim
return {
  DOTFILES = vim.env.DOTFILES or '~/.dotfiles',
  NVIM_CONFIG_DIR = vim.env.NVIM_CONFIG_DIR or '~/.config/nvim',
  EH_CONFIG_DIR = vim.env.EH_CONFIG_DIR or '~/.config/eh',
  REFERENCES_DIR = vim.env.REFERENCES_DIR or '~/p/references',
  PERSONAL_NOTES = vim.env.PERSONAL_NOTES or '~/Documents/Notes',
  SECRET_ENV_FILE = vim.env.SECRET_ENV_FILE or '~/.dotfiles/zsh/secret.zsh',
  ICLOUD_DRIVE_OBSIDIAN_DIR = vim.env.ICLOUD_DRIVE_OBSIDIAN_DIR
    or '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes',
  LOCAL_SHARE_CONFIG_DIR = vim.env.LOCAL_SHARE_CONFIG_DIR or '~/.local/share/',

  -- Company env
  EH_CONFIG_FILE = vim.env.EH_CONFIG_FILE or '~/.dotfiles/zsh/eh.zsh',
  EH_REPOSITORY_DIR = vim.env.EH_REPOSITORY_DIR or '~/p/eh',
}
