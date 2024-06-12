-- All ~/.zsrhc variables are declared here

local M = {}

M.dotfiles_path = os.getenv 'DOTFILES'
M.nvim_config_path = os.getenv 'NVIM_CONFIG'
M.nvim_kickstart_config_path = os.getenv 'NVIM_KICKSTART_CONFIG'
M.icloud_drive_obsidian_path = os.getenv 'ICLOUD_DRIVE_OBSIDIAN'
M.eh_config_path = os.getenv 'EH_CONFIG_PATH'
M.references_path = '~/Programming/References/'

return M
