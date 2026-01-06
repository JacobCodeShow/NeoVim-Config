-- ~/.config/nvim/lua/plugins/gitsigns.lua

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },

  keys = {
    { "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "Git stage hunk" },
    { "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "Git reset hunk" },
    { "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Git preview hunk" },
    { "<leader>hb", function() require("gitsigns").blame_line() end, desc = "Git blame line" },
    { "<leader>hS", function() require("gitsigns").stage_buffer() end, desc = "Git stage buffer" },
    { "<leader>hR", function() require("gitsigns").reset_buffer() end, desc = "Git reset buffer" },
  },

  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },

      signcolumn = true,
      numhl      = false,
      linehl     = false,

      current_line_blame = true,
      current_line_blame_opts = {
        delay = 600,
        virt_text_pos = "eol",
      },

      update_debounce = 200,

      preview_config = {
        border = "rounded",
        style = "minimal",
      },
    })
  end,
}
