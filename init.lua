-- ~/.config/nvim/init.lua

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.keymaps")
require("core.autocmd")
require("core.neoconfig")
require("core.terminal")
require("config.lazy")