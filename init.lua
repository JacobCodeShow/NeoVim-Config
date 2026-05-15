-- ~/.config/nvim/init.lua

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Avoid hard failures when a Treesitter parser is temporarily unavailable.
do
  local original_treesitter_start = vim.treesitter.start

  vim.treesitter.start = function(bufnr, lang)
    local ok, result = pcall(original_treesitter_start, bufnr, lang)
    if ok then
      return result
    end

    local buffer = bufnr
    if buffer == nil or buffer == 0 then
      buffer = vim.api.nvim_get_current_buf()
    end

    if vim.api.nvim_buf_is_valid(buffer) then
      if vim.b[buffer].treesitter_start_failed then
        return nil
      end
      vim.b[buffer].treesitter_start_failed = true
    end

    vim.schedule(function()
      local filetype = "current buffer"
      if vim.api.nvim_buf_is_valid(buffer) then
        filetype = lang or vim.bo[buffer].filetype or filetype
      elseif lang then
        filetype = lang
      end

      vim.notify(
        string.format("Treesitter unavailable for %s", filetype),
        vim.log.levels.WARN,
        { title = "NeoConfig" }
      )
    end)

    return nil
  end
end

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
