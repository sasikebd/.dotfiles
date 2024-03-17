-- plugins.lua

local M = {}

M.PACKER_BOOTSTRAP = false

-- Define a Lua function to reload Neovim
_G.ReloadNeovim = function()
    vim.cmd("luafile $MYVIMRC")

    if _G.PACKER_INITIAL_INSTALLATION then
      vim.notify("nvim reloaded : first time")
    else
      vim.notify("nvim reloaded after packer sync")
    end
end

-- function :  check packer has installed or not
M.ensurePacker = function()

  local fn = vim.fn
  local installPath = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  if fn.empty(fn.glob(installPath)) > 0 then
  	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", installPath })
  	vim.cmd([[packadd packer.nvim]])
  	LogMessageOther("packer installed for the first time")
  	return true
  end

  LogMessageOther("Packer is already installed ")
  
  return false
end

-- function : setup packer
function M.Setup()

  M.PACKER_BOOTSTRAP = M.ensurePacker()
  _G.PACKER_INITIAL_INSTALLATION = M.PACKER_BOOTSTRAP

  require("packer").startup({function(use)
    use("wbthomason/packer.nvim")

    -- gui traversal related 
    use("simeji/winresizer")
    use("tmhedberg/SimpylFold")
    use("lukas-reineke/indent-blankline.nvim", { main = "ibl", opt ={},})

    --file traversal 
    use("scrooloose/nerdtree")
    use("vim-scripts/mru.vim")
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.6',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- editing/formatting related --
    use("scrooloose/nerdcommenter")
    use("godlygeek/tabular")
    use("chrisbra/csv.vim")
    use("tpope/vim-repeat")
    use("jiangmiao/auto-pairs")
    --use("tpope/vim-sleuth") -- detects tabstop & shiftwidth automaticallay

    -- git related plugins--
    use("tpope/vim-fugitive")
    use("lewis6991/gitsigns.nvim")
    use("airblade/vim-gitgutter")

    -- treesitter
    use("nvim-treesitter/nvim-treesitter", {
      build = ":TSUpdate",
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
    })

    -- lsp config & related plugins
    use({
            "neovim/nvim-lspconfig",
            requires = {
                    "williamboman/mason.nvim",
                    "williamboman/mason-lspconfig.nvim",
                    -- Additional lua configuration, makes nvim stuff amazing!]]
                    -- Neovim setup for init.lua and plugin development with full signature help,]]
                    -- docs and completion for the nvim lua API.]]
                    "folke/neodev.nvim",
                   --[[ {]]
                            --[["j-hui/fidget.nvim",]]
                            --[[tag = "legacy",]]
                            --[[opts = {},]]
                    --[[},]]
            },
    })

    --  Autocompletion & related plugins
    --use 'hrsh7th/cmp-vsnip'
    --use 'hrsh7th/cmp-nvim-lua'
    use({
            "hrsh7th/nvim-cmp", --LS data source for nvim-cmp
            requires = {
                    "hrsh7th/cmp-nvim-lsp", -- LSP coompletion capabilities
                    "hrsh7th/cmp-path", -- give completion based on file system
                    "hrsh7th/cmp-buffer", -- give suggestions based on current file
                    {
                            "L3MON4D3/LuaSnip",
                            -- install jsregexp
                            run = "make install_jsregexp",
                    },
                    "saadparwaiz1/cmp_luasnip",
            },
    })

    -- terminal
    use('christoomey/vim-tmux-navigator') -- awesome plugin to navigate tmux windows
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
      require("toggleterm").setup()
    end} -- TODO : Configure

    -- appearance
    use("vim-airline/vim-airline")        -- TODO : migrate to lualine
    use("vim-airline/vim-airline-themes")
    use("vim-scripts/RltvNmbr.vim")
    --use 'scrooloose/syntastic'

    -- colorschemes
    use("norcalli/nvim-colorizer.lua")
    use("tomasr/molokai")
    use("tomasiser/vim-code-dark") -- visual studio like colorsheme
    use("morhetz/gruvbox")
    use("joshdick/onedark.vim")
    use("folke/tokyonight.nvim")
    use("rebelot/kanagawa.nvim")
    use("tjdevries/colorbuddy.nvim")

    -- nvim-notify shoul load only after colorsheme has been fully loaded
    use("rcarriga/nvim-notify")

    if M.PACKER_BOOTSTRAP then
      M.Packer = require('packer')
      M.Packer.sync()
      vim.notify("packer sync is called") 

      -- Define an autocmd that listens for PackerComplete event
      vim.cmd[[
      augroup packer_completion
        autocmd!
        autocmd User PackerComplete lua ReloadNeovim() print("Packer installation complete")
      augroup END
      ]]
    else
      vim.notify = require("notify")
    end
  end,

  -- configure pakcer to use floating window 
  config = { display = { open_fn = require('packer.util').float, } } })
end

return M
