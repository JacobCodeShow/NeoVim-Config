-- ~/.config/nvim/lua/plugins/toggleterm.lua

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- 底部终端
      direction = "horizontal",     -- ⭐ 永远底部
      size = 15,                    -- 底部高度

      -- 打开/关闭快捷键：Ctrl + `
    --   open_mapping = [[<C-`>]],

      start_in_insert = true,       -- ⭐ 打开就能敲命令

      shade_terminals = true,
      shading_factor = 2,

      close_on_exit = true,

      -- 不抢窗口布局
      persist_size = true,

      -- ⭐ 关键：强制使用“主窗口”
      -- 避免在 nvim-tree / sidebar 中 split
      insert_mappings = true,
      terminal_mappings = true,

      -- ⭐ 防止全屏行为
      persist_mode = false,
    })
  end,
}
