# NeoConfig 使用说明

## 简介

NeoConfig 是当前配置仓库内置的命令入口，统一提供版本信息、环境检查、初始化和导出能力。
命令入口定义在 `lua/core/neoconfig.lua`，通过单一命令 `:NeoConfig` 暴露子命令，而不是多个独立命令。

---

## 命令用法

```vim
:NeoConfig <command> [options]
```

### 可用命令

| 命令 | 功能 |
| --- | --- |
| `:NeoConfig help` | 显示帮助信息 |
| `:NeoConfig version` | 显示 NeoVim-Config 版本 |
| `:NeoConfig info` | 显示版本、Neovim 与 LuaJIT 信息 |
| `:NeoConfig paths` | 显示 config/data/cache/state 路径 |
| `:NeoConfig init` | 初始化 NeoConfig 运行所需文件 |
| `:NeoConfig doctor` | 执行环境、LSP 与诊断检查 |
| `:NeoConfig doctor --fix` | 自动补齐缺失的 `.luarc.json` |
| `:NeoConfig doctor --strict` | 检查失败时返回错误，适合 CI |
| `:NeoConfig import` | 导出资源，默认导出键位到 `KEYMAPS.md` |
| `:NeoConfig import keymaps` | 导出所有键位到 `~/.config/nvim/KEYMAPS.md` |
| `:NeoConfig import list` | 列出可用导出目标 |

---

## 当前行为说明

### init

`init` 目前主要用于初始化 LuaLS 相关文件。
如果 `~/.config/nvim/.luarc.json` 不存在，会自动生成；如果已经存在，则仅提示已初始化。

### doctor

`doctor` 会检查：

- 必需工具是否存在，例如 `git`、`rg`、`fd / fdfind`、`node`、`clangd`
- `lua-language-server` 是否可执行并能正常附着
- 当前配置中的 Lua 诊断是否存在错误
- `.luarc.json` 是否存在

`--fix` 会在缺少 `.luarc.json` 时自动生成该文件。  
`--strict` 会在存在失败项时抛出错误，适合在自动化流程里作为失败条件。

### import

虽然子命令名是 `import`，当前实现实际承担的是“导出”职责。默认目标是 `keymaps`，会把当前键位表写入 `KEYMAPS.md`。

---

## 目录结构

```text
~/.config/nvim
├── init.lua
├── lua
│   ├── core
│   │   ├── neoconfig.lua
│   │   └── NeoConfigModule
│   │       ├── diagnostics.lua
│   │       ├── env.lua
│   │       ├── import.lua
│   │       ├── importers/
│   │       ├── init.lua
│   │       ├── initcmd.lua
│   │       ├── lsp.lua
│   │       ├── luarc.lua
│   │       └── report.lua
│   └── plugins
│       └── neoconfig.lua
├── README.md
└── NEOCONFIG.md
```

---

## 常用示例

```vim
:NeoConfig info
:NeoConfig paths
:NeoConfig doctor
:NeoConfig doctor --strict
:NeoConfig init
:NeoConfig import keymaps
```

---

## 注意事项

1. NeoConfig 通过 `:NeoConfig` 统一暴露子命令，不再使用 `:NeoConfigDoctor`、`:NeoConfigImport` 这类独立命令名。
2. `import` 当前默认输出文件为 `~/.config/nvim/KEYMAPS.md`，如果只是临时产物，建议不要提交到仓库。
3. 当前配置目标为 Neovim 0.11+；严格检查建议配合 `:NeoConfig doctor --strict` 使用。

