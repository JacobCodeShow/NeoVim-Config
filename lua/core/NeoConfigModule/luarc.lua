-- ~/.config/nvim/lua/core/NeoConfigModule/luarc.lua

local M = {}

local function luarc_path()
  return vim.fn.stdpath("config") .. "/.luarc.json"
end

local TEMPLATE = [[
{
  "$schema": "https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json",
  "runtime": {
    "version": "LuaJIT"
  },
  "diagnostics": {
    "globals": ["vim"]
  },
  "workspace": {
    "checkThirdParty": false,
    "library": [
      "$VIMRUNTIME",
      "${3rd}/luv/library"
    ]
  },
  "telemetry": {
    "enable": false
  }
}
]]

function M.ensure()
  local path = luarc_path()

  if vim.fn.filereadable(path) == 1 then
    return
  end

  vim.schedule(function()
    vim.notify(
      ".luarc.json not found in ~/.config/nvim\nThis is required for lua_ls diagnostics",
      vim.log.levels.WARN,
      {
        title = "NeoConfig",
        actions = {
          ["Generate"] = function()
            vim.fn.writefile(vim.split(TEMPLATE, "\n"), path)
            vim.notify(".luarc.json generated in ~/.config/nvim", vim.log.levels.INFO, {
              title = "NeoConfig",
            })
          end,
        },
      }
    )
  end)
end

function M.exists()
  return vim.fn.filereadable(luarc_path()) == 1
end

function M.fix()
  if M.exists() then
    return
  end

  local path = vim.fn.stdpath("config") .. "/.luarc.json"
  vim.fn.writefile(vim.split(TEMPLATE, "\n"), path)

  vim.notify(
    "Generated ~/.config/nvim/.luarc.json",
    vim.log.levels.INFO,
    { title = "NeoConfig" }
  )
end


return M
