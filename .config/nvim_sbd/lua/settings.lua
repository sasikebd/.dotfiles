 --  settings.lua

local M = {}

local o = vim.o
local wo = vim.wo
local cmd = vim.cmd
local opt = vim.opt
local opt_local = vim.opt_local

--  General Settings
function M.Setup()

  o.termguicolors = true    -- Enable termguicolors
  o.compatible = false      -- Unset Vim compatible mode

  --File related settings
  cmd("filetype off")       -- Disable file type detection to keep flags for plugins
  cmd("filetype on")        -- Enable file type detection vim.cmd("filetype plugin on") -- Enable file type plugin
  cmd("filetype indent on") -- Enable file type indent
  cmd("syntax on")          -- Enable syntax highlighting

  o.autochdir = true        -- Change directory to where the current file lies
  o.swapfile = false        -- Disable swap file for the current buffer
  o.autoread = true         -- Auto-detect changes to files outside of Vim
  o.autoindent = false      -- Enable/disable auto-indentation
  o.smartindent = false     -- Enable/disable smart indentation
  o.textwidth = 0           -- Set maximum text width that can be inserted
  o.wrapmargin = 0          -- Set wrap margin
  o.background = "dark"     -- Set background to dark
  o.mousehide = true        -- Hide mouse when typing
  o.errorbells = false      -- Disable error bell noise
  o.visualbell = false      -- Disable beep and flash
  o.ignorecase = true       -- Set ignore case
  o.number = true           -- Show line numbers
  o.relativenumber = true   -- Show relative line numbers
  o.ignorecase = false      -- Disable ignore case

  --  set tab stop spaces
  opt.tabstop = 2           -- No of spaces chars per tabstop 
  opt.shiftwidth = 2        -- Spaces for indentation level
  opt.softtabstop = 2       -- No of spaces that a One Tab char counts for
  opt.expandtab = true      -- Tab chars replaces with spaces

  opt.clipboard = "unnamedplus"

  -- use system clipboard
  opt.showmatch = true
  opt.ttyfast = true
  opt.hlsearch = true

  -- cursorline setup
  opt.cursorline = true

   --[[ window scoped settings ]]--
  --  Enable line numbers
  wo.number = true
  wo.rnu = true

  --wo.foldmethod = 'indent'  --  Set the folding method to 'indent'
  --wo.foldlevel = 2          --  Set the fold level to a specific value
  --wo.foldcolumn = '1'       --  Enable fold column

  opt_local.foldenable = false

  o.redrawtime = 1000	-- Set Redraw time

  -- set colorscheme
  if _G.PACKER_INITIAL_INSTALLATION then
    cmd("colorscheme desert")
  else
    cmd("colorscheme codedark")
  end

end

return M
