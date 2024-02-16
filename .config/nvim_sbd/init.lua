---------------------------------
-- @Author : sasike
-- @File   : init.lua
---------------------------------

-- Global Variables
_G.StartTime = vim.loop.hrtime()
_G.LOG_ENABLED = false                 -- Set this flag to enable or disable debug messages
_G.PACKER_INITIAL_INSTALLATION = false -- Set this flag if packer install for the fist time
_G.PACKER_COMPLETED = false            -- set this flag after packer install/sync completed

-- Initialize the bootstrap
--local bootstrap = require("bootstrap"):new()
local bootstrap = require("bootstrap")


local success, err = pcall(bootstrap.Setup)
if not success then
  vim.api.nvim_err_writeln("Error in calling bootstrap : " .. err)
end

-- Display startup time using util.lua
local util = require("util")
 vim.schedule(util.Display_startup_time)
