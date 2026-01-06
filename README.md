 # NeoVim-Config
 
這是我的個人 **Neovim** 設定倉庫，用於打造一個現代、可擴充、適合工程開發的編輯器環境。\
本設定以 **Lua + lazy.nvim（插件管理器）** 為基礎，方便長期維護與擴展。
 
本設定特別適用於：
- C / C++ / Python / Shell 開發
- Linux / macOS / WSL 環境
- 嵌入式開發、BMC / OpenBMC 專案
- 希望以 Neovim 取代傳統 IDE 的開發者
 
 ---
 
## Neovim 版本需求
 
**最低需求：Neovim v0.11.5**
 
本設定依賴 Neovim 0.11 系列的 Lua API、事件機制與插件生態特性；若版本低於 v0.11.5，可能會出現插件報錯或功能不可用。
 
檢查版本：
 
 ```bash
 nvim --version
```

下載 / 安裝：
- 官方網站：https://neovim.io/
- GitHub Releases：https://github.com/neovim/neovim/releases
 
---

## 倉庫結構

本設定遵循標準的 Neovim Lua 結構：

```text
 NeoVim-Config/
├── init.lua                # 設定入口
 ├── lua/
│   ├── core/               # 核心設定（options / keymaps / autocmds）
│   └── plugins/            # 插件設定（由 lazy.nvim 管理）
└── README.md               # 說明文件
```

---

## 快速安裝

將設定 clone 到 Neovim 預設設定目錄：

- Linux / macOS / WSL：

```bash
 git clone https://github.com/JacobCodeShow/NeoVim-Config ~/.config/nvim
```

- Windows（PowerShell）：

```powershell
git clone https://github.com/JacobCodeShow/NeoVim-Config $env:LOCALAPPDATA\nvim
```

啟動 Neovim：
 
```bash
 nvim
```

首次啟動時，lazy.nvim 會自動安裝並同步插件。
 
---

## 主要特性

- 基於 Lua 的清晰結構，易於維護與擴展
- 使用 lazy.nvim 進行插件管理，改善啟動效能
- LSP 支援（例如 clangd、pyright、bashls）
- Treesitter：更強的語法高亮與語意能力
- Telescope：檔案/文字的模糊搜尋與快速定位
- Git 整合（例如 gitsigns）
- nvim-cmp：自動補全框架
- 狀態列與檔案樹，提升整體使用體驗

---

## 特別說明

- 本倉庫為個人設定，歡迎 Fork 後依需求客製化
- 設計重點偏向「開發效率」與「可維護性」
- 不依賴大型預設框架（如 LazyVim / LunarVim）
 
---

## 推薦插件功能一覽

| 功能 | 描述 |
| --- | --- |
| LSP | 語言伺服器：智能補全、診斷與程式碼導航 |
| nvim-cmp | 自動補全體驗 |
| Treesitter | 語法樹級高亮與文字物件 |
| Telescope | 檔案/搜尋快速定位 |
| gitsigns | Git 狀態與差異顯示 |
| NvimTree | 側邊檔案瀏覽器 |
| lualine | 狀態列美化 |

---

## 授權

本專案採用 MIT License，詳見 `LICENSE`。

---

## 參與貢獻

如有建議、發現問題或想貢獻程式碼，歡迎提交 Issue / Pull Request。
