-- error_handling.lua

local M = {}

function M.show_error_popup(message)
  -- Function to show the error message in the command-line
  vim.api.nvim_echo({ { "Error in configuration: " .. message, "ErrorMsg" } }, true, {})
end

function M.handle_error(err)
  M.show_error_popup(err)
  -- TODO
  -- Optionally, you can log the error to a file or take other actions here
end

return M
