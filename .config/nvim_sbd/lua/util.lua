-- util.lua

local M = {}

function M.Display_startup_time()
  local endTime = vim.loop.hrtime()
  local elapsedTime =( endTime - _G.StartTime ) / 1e6
  local timetaken = string.format("Startup time duration : %.2f ms", elapsedTime)

  if not _G.PACKER_INITIAL_INSTALLATION then
    vim.notify(timetaken)
  end
end

return M
