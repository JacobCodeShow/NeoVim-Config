-- ~/.config/nvim/lua/core/neoconfig.lua

local version = require("core.version").version
local Doctor = require("core.NeoConfigModule")
local InitCmd = require("core.NeoConfigModule.initcmd")

local M = {}

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "NeoConfig" })
end

local handlers = {}

handlers.version = function()
  notify("NeoVim-Config version " .. version)
end

handlers.init = function()
  InitCmd.run()
end

handlers.info = function()
  notify(table.concat({
    "NeoVim-Config",
    "Version: " .. version,
    "Neovim: " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
    "LuaJIT: " .. (jit and jit.version or "N/A"),
  }, "\n"))
end

handlers.paths = function()
  notify(table.concat({
    "Config: " .. vim.fn.stdpath("config"),
    "Data:   " .. vim.fn.stdpath("data"),
    "Cache:  " .. vim.fn.stdpath("cache"),
    "State:  " .. vim.fn.stdpath("state"),
  }, "\n"))
end

handlers.doctor = function(arg)
  local opts = {
    strict = arg == "--strict",
    fix = arg == "--fix",
  }
  local ok = Doctor.run({ opts })

  if opts.strict and not ok then
    if vim.fn.has("gui_running") == 1 or vim.fn.has("nvim") == 1 then
      vim.notify(
        "NeoConfig doctor failed (strict mode)",
        vim.log.levels.ERROR,
        { title = "NeoConfig" }
      )
    end
    error("NeoConfig doctor failed (strict mode)")
  end
end

handlers.help = function()
  notify([[
NeoConfig CLI

Usage:
  :NeoConfig <command>

Commands:
  version               Show config version
  doctor                Full environment & LSP diagnostics
  info                  Show config & runtime info
  paths                 Show nvim paths
  help                  Show this help
]])
end

vim.api.nvim_create_user_command("NeoConfig", function(opts)
  local args = vim.split(opts.args or "", "%s+")
  local cmd = args[1]
  local opt = args[2]

  if cmd == "" or cmd == "help" then
    handlers.help()
    return
  end

  if cmd == "version" then
    handlers.version()
    return
  end

  local handler = handlers[cmd]
  if handler then
    handler(opt)
  else
    notify("Unknown command: " .. cmd, vim.log.levels.WARN)
  end
end, {
  nargs = "*",
  complete = function()
    return {
      "doctor",
      "doctor --fix",
      "doctor --strict",
      "init",
      "version",
      "info",
      "paths",
      "help",
    }
  end
})

return M
