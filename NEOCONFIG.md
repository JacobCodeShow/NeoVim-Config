# NeoConfig 使用说明

## 简介

NeoConfig 是一个面向 Neovim 的配置管理模块，提供统一的配置入口、命令与导入/导出能力，便于集中管理核心选项、键位映射与插件相关配置。

---

## 功能概览

1. **配置管理**
   - 统一管理 Neovim 核心选项、键位绑定、自动命令等。
   - 配置文件位于 `lua/core/neoconfig.lua`。

2. **导入（Import）**
   - 支持导入其他配置文件或模块。
   - 使用命令：
     ```vim
     :NeoConfigImport <path/to/config>
     ```
   - 可用于动态加载不同配置，实现模块化管理。

3. **导出**
   - 支持将当前键位或配置导出为 Markdown 或 JSON 文件。
   - 默认导出文件示例：
     ```text
     KEYMAPS.md
     ```
   - 用于团队共享或文档记录。

4. **插件配置**
   - 可与 Lazy.nvim 配合，将 NeoConfig 配置为本地插件：
     ```lua
     require('lazy').setup('lua/plugins/neoconfig.lua')
     ```
   - 确保 NeoConfig 在启动时自动加载。

5. **LSP/插件集成**
   - NeoConfig 支持集成 LSP、Treesitter、Telescope 等插件配置。
   - 可集中管理键位映射与自动命令，便于快速开发。

---

## 快捷命令

| 命令 | 功能 |
| --- | --- |
| `:NeoConfigImport <file>` | 导入指定配置模块 |
| `:NeoConfigExportKeymaps` | 导出当前键位映射为 `KEYMAPS.md` |
| `:NeoConfigReload` | 重新加载 NeoConfig 配置 |
| `:NeoConfigDoctor` | 检查 NeoConfig 配置状态 |

---

## 目录结构

```text
~/.config/nvim
├── CONTRIBUTING.md
├── init.lua
├── lazy-lock.json
├── LICENSE
├── lua
│   ├── config
│   │   └── lazy.lua
│   ├── core
│   │   ├── neoconfig.lua
│   │   ├── NeoConfigModule
│   │   │   ├── diagnostics.lua
│   │   │   ├── env.lua
│   │   │   ├── importers
│   │   │   │   ├── init.lua
│   │   │   │   └── keymaps.lua
│   │   │   ├── import.lua
│   │   │   ├── initcmd.lua
│   │   │   ├── init.lua
│   │   │   ├── lsp.lua
│   │   │   ├── luarc.lua
│   │   │   └── report.lua
│   │   └── version.lua
│   ├── plugins
│   │   └── neoconfig.lua
└── README.md
```

---

## 使用示例

```lua
-- 导入自定义键位模块
require('core.neoconfig').import('core.NeoConfigModule.importers.keymaps')

-- 导出键位映射
require('core.neoconfig').export_keymaps('KEYMAPS.md')
```

---

## 注意事项

1. NeoConfig 依赖 Lazy.nvim 管理插件。
2. 导出文件如为临时产物，建议加入 `.gitignore`，避免误提交。
3. 导入（Import）支持模块化配置，但路径/模块名必须正确。

