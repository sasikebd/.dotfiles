---------------------------------
-- @Author : sasike
-- @File   : /lua/logger.lua
---------------------------------

-- Debug function to print debug messages
-- TODO: add log to file
function LogMessage(message)
  local timeStamp = os.date("%Y-%m-%d %H:%M:%S")
  local info = debug.getinfo(2, "Sln")
  local currentFile = info.source:sub(2)
  local lineNumber = info.currentline
  local functionName = info.name or "N/A"

  local debugMessage =
      string.format("DEBUG [%s], %s, %d, %s(), %s", timeStamp, currentFile, lineNumber, functionName, message)

  if _G.LOG_ENABLED then
    print(debugMessage)
  end
end

-- function to print other debug messages
-- TODO: add log to file
function LogMessageOther(message)
  local timeStamp = os.date("%Y-%m-%d %H:%M:%S")
  local info = debug.getinfo(2, "Sl")
  local currentFile = info.source:sub(2)
  local lineNumber = info.currentline

  local debugMessage = string.format("DEBUG [%s], %s, %d, %s", timeStamp, currentFile, lineNumber, message)
  if _G.LOG_ENABLED then
    print(debugMessage)
  end
end

-- this function is temporally defined here
-- TODO : move to util.lua
function PrintLoadTime()
  local timeStamp = os.date("%Y-%m-%d %H:%M:%S")
  local info = debug.getinfo(2, "Sln")
  local currentFile = info.source:sub(2)
  local lineNumber = info.currentline
  local functionName = info.name or "N/A"
  local loadTime = vim.fn.reltimefloat(vim.fn.reltime())

  local debugMessage = string.format(
    "DEBUG [%s], %s, %d, %s(), Load Time : %f",
    timeStamp,
    currentFile,
    lineNumber,
    functionName,
    loadTime
  )

  if _G.LOG_ENABLED then
    print(debugMessage)
  end
end
