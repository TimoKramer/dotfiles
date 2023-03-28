vim.opt.listchars = {
  eol = '¬',
  tab = '>·',
  trail = '~',
  extends = '>',
  precedes = '<',
  space = '␣'
}
vim.opt.wildcharm = ('\t'):byte()

vim.wo.cursorcolumn = true
vim.wo.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLine', { underline = false, ctermbg = 254 })
vim.api.nvim_set_hl(0, 'CursorColumn', { ctermbg = 254 })

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "conjure-log-*",
    callback = function()
        vim.diagnostic.disable(0)
    end,
})

vim.opt.relativenumber = true
vim.opt.number = true
