local M = {}

function M.cpu_arch()
  local u = vim.loop.os_uname()
  return u and u.machine or "unknown-arch"
end

function M.kernel_version()
  local u = vim.loop.os_uname()
  return u and ("linux-" .. u.release) or "unknown-kernel"
end

function M.linux_distro()
  if vim.fn.filereadable("/etc/openbmc-release") == 1 then
    return "OpenBMC"
  end

  local file = io.open("/etc/os-release", "r")
  if not file then
    return vim.loop.os_uname().sysname
  end

  local info = {}
  for line in file:lines() do
    local k, v = line:match('^(.+)=(.+)$')
    if k and v then
      info[k] = v:gsub('"', "")
    end
  end
  file:close()

  if info.ID and info.VERSION_ID then
    return info.ID .. "-" .. info.VERSION_ID
  end

  return info.ID or vim.loop.os_uname().sysname
end

function M.runtime_role()
  if os.getenv("SSH_CONNECTION") then
    return "🔐 SSH SESSION"
  end
  if vim.fn.filereadable("/etc/openbmc-release") == 1 then
    return "⚡  OPENBMC"
  end
  if vim.fn.filereadable("/.dockerenv") == 1 then
    return "🐳 DOCKER ENV"
  end
  if vim.fn.has("wsl") == 1 then
    return "🐧  WSL"
  end
  return "💻  LOCAL HOST"
end

function M.system_info()
  local info = {
    M.runtime_role(),
    M.linux_distro(),
    M.kernel_version(),
    M.cpu_arch(),
  }

  local app = os.getenv("NVIM_APPNAME")
  if app then
    table.insert(info, "App:" .. app)
  end

  return table.concat(info, " | ")
end

return M
