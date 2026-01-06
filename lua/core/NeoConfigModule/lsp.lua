-- ~/.config/nvim/lua/core/NeoConfigModule/lsp.lua

local report = require("core.NeoConfigModule.report")

local M = {}

local function mason_bin(bin)
  return vim.fn.stdpath("data") .. "/mason/bin/" .. bin
end

local function ensure_lua_ls()
  for _, c in ipairs(vim.lsp.get_active_clients()) do
    if c.name == "lua_ls" then
      return true
    end
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "filetype", "lua")
  vim.api.nvim_set_current_buf(buf)

  local ok = vim.wait(2000, function()
    for _, c in ipairs(vim.lsp.get_active_clients()) do
      if c.name == "lua_ls" then
        return true
      end
    end
    return false
  end, 50)

  vim.api.nvim_buf_delete(buf, { force = true })
  return ok
end

function M.check()
  report.section("Lua / LSP")

  local cmd = mason_bin("lua-language-server")
  if vim.fn.executable(cmd) ~= 1 then
    report.fail("lua-language-server", "install via :Mason")
    return
  end

  report.pass("lua-language-server found")

  if ensure_lua_ls() then
    report.pass("lua_ls running")
  else
    report.fail("lua_ls failed to start", "check lsp.lua cmd configuration")
  end
end

return M
