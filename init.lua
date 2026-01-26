-- ~/.config/nvim/init.lua

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.g.neoconfig_sudo = vim.env.SUDO_USER ~= nil

require("core.options")
require("core.keymaps")
require("core.autocmd")
require("core.terminal")
require("core.clipboard")
require("config.lazy")