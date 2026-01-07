-- ~/.config/nvim/lua/core/autocmd.lua

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "term://*",
  callback = function()
    vim.cmd("stopinsert")
  end,
})

local version = require("core.version").version

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.notify("NeoVim-Config v" .. version, vim.log.levels.INFO)
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("core.NeoConfigModule.luarc").ensure()
  end,
})

