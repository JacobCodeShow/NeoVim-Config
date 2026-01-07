-- ~/.config/nvim/lua/core/NeoConfigModule/importers/init.lua

local M = {}

local registry = {
  keymaps = require("core.NeoConfigModule.importers.keymaps"),
}

function M.get(name)
  return registry[name]
end

function M.list()
  local names = {}
  for k in pairs(registry) do
    table.insert(names, k)
  end
  table.sort(names)

  vim.notify(
    "NeoConfig import targets:\n- " .. table.concat(names, "\n- "),
    vim.log.levels.INFO
  )
end

return M
