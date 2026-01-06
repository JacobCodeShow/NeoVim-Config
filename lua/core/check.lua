-- ~/.config/nvim/lua/core/check.lua

local M = {}

local function ensure_lua_ls()
  -- 是否已经有 lua_ls
  for _, client in pairs(vim.lsp.get_active_clients()) do
    if client.name == "lua_ls" then
      return client
    end
  end

  -- 创建一个临时 lua buffer 触发 LSP
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, "[NeoConfig Check]")
  vim.api.nvim_buf_set_option(buf, "filetype", "lua")

  vim.api.nvim_set_current_buf(buf)

  -- 等待 lua_ls attach（最多 2 秒）
  local ok = vim.wait(2000, function()
    for _, client in pairs(vim.lsp.get_active_clients()) do
      if client.name == "lua_ls" then
        return true
      end
    end
    return false
  end, 50)

  if not ok then
    return nil
  end

  -- 清理 buffer
  vim.api.nvim_buf_delete(buf, { force = true })

  -- 返回 client
  for _, client in pairs(vim.lsp.get_active_clients()) do
    if client.name == "lua_ls" then
      return client
    end
  end
end

local function collect_diagnostics()
  local diags = {}

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if name:find("config/nvim/lua") then
      for _, d in ipairs(vim.diagnostic.get(buf)) do
        table.insert(diags, d)
      end
    end
  end

  return diags
end

function M.run()
  print("NeoConfig check\n")

  local lua_ls = ensure_lua_ls()
  if not lua_ls then
    vim.notify("✗ lua-language-server failed to start", vim.log.levels.ERROR)
    return
  end

  vim.notify("✓ lua-language-server running", vim.log.levels.INFO)

  local diags = collect_diagnostics()
  if #diags == 0 then
    vim.notify("✓ No diagnostics found", vim.log.levels.INFO)
    return
  end

  vim.notify("✗ Diagnostics found:", vim.log.levels.ERROR)
  for _, d in ipairs(diags) do
    print("  - " .. d.message)
  end
end

return M
