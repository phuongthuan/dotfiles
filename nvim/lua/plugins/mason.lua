local map = require('utils').map

local status, mason = pcall(require, 'mason')
if (not status) then return end

local status2, lspconfig = pcall(require, 'mason-lspconfig')
if (not status2) then return end

mason.setup{}

lspconfig.setup {
  automatic_installation = true
}

map('n', '<leader>ms', ':Mason<CR>')