-- ~/.config/nvim/lua/core/neoconfig.lua
-- 这个文件是neoconfig的主文件，用于处理neoconfig相关的命令

local version = require("core.version").version
local Doctor = require("core.NeoConfigModule")
local InitCmd = require("core.NeoConfigModule.initcmd")

local M = {}

-- if vim.g.neoconfig_sudo then
--   vim.notify(
--     "NeoConfig: sudo mode (checks disabled)",
--     vim.log.levels.WARN
--   )
--   return {}
-- end


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

handlers.import = function(arg)
  local opts = {}

  if arg == "" then
    opts.target = "keymaps"
  elseif arg == "list" then
    opts.list = true
  else
    opts.target = arg
  end

  require("core.NeoConfigModule.import").run(opts)
end


handlers.help = function()
  notify([[
NeoConfig CLI
A modular Neovim configuration toolkit

Usage:
  :NeoConfig <command> [options]

Core commands:
  version               Show NeoVim-Config version
  doctor                Run full environment & LSP diagnostics
  info                  Show config, runtime and system info
  paths                 Show Neovim paths (config/data/cache/state)
  help                  Show this help message

Import / Export:
  import                Export resources (default: keymaps)
  import keymaps        Export all key mappings to KEYMAPS.md
  import list           List available import targets

Doctor details:
  - Checks required binaries (git, rg, fd, node, clangd, ...)
  - Verifies LSP servers (lua_ls, clangd, pyright, ...)
  - Validates diagnostics & Lua environment
  - Supports strict mode (used internally)

Notes:
  - In sudo mode, checks are automatically disabled
  - Output files are written under ~/.config/nvim
  - This config targets Neovim >= 0.11

Project:
  https://github.com/JacobCodeShow/NeoVim-Config
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
      "import",
      "paths",
      "help",
    }
  end
})

return M
