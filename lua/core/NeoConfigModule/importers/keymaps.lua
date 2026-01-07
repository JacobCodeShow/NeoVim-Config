-- ~/.config/nvim/lua/core/NeoConfigModule/importers/keymaps.lua

local M = {}

local function collect_keymaps()
  local result = {}

  for _, map in ipairs(vim.api.nvim_get_keymap("")) do
    table.insert(result, map)
  end

  for _, map in ipairs(vim.api.nvim_get_keymap("n")) do
    map.mode = "n"
    table.insert(result, map)
  end

  for _, map in ipairs(vim.api.nvim_get_keymap("i")) do
    map.mode = "i"
    table.insert(result, map)
  end

  for _, map in ipairs(vim.api.nvim_get_keymap("v")) do
    map.mode = "v"
    table.insert(result, map)
  end

  return result
end

local function format_markdown(maps)
  local lines = {
    "# NeoVim Keymaps",
    "",
    "| Mode | LHS | RHS | Description |",
    "|------|-----|-----|-------------|",
  }

  for _, m in ipairs(maps) do
    table.insert(lines, string.format(
      "| %s | `%s` | `%s` | %s |",
      m.mode or "",
      m.lhs or "",
      m.rhs or "",
      m.desc or ""
    ))
  end

  return table.concat(lines, "\n")
end

function M.run(opts)
  local maps = collect_keymaps()
  local output = format_markdown(maps)

  local path = opts.output
    or (vim.fn.stdpath("config") .. "/KEYMAPS.md")

  vim.fn.writefile(vim.split(output, "\n"), path)

  vim.notify(
    "NeoConfig import keymaps → " .. path,
    vim.log.levels.INFO
  )
end

return M
