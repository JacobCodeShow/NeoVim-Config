local M = {}

function M.username()
  return os.getenv("USER") or "user"
end

function M.cpu_arch()
  local u = vim.loop.os_uname()
  return (u and u.machine) or "unknown-arch"
end

function M.kernel_version()
  local u = vim.loop.os_uname()
  return (u and u.release) and ("linux-" .. u.release) or "unknown-kernel"
end

return M
