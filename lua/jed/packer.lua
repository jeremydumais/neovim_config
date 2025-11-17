-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
    use {
        'Civitasv/cmake-tools.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
    }

	use 'folke/tokyonight.nvim'
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})

	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			-- Snippet Collection (Optional)
			{'rafamadriz/friendly-snippets'},
		}
	}

    --Show method overloads
    use {
      "ray-x/lsp_signature.nvim",
    }

    use {
        "windwp/nvim-ts-autotag"
    }

	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}

--	use 'vim-airline/vim-airline'
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use 'derekwyatt/vim-fswitch'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
    use 'mortepau/codicons.nvim'
    use 'simrat39/rust-tools.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'folke/todo-comments.nvim'
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio"
    } }
    use  'theHamsta/nvim-dap-virtual-text'
    use 'mfussenegger/nvim-lint'
    use 'leoluz/nvim-dap-go'
    use 'preservim/nerdcommenter'
    use 'tomasiser/vim-code-dark'
    use 'marko-cerovac/material.nvim'
    -- Packer
    use({
      "jackMort/ChatGPT.nvim",
        config = function()
          require("chatgpt").setup()
        end,
        requires = {
          "MunifTanjim/nui.nvim",
          "nvim-lua/plenary.nvim",
          "folke/trouble.nvim",
          "nvim-telescope/telescope.nvim"
        }
    })
    use 'Asheq/close-buffers.vim'

    use('jose-elias-alvarez/null-ls.nvim')
    use('MunifTanjim/prettier.nvim')
    use {
        "AckslD/nvim-neoclip.lua",
        requires = {
            -- you'll need at least one of these
            -- {'nvim-telescope/telescope.nvim'},
            -- {'ibhagwan/fzf-lua'},
        },
        config = function()
            require('neoclip').setup()
        end,
    }
    use('roxma/vim-tmux-clipboard')
    use('tmux-plugins/vim-tmux-focus-events')
    use {
        "gbprod/yanky.nvim",
        requires = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("yanky").setup()
            require("telescope").load_extension("yank_history")
        end
    }

end)
