return {
  {
    'RRethy/base16-nvim',
    priority = 1000,
    config = function()
      require('base16-colorscheme').setup {
        base00 = '#ffffff',
        base01 = '#ffffff',
        base02 = '#a9aaaf',
        base03 = '#a9aaaf',
        base04 = '#363639',
        base05 = '#f7f8ff',
        base06 = '#f7f8ff',
        base07 = '#f7f8ff',
        base08 = '#f83f6e',
        base09 = '#f83f6e',
        base0A = '#2b43ee',
        base0B = '#29e348',
        base0C = '#a0abff',
        base0D = '#2b43ee',
        base0E = '#c2c9ff',
        base0F = '#c2c9ff',
      }

      vim.api.nvim_set_hl(0, 'Visual', {
        bg = '#a9aaaf',
        fg = '#f7f8ff',
        bold = true,
      })
      vim.api.nvim_set_hl(0, 'Statusline', {
        bg = '#2b43ee',
        fg = '#ffffff',
      })
      vim.api.nvim_set_hl(0, 'LineNr', { fg = '#a9aaaf' })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#a0abff', bold = true })

      vim.api.nvim_set_hl(0, 'Statement', {
        fg = '#c2c9ff',
        bold = true,
      })
      vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
      vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
      vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

      vim.api.nvim_set_hl(0, 'Function', {
        fg = '#2b43ee',
        bold = true,
      })
      vim.api.nvim_set_hl(0, 'Macro', {
        fg = '#2b43ee',
        italic = true,
      })
      vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

      vim.api.nvim_set_hl(0, 'Type', {
        fg = '#a0abff',
        bold = true,
        italic = true,
      })
      vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

      vim.api.nvim_set_hl(0, 'String', {
        fg = '#29e348',
        italic = true,
      })

      vim.api.nvim_set_hl(0, 'Operator', { fg = '#363639' })
      vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#363639' })
      vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
      vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

      vim.api.nvim_set_hl(0, 'Comment', {
        fg = '#a9aaaf',
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
