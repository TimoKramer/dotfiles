-- my colorscheme
return {
  "ishan9299/modus-theme-vim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.modus_yellow_comments = 1
    vim.g.modus_green_strings = 1
    vim.cmd('colorscheme modus-operandi')
  end,
}
