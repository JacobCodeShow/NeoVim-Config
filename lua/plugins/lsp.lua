-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- mason 仍然负责安装
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd",
        "pyright",
        "lua_ls",
        "bashls",
      },
    })

    -- ⭐ Neovim 0.11 正确入口
    local lsp = vim.lsp

    -- clangd
    lsp.config.clangd = {
      cmd = { "clangd", "--background-index" },
    }

    -- pyright
    lsp.config.pyright = {}

    -- bash
    lsp.config.bashls = {}

    -- lua
    lsp.config.lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end,
}
