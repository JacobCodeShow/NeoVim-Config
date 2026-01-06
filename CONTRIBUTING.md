# NeoVim-Config 贡献指南

感谢你愿意为 NeoVim-Config 做贡献。
本项目遵循偏工程化的协作约定，以保证：可读性、稳定性与自动化友好（CI 可验证）。

---

## Commit Message 规范

提交信息采用 **Conventional Commits** 风格（灵感来源，非强制完全一致）。

**基本格式：**

```text
<type>(<scope>): <subject>
```

**示例：**

```text
feat(neoconfig): add doctor command with strict mode
```

---

## Commit Types

| Type | 说明 |
| --- | --- |
| feat | 新功能 |
| fix | Bug 修复 |
| refactor | 重构（不改变外部行为） |
| perf | 性能优化 |
| docs | 仅文档变更 |
| test | 仅测试变更 |
| chore | 工具/CI/日常维护 |
| style | 格式化/Lint（无逻辑变更） |

---

## 推荐 Scopes

scope 用来说明**影响范围/子系统**，便于 review 与追踪。

| Scope | 含义 |
| --- | --- |
| neoconfig | NeoConfig CLI / 入口 |
| doctor | 诊断/健康检查 |
| lsp | LSP / lua_ls / mason |
| lua | Lua 工具链/格式化 |
| ui | UI / keymaps / layout |
| core | 核心工具与通用逻辑 |
| ci | GitHub Actions / 自动化 |

**示例：**

```text
feat(doctor): add --fix option for auto repair
```

---

## Subject 行规则

- 使用**祈使语气**：`add` / `fix` / `refactor`（避免 `added` / `fixing`）
- 末尾不加句号
- 建议不超过 72 个字符
- 描述“做了什么”，不要写实现细节（what > how）

**Good：**

```text
fix(lsp): resolve lua_ls not attaching to nvim config
```

**Bad：**

```text
fixed the lua language server issue.
```

---

## Body（可选，但推荐）

当变更不止一件事时，建议补充 body，用要点列清楚：

```text
feat(neoconfig): add init command for bootstrap

- generate ~/.config/nvim/.luarc.json
- prepare lua_ls diagnostics
- ensure safe re-run behavior
```

---

## Breaking Changes

如果提交包含破坏性变更，请在提交信息中明确标注：

```text
BREAKING CHANGE: <description>
```

**示例：**

```text
refactor(core): change NeoConfig module layout

BREAKING CHANGE: module paths under core/NeoConfigModule
```

---

## 版本管理（Semantic Versioning）

本项目采用语义化版本：`MAJOR.MINOR.PATCH`

- **MAJOR**：破坏性变更
- **MINOR**：新增功能
- **PATCH**：修复问题

查看版本：

```vim
:NeoConfig --version
```

---

## CI 期望

所有提交应通过以下检查（本地可先跑一遍再提 PR）：

```vim
:NeoConfig doctor
:NeoConfig doctor --strict
```

---

## 设计理念

NeoVim-Config 的目标是：

- 模块化（Modular）
- 可预测（Predictable）
- 可自诊断（Self-diagnosing）
- 自动化友好（Automation-friendly）

