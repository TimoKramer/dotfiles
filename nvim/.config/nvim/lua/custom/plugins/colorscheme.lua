return {
  'miikanissi/modus-themes.nvim',
  priority = 1000,
  dim_inactive = 'non-current',
  styles = {
    comments = { sp = 'green' },
  },
  config = function()
    vim.cmd [[colorscheme modus_operandi]]
    vim.cmd [[set cursorcolumn]]
    vim.cmd [[highlight CursorColumn guibg=#d0d6ec]]
  end,
}

-- return {
--   'projekt0n/github-nvim-theme',
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     require('github-theme').setup({
--       specs = {
--         all = {
--           syntax = {
--             keyword = 'orange',
--     }}}
--     })
--
--     vim.cmd('colorscheme github_light')
--   end,
-- }
