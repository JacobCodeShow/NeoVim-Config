return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    local A = require("utils.alpha")

    dashboard.section.header.val = A.logo.header()

    dashboard.section.greeting = {
      type = "text",
      val = string.format("%s, %s 👋", A.greeting.greeting(), A.utils.username()),
      opts = { position = "center", hl = "Type" },
    }

    dashboard.section.sysinfo = {
      type = "text",
      val = A.env.system_info(),
      opts = { position = "center", hl = "Comment" },
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "󰈞  Find File", ":Telescope find_files<CR>"),
      dashboard.button("r", "󰄉  Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("s", "󰆓  Restore Session", ":lua require('persistence').load({ last = true })<CR>"),
      dashboard.button("c", "  Edit Config", ":e ~/.config/nvim/init.lua<CR>"),
      dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
    }

    dashboard.section.footer.val = {
      "",
      "© " .. os.date("%Y") .. "  Neovim • LuaJIT • Engineering Mode",
    }

    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 1 },
      dashboard.section.greeting,
      { type = "padding", val = 1 },
      dashboard.section.sysinfo,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 2 },
      dashboard.section.footer,
    }

    dashboard.config.opts.noautocmd = true
    alpha.setup(dashboard.config)
  end,
}
