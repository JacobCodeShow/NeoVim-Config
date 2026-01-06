-- ~/.config/nvim/lua/plugins/colorstheme.lua

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- 必须高，防止被覆盖
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato", -- latte / frappe / macchiato / mocha
      transparent_background = false,
      term_colors = true,

      integrations = {
        nvimtree = true,
        treesitter = true,
        gitsigns = true,
        telescope = true,
        bufferline = true,
        lsp_trouble = true,
        which_key = true,
        indent_blankline = {
          enabled = true,
          scope_color = "surface2",
        },
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
