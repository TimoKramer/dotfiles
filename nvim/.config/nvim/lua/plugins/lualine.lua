require("lualine").setup {
  options = {
    theme = 'auto',
  },
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true,
        newfile_status = true,
        path = 4,
        shorting_target = 40,
        symbols = {
          modified = '[+]',
          readonly = '[-]',
          unnamed = '[No Name]',
          newfile = '[New]',
        }
      }
    }
  },
}
