-- plugin : scrooloose/nerdtree 
-- Automatically change directory to two directories above the current file in NERDTree

local M = {}

M.FLAG_INCLUDE = true

M.Setup = function()

  if M.FLAG_INCLUDE then
    vim.g.NERDTreeChDirMode = 2

    -- Show hidden files in NERDTree
    vim.g.NERDTreeShowHidden = 1

    -- autoclose NERDtree if the NERDtree windows is the last open buffer
    -- TODO

    LogMessageOther("Loading : Done")
  end

end

return M 
