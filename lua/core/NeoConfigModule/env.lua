-- ~/.config/nvim/lua/core/NeoConfigModule/env.lua

local report = require("core.NeoConfigModule.report")

local M = {}

function M.check()
  report.section("Environment")

  local bins = {
    { "git", "git" },
    { "rg", "ripgrep" },
    { "fd", "fd / fdfind" },
    { "node", "nodejs (LSP)" },
    { "clangd", "clangd (C/C++)" },
  }

  for _, b in ipairs(bins) do
    if vim.fn.executable(b[1]) == 1 then
      report.pass(b[2])
    else
      report.fail(b[2], "not found in PATH")
    end
  end
end

return M
