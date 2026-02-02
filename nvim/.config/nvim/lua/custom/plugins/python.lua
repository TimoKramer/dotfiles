-- Python Development Setup
-- Adds debugging, virtual env management, and optional test runner.
-- LSP (basedpyright + ruff) is configured in init.lua.

return {
  -- Python Debug Adapter
  -- Requires: pip install debugpy (in your venv or globally)
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      local path = vim.fn.exepath 'python3' or vim.fn.exepath 'python'
      require('dap-python').setup(path)
      require('dap-python').test_runner = 'pytest'
    end,
    keys = {
      {
        '<leader>dpt',
        function()
          require('dap-python').test_method()
        end,
        desc = 'Debug: [P]ython [T]est method',
      },
      {
        '<leader>dpc',
        function()
          require('dap-python').test_class()
        end,
        desc = 'Debug: [P]ython [T]est class',
      },
      {
        '<leader>dps',
        function()
          require('dap-python').debug_selection()
        end,
        mode = 'v',
        desc = 'Debug: [P]ython [S]election',
      },
    },
  },

  -- Virtual Environment Selector
  {
    'linux-cultist/venv-selector.nvim',
    branch = 'regexp',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
      'mfussenegger/nvim-dap-python',
    },
    ft = 'python',
    opts = {
      auto_refresh = false,
      search = true,
      search_venv_managers = true,
      name = { 'venv', '.venv', 'env', '.env' },
      notify_user_on_venv_activation = true,
    },
    keys = {
      { '<leader>cv', '<cmd>VenvSelect<cr>', desc = '[C]hange [V]env' },
      { '<leader>cV', '<cmd>VenvSelectCached<cr>', desc = '[C]hange [V]env (cached)' },
    },
  },

  -- Neotest for running Python tests (optional - uncomment to enable)
  -- {
  --   'nvim-neotest/neotest',
  --   dependencies = {
  --     'nvim-neotest/nvim-nio',
  --     'nvim-lua/plenary.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --     'nvim-neotest/neotest-python',
  --   },
  --   ft = 'python',
  --   config = function()
  --     require('neotest').setup {
  --       adapters = {
  --         require 'neotest-python' {
  --           dap = { justMyCode = false },
  --           runner = 'pytest',
  --           python = function()
  --             local venv = os.getenv 'VIRTUAL_ENV'
  --             if venv then
  --               return venv .. '/bin/python'
  --             end
  --             return 'python3'
  --           end,
  --         },
  --       },
  --     }
  --   end,
  --   keys = {
  --     { '<leader>tt', function() require('neotest').run.run() end, desc = '[T]est nearest' },
  --     { '<leader>tf', function() require('neotest').run.run(vim.fn.expand '%') end, desc = '[T]est [F]ile' },
  --     { '<leader>ts', function() require('neotest').summary.toggle() end, desc = '[T]est [S]ummary' },
  --     { '<leader>to', function() require('neotest').output.open { enter = true } end, desc = '[T]est [O]utput' },
  --   },
  -- },
}
