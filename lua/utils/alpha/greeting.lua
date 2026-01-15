local M = {}

function M.greeting()
  -- OpenBMC 特殊模式
  if vim.fn.filereadable("/etc/openbmc-release") == 1 then
    return " 🛠  Firmware Engineering Mode "
  end

  local h = tonumber(os.date("%H"))

  if h < 6 then
    return " 🌙  Good Night "
  elseif h < 12 then
    return " ☀️  Good Morning "
  elseif h < 18 then
    return " 🌤  Good Afternoon "
  else
    return " 🌙  Good Night "
  end
end

return M
