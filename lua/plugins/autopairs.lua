-- ~/.config/nvim/lua/plugins/autopairs.lua

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true, -- treesitter 感知
    })
  end,
}
