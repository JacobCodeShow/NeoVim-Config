 # NeoVim-Config

![Neovim](https://img.shields.io/badge/Neovim-v0.11.5+-blue)
![License](https://img.shields.io/github/license/JacobCodeShow/NeoVim-Config)



> This is a **personal, self-maintained Neovim configuration**.
> It does NOT aim to be a full-featured distribution like LazyVim or LunarVim.
> The goal is clarity, control, and long-term maintainability.


这是我的个人 **Neovim** 设定仓库，用于打造一个现代、可扩充、适合工程开发的编辑器环境。 \
本设定以 **Lua + lazy.nvim（插件管理器）** 为基础，方便长期维护与扩展。

本设定特别适用于：
- C / C++ / Python / Shell 开发
- Linux / macOS / WSL 环境
- 嵌入式开发、BMC / OpenBMC 专案
- 希望以 Neovim 取代传统 IDE 的开发者
 
 ---
 
## Neovim 版本需求
 
**最低需求：Neovim v0.11.5**
 
本設定依賴 Neovim 0.11 系列的 Lua API、事件機制與插件生態特性；若版本低於 v0.11.5，可能會出現插件報錯或功能不可用。
 
檢查版本：
 
 ```bash
 nvim --version
```

下载/安装：
- 官方网站：https://neovim.io/
- GitHub Releases：https://github.com/neovim/neovim/releases

---

## 仓库结构

本配置遵循标准的 Neovim Lua 目录结构：

```text
NeoVim-Config/
├── init.lua                # 配置入口
├── lua/
│   ├── core/               # 核心配置（options / keymaps / autocmds）
│   └── plugins/            # 插件配置（由 lazy.nvim 管理）
└── README.md               # 说明文档
```

---

## 快速安装

将仓库 clone 到 Neovim 默认配置目录：

- Linux / macOS / WSL：

```bash
git clone https://github.com/JacobCodeShow/NeoVim-Config ~/.config/nvim
```

- Windows（PowerShell）：

```powershell
git clone https://github.com/JacobCodeShow/NeoVim-Config $env:LOCALAPPDATA\nvim
```

启动 Neovim：

```bash
nvim
```

首次启动时，lazy.nvim 会自动安装并同步插件。

---

## 外部依赖（External Dependencies）

部分功能需要额外工具支持：

- `git`：插件管理/拉取仓库
- `ripgrep`：Telescope `live_grep`
- `fd`：Telescope 文件搜索
- `clangd`：C/C++ LSP（推荐用于嵌入式/系统开发）
- `nodejs`：部分 LSP Server 依赖

### Fedora

```bash
sudo dnf install git ripgrep fd-find clang-tools-extra nodejs
```

### Arch

```bash
sudo pacman -S git ripgrep fd clang nodejs
```

---

## 主要特性

- 基于 Lua 的清晰结构，易于维护与扩展
- 使用 lazy.nvim 管理插件，改善启动性能
- LSP 支持（例如 clangd、pyright、bashls）
- Treesitter：更强的语法高亮与语义能力
- Telescope：文件/文本模糊搜索与快速定位
- Git 集成（例如 gitsigns）
- nvim-cmp：自动补全框架
- 状态栏与文件树，提升整体使用体验

---

## 说明

- 本仓库为个人配置，欢迎 Fork 后按需定制
- 设计重点偏向“开发效率”与“可维护性”
- 不依赖大型预设框架（如 LazyVim / LunarVim）

---

## 推荐插件功能一览

| 功能 | 描述 |
| --- | --- |
| LSP | 语言服务器：智能补全、诊断与代码导航 |
| nvim-cmp | 自动补全体验 |
| Treesitter | 语法树级高亮与文本对象 |
| Telescope | 文件/内容搜索与快速定位 |
| gitsigns | Git 状态与差异显示 |
| NvimTree | 侧边文件浏览器 |
| lualine | 状态栏美化 |

---

## 快捷键（节选）

| 按键 | 模式 | 动作 |
| --- | --- | --- |
| `<leader>e` | Normal | 切换文件树 |
| `<leader>ff` | Normal | 查找文件 |
| `<leader>fg` | Normal | 全局搜索（live grep） |
| `<leader>gd` | Normal | 跳转到定义 |
| `<leader>rn` | Normal | 重命名符号 |

---

## 插件概览

- **插件管理**：lazy.nvim
- **LSP 与补全**：nvim-lspconfig、nvim-cmp、LuaSnip
- **语法与 UI**：nvim-treesitter、lualine.nvim、nvim-tree.lua
- **搜索与导航**：telescope.nvim
- **Git**：gitsigns.nvim

---

## 健康检查（Health Check）

如果有功能不符合预期，可运行：

```vim
:checkhealth
```

---

## 兼容性

- ✅ 已在 Neovim **v0.11.5** 测试
- ⚠️ 不支持更低版本

---

## 授权

本项目采用 MIT License，详见 `LICENSE`。

---

## 贡献

如有建议、发现问题或想贡献代码，欢迎提交 Issue / Pull Request。
