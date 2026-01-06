-- ~/.config/nvim/lua/core/NeoConfigModule/diagnostics.lua

local report = require("core.NeoConfigModule.report")

local report = require("core.NeoConfigModule.report")
local luarc = require("core.NeoConfigModule.luarc")

local M = {}

function M.check()
  report.section("LSP Diagnostics")

  local errors = {}

  function M.check()
  if luarc.exists() then
      report.pass("~/.config/nvim/.luarc.json")
  else
      report.fail(
      "~/.config/nvim/.luarc.json missing",
      "Will be generated automatically on startup"
      )
  end
  end

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if name:find("config/nvim/lua") then
      for _, d in ipairs(vim.diagnostic.get(buf)) do
        if d.severity == vim.diagnostic.severity.ERROR then
          table.insert(errors, { msg = d.message, file = name })
        end
      end
    end
  end

  if #errors == 0 then
    report.pass("no errors")
    return
  end

  report.fail("diagnostics errors found")
  for _, e in ipairs(errors) do
    print("  ERROR: " .. e.msg)
    print("  file:  " .. e.file)
  end
end

return M
