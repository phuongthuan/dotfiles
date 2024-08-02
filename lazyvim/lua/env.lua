-- All ~/.zsrhc variables are declared here

local M = {}

M.dotfiles_path = os.getenv("DOTFILES")
M.nvim_config_dir = os.getenv("NVIM_CONFIG_DIR")
M.icloud_drive_obsidian_dir = os.getenv("ICLOUD_DRIVE_OBSIDIAN_DIR")
M.eh_config_file = os.getenv("EH_CONFIG_FILE")
M.references_path = "~/Programming/References/"

return M
