-- lua/core/lsp.lua
-- local tb = require("telescope.builtin")

-- local M = {}

-- function M.on_attach(client, bufnr)
--   -- 手动设置位置编码
--   client.resolved_capabilities.document_formatting = true
--   client.resolved_capabilities.document_range_formatting = true

--   -- 关键代码
--   client.config.capabilities.textDocument.positionEncoding = "utf-8"
--   -- buffer 局部 LSP keymap
--   vim.keymap.set("n", "gd", tb.lsp_definitions,    { buffer = bufnr, desc = "Go to definition" })
--   vim.keymap.set("n", "gi", tb.lsp_implementations,{ buffer = bufnr, desc = "Go to implementation" })
--   vim.keymap.set("n", "gr", tb.lsp_references,     { buffer = bufnr, desc = "Show references" })
--   vim.keymap.set("n", "gD", tb.lsp_type_definitions,{ buffer = bufnr, desc = "Type definition" })

--     -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
--     -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
--     -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
--     -- vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })

-- end

-- return M

-- lua/core/lsp.lua
local M = {}

local tb = require("telescope.builtin")

local function smart_gd()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
    if result == nil or vim.tbl_isempty(result) then
      vim.lsp.buf_request(0, "textDocument/declaration", params, tb.lsp_definitions)
    else
      tb.lsp_definitions()
    end
  end)
end

-- on_attach 函数
function M.on_attach(client, bufnr)
  print("LSP client attached:", client.name, "buffer:", bufnr)

  -- keymap 选项
  local opts = { buffer = bufnr, silent = true, noremap = true }

  -- LSP + Telescope keymaps
  vim.keymap.set("n", "gd", tb.lsp_definitions, opts)       -- 跳转到定义
-- vim.keymap.set("n", "gd", smart_gd, opts)
  vim.keymap.set("n", "gi", tb.lsp_implementations, opts)   -- 跳转到实现
  vim.keymap.set("n", "gr", tb.lsp_references, opts)        -- 查看引用
  vim.keymap.set("n", "gD", tb.lsp_type_definitions, opts)  -- 类型定义
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)         -- 查看文档
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)  -- 重命名

  -- 如果需要，可以打印调试信息
  vim.notify("Keymaps for LSP bound to buffer " .. bufnr)
end

return M
