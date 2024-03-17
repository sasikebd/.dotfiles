-- plugin : vim-airline/vim-airline

local M = {}

M.FLAG_INCLDUE = true

M.Setup = function()

  if M.FLAG_INCLUDE then

    -- Enable airline tabline extension
    vim.g.airline_extensions_tabline_enabled = 1 

    -- Set left separator for airline tabline extension
    vim.g.airline_extensions_tabline_left_sep = ' '

    -- Set alternate left separator for airline tabline extension
    vim.g.airline_extensions_tabline_left_alt_sep = '|'

    -- Set airline statusline on top
    vim.g.airline_statusline_ontop = 1

    -- buffer numbersing enable
    vim.g.airline_extensions_tabline_buffer_idx_mode = 1

  end
end

return M
