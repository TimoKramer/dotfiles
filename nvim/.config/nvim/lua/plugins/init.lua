local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)

  use {
    'ishan9299/modus-theme-vim',
    config = function()
        require('plugins.colorscheme')
    end,
  }

  use 'ntpeters/vim-better-whitespace'

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
    },
    config = function()
        require('plugins.cmp')
    end,
  }

  use {
    'neovim/nvim-lspconfig',
    event = buf_enter,
    config = function()
        require('plugins.lspconfig')
    end,
  }

  use {
    'folke/which-key.nvim',
    branch = 'main',
    event = 'VimEnter',
    config = function()
      require('which-key').setup({})
    end,
  }

  use 'p00f/nvim-ts-rainbow'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end,
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('plugins.gitsigns')
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope',
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = {
            prompt_position = "top",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            file_ignore_patterns = {
              ".git/",
              ".node_modules/",
              ".mypy_cache/",
              "__pycache__/",
            },
          },
        },
      })
    end,
  }

  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
        require("plugins.lualine")
    end,
  }

  use {
    'Olical/conjure',
    ft = {'clojure'}
  }

  use {
    'eraserhd/parinfer-rust',
    ft = {'clojure'},
    run = 'cargo build --release && cargo install'
  }

  use 'tpope/vim-eunuch'
  use 'tpope/vim-vinegar'

  use {
    "ur4ltz/surround.nvim",
    config = function()
      require"surround".setup {mappings_style = "surround"}
    end
  }

  use 'tpope/vim-dispatch'
  use 'clojure-vim/vim-jack-in'
  use 'radenling/vim-dispatch-neovim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
