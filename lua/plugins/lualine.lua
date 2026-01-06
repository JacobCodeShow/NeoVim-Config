-- ~/.config/nvim/lua/plugins/lualine.lua

local version = require("core.version").version
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("lualine").setup({
      options = {
        -- theme = "catppuccin",
        globalstatus = true,    -- ⭐ 统一状态栏（推荐）
        section_separators = "", --{ left = "", right = "" },
        component_separators = "", -- { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "NvimTree" },
        },
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },

        -- ⭐ git diff（来自 gitsigns）
        lualine_c = {
          {
            "diff",
            symbols = { added = "+", modified = "~", removed = "-" },
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
          },
        },

        lualine_x = {
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then
                return "No LSP"
              end
              return " " .. clients[1].name
            end,
          },
          "encoding",
          "fileformat",
          "filetype",
          function()
            return "NVIM v" .. version
          end,
        },

        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
