-- ~/.config/nvim/lua/plugins/nvimtree.lua

-- vim.opt.splitright = true
-- vim.opt.splitbelow = true

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- 文件图标
  },

  -- ⭐ 文件树建议启动就加载
  lazy = false,

  keys = {
    {
      "<leader>e",
      function()
        require("nvim-tree.api").tree.toggle()
      end,
      desc = "Toggle file explorer",
    },
    {
      "<leader>o",
      function()
        require("nvim-tree.api").tree.focus()
      end,
      desc = "Focus file explorer",
    },
  },

  config = function()
    require("nvim-tree").setup({
      disable_netrw = true,
      hijack_netrw = true,

      update_focused_file = {
        enable = true,      -- ⭐ 核心
        update_root = false,
        ignore_list = {},
      },

      view = {
        width = {
            min = 20,
            max = 32,
        },
        side = "left",
      },

      renderer = {
        highlight_git = true, -- ⭐ 高亮 git 状态
        highlight_opened_files = "name",
        full_name = false,

        icons = {
            show = {
                file = true,
                folder = true,
                git = true,
            },

            glyphs = {
            git = {
                unstaged  = "✗",
                staged    = "✓",
                unmerged  = "",
                renamed   = "➜",
                untracked = "★",
                deleted   = "",
                ignored   = "◌",
            },
            },
        },
      },

      git = {
        enable = true,
        ignore = false,       -- ⭐ 不忽略 .gitignore（看得到所有变更）
        timeout = 400,        -- ⭐ 大仓库防卡顿
      },

      filesystem_watchers = {
        enable = true,
      },

      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
    })
  end,
}
