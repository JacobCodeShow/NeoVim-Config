-- ~/.config/nvim/init.lua

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.g.neoconfig_sudo = vim.env.SUDO_USER ~= nil

require("core.options")
require("core.keymaps")
require("core.autocmd")
require("core.terminal")
require("config.lazy")

-- =========================
-- Font config (single source of truth)
-- =========================
local FONT_NAME = "JetBrainsMono Nerd Font"
local FONT_SIZE = 13

local is_gui = vim.fn.has("gui_running") == 1

if is_gui then
  -- GUI Neovim only
  vim.opt.guifont = string.format("%s:h%d", FONT_NAME, FONT_SIZE)
else
  -- Terminal Neovim only
  vim.opt.mouse = "" -- don't steal terminal mouse selection
end

-- =========================
-- Common UI (GUI + Terminal)
-- =========================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 6

-- Better popup & float experience
vim.opt.pumblend = 10
vim.opt.winblend = 10
