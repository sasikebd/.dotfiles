-- bootstrap program 
--
local Bootstrap = {}

-- Constructor --
--function Bootstrap:new(obj)
--  obj = obj or {}
-- setmetatable(obj, self)
--  self.__index = self
-- return obj
--end

Bootstrap.setPluginConfigs = function()

  LogMessage("Start")

  -- get the path to the plugin_config directory
  local pluginConfigPath = vim.fn.stdpath('config') .. '/lua/plugin_config/'

  -- get the list of files in the plugin_config directory
  local files = vim.fn.readdir(pluginConfigPath)

  -- iterate over the files
  for _, filename in ipairs(files) do

      -- check if the file has a .lua extension
      if string.match(filename, "%.lua$") then

          -- remove the extension from the filename
          local moduleName = string.gsub(filename, "%.lua$", "")

          -- load modules
          local plugConfig = require('plugin_config.' .. moduleName)

          plugConfig.Setup()

          LogMessageOther("loaded plugin configuration : " .. moduleName )
      end
  end
end

Bootstrap.Setup = function()

  -- load main modules
  local logger = require("logger")
  local plugins = require("plugins")
  local settings = require("settings")
  local mappings = require("mappings")
  local errorHandling = require("error_handler")

  -- setup plugins
  local success, err = pcall(plugins.Setup)
    if not success then
    errorHandling.handle_error(err)
  end

  -- set configurations for each plugin
  if not _G.PACKER_INITIAL_INSTALLATION then

    -- set each plugin configs
    Bootstrap:setPluginConfigs()

     -- setup settings/options
    success, err = pcall(settings.Setup)
    if not success then
      errorHandling.handle_error(err)
    end

    -- setup mappings
    success, err = pcall(mappings.Setup)
    if not success then
      errorHandling.handle_error(err)
    end

  end
end

return Bootstrap

