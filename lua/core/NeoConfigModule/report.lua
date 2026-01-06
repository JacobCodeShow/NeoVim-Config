-- ~/.config/nvim/lua/core/NeoConfigModule/report.lua

local M = {
  pass_count = 0,
  fail_count = 0,
}

function M.start()
  M.pass_count = 0
  M.fail_count = 0
  print("NeoConfig Doctor\n")
end

function M.section(title)
  print("\n[" .. title .. "]")
end

function M.pass(msg)
  M.pass_count = M.pass_count + 1
  print("✔ " .. msg)
end

function M.fail(msg, hint)
  M.fail_count = M.fail_count + 1
  print("✘ " .. msg)
  if hint then
    print("  → " .. hint)
  end
end

function M.finish()
  print("\nSummary:")
  print("  Passed: " .. M.pass_count)
  print("  Failed: " .. M.fail_count)
end

return M
