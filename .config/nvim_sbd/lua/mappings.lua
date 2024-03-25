---------------------------------
-- @Author : sasike
-- @File   : /lua/mappings.lua
---------------------------------

local M = {}

function M.Setup()
  -- Set the leader key
  vim.g.mapleader = ' '

  -- Mapping to reload Neovim configuration
  --vim.api.nvim_set_keymap('n', '<leader>ld', ':lua ReloadNeoVim()<CR>', { noremap = true })

  -- NETRW Explorer --
  vim.keymap.set('n', '<leader>33', '<cmd>Explore<cr>', { noremap = true })

  -- Window movement mappings
  vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
  vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
  vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
  vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })

  -- Close this window
  vim.api.nvim_set_keymap('n', '<Leader>ww', ':close<CR>', { noremap = true, silent = true })

  -- Close other windows
  vim.api.nvim_set_keymap('n', '<Leader>jw', ':wincmd j<CR>:close<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>kw', ':wincmd k<CR>:close<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>hw', ':wincmd h<CR>:close<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>lw', ':wincmd l<CR>:close<CR>', { noremap = true, silent = true })

  --#region Plugin_Related_Mappings
  -- MRU
  vim.api.nvim_set_keymap('n', '<Leader>mr', ':MRU<CR>', { noremap = true })

  -- Telescope mappings
  vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true })

  -- Telescope's MRU like recent file view
  vim.api.nvim_set_keymap('n', '<leader>fr',
    ":lua require('telescope.builtin').oldfiles({ sorter = require('telescope.sorters').get_fzy_sorter() })<CR>",
    { noremap = true })

  -- NERDTree mappings
  --vim.api.nvim_set_keymap('n', '<F7>', '<cmd>NERDTreeToggle<cr>', {noremap = true})

  vim.api.nvim_set_keymap('n', '<leader>ne', '<cmd>NERDTreeToggle<cr>', { noremap = true })

  --#endregion Plugin_Related_Mappings

  --#region  Text_Editing_Mappings
  -- Replace all
  vim.api.nvim_set_keymap('n', '<leader>r', [[:%s/\<<C-r><C-w>\>//g<left><left>]], { noremap = true })

  -- Replace spaces with empty string
  vim.api.nvim_set_keymap('n', '<leader>tts', [[:%s/ //g<left><left>]], { noremap = true })
  vim.api.nvim_set_keymap('v', '<leader>tts', [[:s/ //g<left><left>]], { noremap = true })

  -- Replace tab with empty string
  vim.api.nvim_set_keymap('n', '<leader>tti', [[:%s/\t//g<left><left>]], { noremap = true })
  vim.api.nvim_set_keymap('v', '<leader>tti', [[:s/\t//g<left><left>]], { noremap = true })

  -- Replace tab with empty carriage return
  vim.api.nvim_set_keymap('n', '<leader>ttr', [[:%s/\t/\r/g<left><left>]], { noremap = true })
  vim.api.nvim_set_keymap('v', '<leader>ttr', [[:s/\t/\r/g<left><left>]], { noremap = true })

  -- Replace spaces with empty string
  vim.api.nvim_set_keymap('n', '<leader>tte', [[:%s/ //g<left><left>]], { noremap = true })
  vim.api.nvim_set_keymap('v', '<leader>tte', [[:s/ //g<left><left>]], { noremap = true })

  -- Insert new line after comma occurrence
  vim.api.nvim_set_keymap('n', '<leader>ttc', [[:%s/,/,\r/g<left><left>]], { noremap = true })
  vim.api.nvim_set_keymap('v', '<leader>ttc', [[:s/,/,\r/g<left><left>]], { noremap = true })

  -- Replace end of line with comma
  vim.api.nvim_set_keymap('n', '<leader>tt4', [[:%s/$/,/g<left><left>]], { noremap = true })
  vim.api.nvim_set_keymap('v', '<leader>tt4', [[:s/$/,/g<left><left>]], { noremap = true })

  -- Replace first char in line with "DD"
  vim.api.nvim_set_keymap('n', '<leader>tt6', [[:%s/^/DD/g<left><left>]], { noremap = true })
  vim.api.nvim_set_keymap('v', '<leader>tt6', [[:s/^/DD/g<left><left>]], { noremap = true })

  -- Replace first char in line with "SBDDEL"
  vim.api.nvim_set_keymap('n', '<leader>ttt', [[:s/$/\t#SBDDEL/g<left><left>]], { noremap = true })
  vim.api.nvim_set_keymap('v', '<leader>ttt', [[:s/$/\t#SBDDEL/g<left><left>]], { noremap = true })

  -- Replace left
  vim.api.nvim_set_keymap('n', '<leader>11', [[:%s/\v(.*)(<C-r><C-w>)(.*)/\1/<left><left>]], { noremap = true })

  -- Replace right
  vim.api.nvim_set_keymap('n', '<leader>22', [[:%s/\v(.*)(<C-r><C-w>)(.*)/\2/<left><left>]], { noremap = true })

  -- Keep middle
  vim.api.nvim_set_keymap('n', '<leader>33', [[:%s/\v(.*)(<C-r><C->)(.*)/\3/<left><left>]], { noremap = true })

  -- Keep 1,2
  vim.api.nvim_set_keymap('n', '<leader>12', [[:%s/\v(.*)(<C-r><C-w>)(.*)/\1\2/<left><left>]], { noremap = true })

  -- Keep 2,3
  vim.api.nvim_set_keymap('n', '<leader>23', [[:%s/\v(.*)(<C-r><C-w>)(.*)/\2\3/<left><left>]], { noremap = true })

  -- Delete lines matching pattern
  vim.api.nvim_set_keymap('n', '<leader>gd', [[:g/<C-r><C-w>/d]], { noremap = true })
  vim.api.nvim_set_keymap('v', '<leader>gd', [[:g/<C-r><C-w>/d]], { noremap = true })

  -- Delete lines not matching pattern
  vim.api.nvim_set_keymap('n', '<leader>vd', [[:v/<C-r><C-w>/d]], { noremap = true })
  vim.api.nvim_set_keymap('v', '<leader>vd', [[:v/<C-r><C-w>/d]], { noremap = true })

  -- Delete empty lines
  vim.api.nvim_set_keymap('n', '<leader>gel', [[:g/^$/d]], { noremap = true })
  vim.api.nvim_set_keymap('v', '<leader>gel', [[:g/^$/d]], { noremap = true })

  -- Concatenate lines between same line pattern
  vim.api.nvim_set_keymap('n', '<leader>tjk', [[:%v/^<C-r><C-w>/-1j!]], { noremap = true })
  vim.api.nvim_set_keymap('v', '<leader>tjk', [[:v/^<C-r><C-w>/-1j!]], { noremap = true })

  -- clip board copy paste
  vim.api.nvim_set_keymap('n', '<leader>y', '"+y"', { noremap = true ,silent = true})
  vim.api.nvim_set_keymap('v', '<leader>p', '"+p"', { noremap = true ,silent = true})

  -- Tabular related mappings
  vim.api.nvim_set_keymap('n', '<leader>ae', ":Tabularize /=<CR>", { noremap = true ,silent = true})
  vim.api.nvim_set_keymap('v', '<leader>ae', ":Tabularize /=<CR>", { noremap = true ,silent = true})

  vim.api.nvim_set_keymap('n', '<leader>a:', ":Tabularize /:<CR>", { noremap = true ,silent = true})
  vim.api.nvim_set_keymap('v', '<leader>a:', ":Tabularize /:<CR>", { noremap = true ,silent = true})

  vim.api.nvim_set_keymap('n', '<leader>al', ":Tabularize /,<CR>", { noremap = true ,silent = true})
  vim.api.nvim_set_keymap('v', '<leader>al', ":Tabularize /,<CR>", { noremap = true ,silent = true})

  vim.api.nvim_set_keymap('n', '<leader>as', ":Tabularize / ,<CR>", { noremap = true ,silent = true})
  vim.api.nvim_set_keymap('v', '<leader>as', ":Tabularize / ,<CR>", { noremap = true ,silent = true})

  vim.api.nvim_set_keymap('n', '<leader>add', ":Tabularize /-- ,<CR>", { noremap = true ,silent = true})
  vim.api.nvim_set_keymap('v', '<leader>add', ":Tabularize /-- ,<CR>", { noremap = true ,silent = true})

  vim.api.nvim_set_keymap('n', '<leader>ai', ":Tabularize /	<CR>", { noremap = ture, silent = ture })
  vim.api.nvim_set_keymap('n', '<leader>ai', ":Tabularize /	<CR>", { noremap = ture, silent = ture })

  --#endregion  Text_Editing_Mappings
 
end

return M
