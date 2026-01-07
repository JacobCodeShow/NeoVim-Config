-- ~/.config/nvim/lua/core/NeoConfigModule/import.lua

local importers = require("core.NeoConfigModule.importers")

local M = {}

---@param opts table|nil
function M.run(opts)
  opts = opts or {}

  if opts.list then
    importers.list()
    return
  end

  local name = opts.target or "keymaps"

  local exporter = importers.get(name)
  if not exporter then
    vim.notify(
      "NeoConfig import: unknown target '" .. name .. "'",
      vim.log.levels.ERROR
    )
    return
  end

  exporter.run(opts)
end

return M
