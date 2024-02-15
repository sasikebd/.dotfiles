 --  settings.lua

local M = {}

--  General Settings
function M.Setup()

  vim.o.termguicolors = true    -- Enable termguicolors
  vim.o.compatible = false      -- Unset Vim compatible mode
   

  --  File related settings
  vim.cmd("filetype off")       -- Disable file type detection to keep flags for plugins
  vim.cmd("filetype on")        -- Enable file type detection vim.cmd("filetype plugin on") -- Enable file type plugin
  vim.cmd("filetype indent on") -- Enable file type indent
  vim.cmd("syntax on")          -- Enable syntax highlighting

  vim.o.autochdir = true        -- Change directory to where the current file lies
  vim.o.swapfile = false        -- Disable swap file for the current buffer
  vim.o.autoread = true         -- Auto-detect changes to files outside of Vim
  vim.o.autoindent = false      -- Enable/disable auto-indentation
  vim.o.smartindent = false     -- Enable/disable smart indentation
  vim.o.textwidth = 0           -- Set maximum text width that can be inserted
  vim.o.wrapmargin = 0          -- Set wrap margin
  vim.o.background = "dark"     -- Set background to dark
  vim.o.mousehide = true        -- Hide mouse when typing
  vim.o.errorbells = false      -- Disable error bell noise
  vim.o.visualbell = true       -- Disable beep and flash
  vim.o.ignorecase = true       -- Set ignore case
  vim.o.number = true           -- Show line numbers
  vim.o.relativenumber = true   -- Show relative line numbers
  vim.o.ignorecase = false      -- Disable ignore case

  --  set tab stop spaces
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2
  vim.opt.expandtab = true      -- tab chars replaces with spaces
  vim.opt.clipboard = "unnamedplus"

  -- use system clipboard
  vim.opt.showmatch = true
  vim.opt.ttyfast = true
  vim.opt.hlsearch = true
  
  --  Enable line numbers
  vim.wo.number = true
  vim.wo.rnu = true

  if _G.PACKER_INIT_FIRST_TIME then
    vim.cmd("colorscheme desert")
  else
    vim.cmd("colorscheme codedark")
  end

  --vim.wo.foldmethod = 'indent'  --  Set the folding method to 'indent'
  --vim.wo.foldlevel = 2          --  Set the fold level to a specific value
  --vim.wo.foldcolumn = '1'       --  Enable fold column

  vim.opt_local.foldenable = false

  vim.o.redrawtime = 1000	-- Set Redraw time

end

return M
