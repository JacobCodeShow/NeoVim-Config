-- ~/.config/nvim/lua/core/options.lua

local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = true

-- 缩进
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- behavior
opt.mouse = "a"
opt.clipboard = "unnamedplus"

-- 性能
opt.updatetime = 300
opt.timeoutlen = 400

-- 显示不可见字符
opt.list = true
opt.listchars = {
  space = ".",
  tab = "» ",
  trail = "·",
}

-- UI
opt.cursorline = true
opt.termguicolors = true

-- 保留上下空间（非常重要）
opt.scrolloff = 8
opt.sidescrolloff = 8

-- 统一 UI 栏位，避免跳动
opt.signcolumn = "yes"

-- 分屏行为
opt.splitbelow = true
opt.splitright = true

-- 弱化视觉噪音
opt.showmode = false
opt.laststatus = 3   -- 全局状态栏
