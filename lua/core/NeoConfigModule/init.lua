-- ~/.config/nvim/lua/core/NeoConfigModule/init.lua

local report = require("core.NeoConfigModule.report")
local env = require("core.NeoConfigModule.env")
local lsp = require("core.NeoConfigModule.lsp")
local diagnostics = require("core.NeoConfigModule.diagnostics")
local luarc = require("core.NeoConfigModule.luarc")

local M = {}

function M.run(opts)
  opts = opts or {}

  report.start()

  env.check()
  lsp.check()
  diagnostics.check()

  if opts.fix then
    luarc.fix()
  end

  report.finish()

  if opts.strict then
    return report.fail_count == 0
  end

  return true
end

return M
