-- ~/.config/nvim/lua/core/check.lua

local M = {}

local function ensure_lua_ls()
  -- 是否已经有 lua_ls
  for _, client in pairs(vim.lsp.get_active_clients()) do
    if client.name == "lua_ls" then
      return client
    end
  end

  -- 使用真实临时文件触发 lua_ls，避免 scratch buffer 误报
  local previous_buf = vim.api.nvim_get_current_buf()
  local temp_path = vim.fn.tempname() .. ".lua"

  vim.cmd("keepalt edit " .. vim.fn.fnameescape(temp_path))

  local buf = vim.api.nvim_get_current_buf()

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
  if vim.api.nvim_buf_is_valid(previous_buf) then
    vim.api.nvim_set_current_buf(previous_buf)
  end


  if vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_delete(buf, { force = true })
  end

  vim.fn.delete(temp_path)
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
