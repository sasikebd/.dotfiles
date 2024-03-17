--plugin : vim-scripts/ 
local M = {}

M.FLAG_INCLUDE = true 

M.Setup = function()

  if M.FLAG_INCLUDE then 

    -- Open MRU window at startup
    --vim.cmd('autocmd VimEnter * MRU')
    
    -- Set the maximum number of MRU files to display
    --vim.g.mru_max_files = 10 

    LogMessageOther("Loading : Done")
  end
end

return M
