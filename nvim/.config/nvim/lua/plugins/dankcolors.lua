return {
  {
    'RRethy/base16-nvim',
    priority = 1000,
    config = function()
      require('base16-colorscheme').setup {
        base00 = '#ffffff',
        base01 = '#ffffff',
        base02 = '#2e2e2e',
        base03 = '#2e2e2e',
        base04 = '#1a1a1a',
        base05 = '#1a1a1a',
        base06 = '#1a1a1a',
        base07 = '#1a1a1a',
        base08 = '#a52420',
        base09 = '#a52420',
        base0A = '#2d46f8',
        base0B = '#138c15',
        base0C = '#9559ff',
        base0D = '#2d46f8',
        base0E = '#3f78ff',
        base0F = '#3f78ff',
      }

      vim.api.nvim_set_hl(0, 'Visual', {
        bg = '#2e2e2e',
        fg = '#1a1a1a',
        bold = true,
      })
      vim.api.nvim_set_hl(0, 'Statusline', {
        bg = '#2d46f8',
        fg = '#ffffff',
      })
      vim.api.nvim_set_hl(0, 'LineNr', { fg = '#2e2e2e' })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#9559ff', bold = true })

      vim.api.nvim_set_hl(0, 'Statement', {
        fg = '#3f78ff',
        bold = true,
      })
      vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
      vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
      vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

      vim.api.nvim_set_hl(0, 'Function', {
        fg = '#2d46f8',
        bold = true,
      })
      vim.api.nvim_set_hl(0, 'Macro', {
        fg = '#2d46f8',
        italic = true,
      })
      vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

      vim.api.nvim_set_hl(0, 'Type', {
        fg = '#9559ff',
        bold = true,
        italic = true,
      })
      vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

      vim.api.nvim_set_hl(0, 'String', {
        fg = '#138c15',
        italic = true,
      })

      vim.api.nvim_set_hl(0, 'Operator', { fg = '#1a1a1a' })
      vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#1a1a1a' })
      vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
      vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

      vim.api.nvim_set_hl(0, 'Comment', {
        fg = '#2e2e2e',
        italic = true,
      })

      local current_file_path = vim.fn.stdpath 'config' .. '/lua/plugins/dankcolors.lua'
      if not _G._matugen_theme_watcher then
        local uv = vim.uv or vim.loop
        _G._matugen_theme_watcher = uv.new_fs_event()
        _G._matugen_theme_watcher:start(
          current_file_path,
          {},
          vim.schedule_wrap(function()
            local new_spec = dofile(current_file_path)
            if new_spec and new_spec[1] and new_spec[1].config then
              new_spec[1].config()
              print 'Theme reload'
            end
          end)
        )
      end
    end,
  },
}
