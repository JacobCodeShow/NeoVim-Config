-- ~/.config/nvim/lua/plugins/bufferline.lua

return {
  "akinsho/bufferline.nvim",
  version = "*",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  event = "VeryLazy",

  keys = {
    { "<S-l>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
    { "<leader>bd", "<cmd>bdelete<CR>", desc = "Delete buffer" },
  },

  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- buffers 而不是 tabs
        diagnostics = "nvim_lsp",

        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },

        show_buffer_icons = true,
        show_close_icon = false,
        separator_style = "thin",
      },
    })
  end,
}
