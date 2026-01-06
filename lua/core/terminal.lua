-- ~/.config/nvim/lua/core/terminal.lua

-- local M = {}

-- function M.toggle()
--   -- 如果在 NvimTree，先跳出来
--   if vim.bo.filetype == "NvimTree" then
--     vim.cmd("wincmd l")
--   end

--   -- ToggleTerm 自己管理 window
--   vim.cmd("ToggleTerm")
-- end

-- return M

local M = {}

local Terminal = nil

local function get_terminal()
  if Terminal then
    return Terminal
  end

  local ok, term = pcall(require, "toggleterm.terminal")
  if not ok then
    vim.notify(
      "ToggleTerm not loaded",
      vim.log.levels.ERROR,
      { title = "NeoConfig" }
    )
    return nil
  end

  Terminal = term.Terminal
  return Terminal
end

----------------------------------------------------------------
-- Terminal instances (lazy)
----------------------------------------------------------------

local terminals = {}

local function ensure_term(name, opts)
  if terminals[name] then
    return terminals[name]
  end

  local T = get_terminal()
  if not T then
    return nil
  end

  terminals[name] = T:new(opts)
  return terminals[name]
end

----------------------------------------------------------------
-- Helpers
----------------------------------------------------------------

local function leave_tree()
  if vim.bo.filetype == "NvimTree" then
    vim.cmd("wincmd l")
  end
end

----------------------------------------------------------------
-- Public API
----------------------------------------------------------------

function M.toggle_main()
  leave_tree()
  local term = ensure_term("main", {
    id = 1,
    direction = "horizontal",
    size = 15,
  })
  if term then term:toggle() end
end

function M.toggle_build()
  leave_tree()
  local term = ensure_term("build", {
    id = 2,
    direction = "horizontal",
    size = 15,
  })
  if term then term:toggle() end
end

function M.toggle_ssh(cmd)
  leave_tree()
  local term = ensure_term("ssh", {
    id = 3,
    direction = "float",
    cmd = cmd,
  })
  if term then term:toggle() end
end

function M.run_once(cmd)
  leave_tree()
  local term = ensure_term("temp", {
    id = 4,
    direction = "float",
    close_on_exit = true,
    cmd = cmd,
  })
  if term then term:toggle() end
end

return M
