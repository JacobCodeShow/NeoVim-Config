-- ~/.config/nvim/lua/core/NeoConfigModule/env.lua

local report = require("core.NeoConfigModule.report")

local M = {}

local function has_executable(commands)
  if type(commands) == "string" then
    return vim.fn.executable(commands) == 1
  end

  for _, command in ipairs(commands) do
    if vim.fn.executable(command) == 1 then
      return true
    end
  end

  return false
end

function M.check()
  report.section("Environment")

  local bins = {
    { "git", "git" },
    { "rg", "ripgrep" },
    { { "fd", "fdfind" }, "fd / fdfind" },
    { "node", "nodejs (LSP)" },
    { "clangd", "clangd (C/C++)" },
  }

  for _, b in ipairs(bins) do
    if has_executable(b[1]) then
      report.pass(b[2])
    else
      report.fail(b[2], "not found in PATH")
    end
  end
end

return M
