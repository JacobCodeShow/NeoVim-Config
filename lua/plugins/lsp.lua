-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- mason 仍然负责安装
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
          "clangd",
          "lua_ls",
          "pyright",
          "bashls",
          "jsonls",
      },
    })

    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local function mason_cmd(bin)
        return vim.fn.stdpath("data") .. "/mason/bin/" .. bin
    end

    local on_attach = require("core.lsp").on_attach

      ------------------------------------------------------------------
      -- Server definitions (pure data)
      ------------------------------------------------------------------

    local servers = {
      clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
        },
      },

      pyright = {},

      bashls = {},

      jsonls = {},

      lua_ls = {
        cmd = { mason_cmd("lua-language-server") },
        settings = {
          runtime = {
            version = "LuaJIT",
          },
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      },
    }

    ------------------------------------------------------------------
    -- Neovim 0.11+ official LSP registration
    ------------------------------------------------------------------
    for name, config in pairs(servers) do
      vim.lsp.config(name, vim.tbl_deep_extend("force", {
        capabilities = capabilities,
        on_attach = on_attach,
      }, config))
    end
  end,
}
