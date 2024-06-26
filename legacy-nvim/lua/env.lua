-- All ~/.zsrhc variables are declared here

local M = {}

M.dotfiles_path = os.getenv("DOTFILES")
M.nvim_config_path = os.getenv("NVIM_CONFIG")
M.icloud_drive_obsidian_path = os.getenv("ICLOUD_DRIVE_OBSIDIAN")
M.eh_config_path = os.getenv("EH_CONFIG_PATH")
M.eh_repository_path = os.getenv("EH_REPOSITORY_PATH")
M.references_path = "~/Programming/References/"

return M
