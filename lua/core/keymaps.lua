-- ~/.config/nvim/lua/core/keymaps.lua

local map = vim.keymap.set
local opts = {noremap = true, silent = true}

-- C : Ctrl
-- A : Alt
-- Leader: space

-- save/exit
map("n", "<leader>w", "<cwd>w<cr>", opts)
map("n", "<leader>q", "<cwd>q<cr>", opts)

-- window
map("n", "<leader>sv", "<C-w>v", opts)
map("n", "<leader>sh", "<C-w>s", opts)
map("n", "<leader>sx", "<C-w>c", opts)

-- insert fast exit
map("i", "jk", "<Esc>", opts)

local term = require("core.terminal")

-- 主终端
map("n", "<C-\\>", term.toggle_main, { desc = "Main terminal" })

-- Build 终端
map("n", "<leader>tb", term.toggle_build, { desc = "Build terminal" })

-- SSH / BMC
-- map("n", "<leader>ts", function()
--   term.toggle_ssh("ssh root@192.168.1.100")
-- end, { desc = "SSH terminal" })

-- 一次性命令
map("n", "<leader>tr", function()
  term.run_once("htop")
end, { desc = "Run once command" })

-- terminal 模式退出
map("t", "<Esc>", [[<C-\><C-n>]])


-- Ctrl + b 打开侧边栏
map("n", "<C-b>", "<cmd>NvimTreeFindFileToggle<CR>", {
  desc = "Toggle File Explorer (Focus Current File)",
  silent = true,
})

map("n", "<leader>e", ":NvimTreeFindFile<CR>", opts)


--------------------------------------------------
-- 注释（Ctrl + /）
--------------------------------------------------
-- 普通模式：注释当前行
map("n", "<C-_>", "gcc", { remap = true, silent = true })
-- 可视模式：注释选中行
map("v", "<C-_>", "gc",  { remap = true, silent = true })

--------------------------------------------------
-- 缩进（保持选区）
--------------------------------------------------
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

--------------------------------------------------
-- 复制 / 剪切 / 粘贴（系统剪贴板）
--------------------------------------------------
map({ "n", "v" }, "<C-c>", '"+y', opts)
map({ "n", "v" }, "<C-x>", '"+d', opts)
map({ "n", "v" }, "<C-v>", '"+p', opts)

--------------------------------------------------
-- 移动行 / 块（Alt + j / k）
--------------------------------------------------
-- 普通模式
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)

-- 可视模式
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

--------------------------------------------------
-- 跳转历史（Alt + ← / →）
--------------------------------------------------
map("n", "<A-Left>",  "<C-o>", opts) -- 后退
map("n", "<A-Right>", "<C-i>", opts) -- 前进

--------------------------------------------------
-- 窗口切换
--------------------------------------------------
map("n", "<C-h>", "<C-w>h", opts) -- 左
map("n", "<C-j>", "<C-w>j", opts) -- 下
map("n", "<C-k>", "<C-w>k", opts) -- 上
map("n", "<C-l>", "<C-w>l", opts) -- 右

-- terminal-mode window navigation
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
-- map("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    pcall(vim.keymap.del, "t", "<C-l>", { buffer = 0 })
  end,
})

