-- ~/.config/nvim/lua/core/NeoConfigModule/initcmd.lua

local luarc = require("core.NeoConfigModule.luarc")

local M = {}

function M.run()
  local created = {}

  if not luarc.exists() then
    luarc.fix()
    table.insert(created, ".luarc.json")
  end

  if #created == 0 then
    vim.notify(
      "NeoConfig already initialized",
      vim.log.levels.INFO,
      { title = "NeoConfig" }
    )
    return
  end

  vim.notify(
    "NeoConfig initialized:\n- " .. table.concat(created, "\n- "),
    vim.log.levels.INFO,
    { title = "NeoConfig" }
  )
end

return M
