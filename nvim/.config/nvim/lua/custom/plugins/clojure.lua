return {
  {
    'olical/conjure',
    ft = { 'clojure' },
    config = function()
      require('conjure.main').main()
      require('conjure.mapping')['on-filetype']()
      vim.api.nvim_create_autocmd('BufNewFile', {
        pattern = 'conjure-log-*',
        callback = function()
          vim.diagnostic.disable(0)
        end,
        desc = 'This disables LSP-evaluation of conjure.log-files',
      })
    end,
    init = function()
      vim.g['conjure#log#hud#ignore_low_priority'] = false

      -- Disable Conjure's default mappings so we manage them explicitly
      vim.g['conjure#mapping#enable_defaults'] = false

      -- Mapping prefix (all mappings below are prefixed with this)
      vim.g['conjure#mapping#prefix'] = '<localleader>'

      -- Log
      vim.g['conjure#mapping#log_split'] = 'ls'
      vim.g['conjure#mapping#log_vsplit'] = 'lv'
      vim.g['conjure#mapping#log_tab'] = 'lt'
      vim.g['conjure#mapping#log_buf'] = 'le'
      vim.g['conjure#mapping#log_toggle'] = 'lg'
      vim.g['conjure#mapping#log_close_visible'] = 'lq'
      vim.g['conjure#mapping#log_reset_soft'] = 'lr'
      vim.g['conjure#mapping#log_reset_hard'] = 'lR'
      vim.g['conjure#mapping#log_jump_to_latest'] = 'll'

      -- Eval
      vim.g['conjure#mapping#eval_motion'] = 'E'
      vim.g['conjure#mapping#eval_current_form'] = 'ee'
      vim.g['conjure#mapping#eval_comment_current_form'] = 'ece'
      vim.g['conjure#mapping#eval_root_form'] = 'er'
      vim.g['conjure#mapping#eval_comment_root_form'] = 'ecr'
      vim.g['conjure#mapping#eval_word'] = 'ew'
      vim.g['conjure#mapping#eval_comment_word'] = 'ecw'
      vim.g['conjure#mapping#eval_replace_form'] = 'e!'
      vim.g['conjure#mapping#eval_marked_form'] = 'em'
      vim.g['conjure#mapping#eval_file'] = 'ef'
      vim.g['conjure#mapping#eval_buf'] = 'eb'
      vim.g['conjure#mapping#eval_visual'] = 'E'
      vim.g['conjure#mapping#eval_previous'] = 'ep'

      -- Navigation
      vim.g['conjure#mapping#def_word'] = 'gd'
      vim.g['conjure#mapping#doc_word'] = { 'K' } -- no prefix, maps directly to K

      -- nREPL (all under <localleader>r)
      vim.g['conjure#client#clojure#nrepl#mapping#disconnect'] = 'rd'
      vim.g['conjure#client#clojure#nrepl#mapping#connect_port_file'] = 'rf'
      vim.g['conjure#client#clojure#nrepl#mapping#interrupt'] = 'ri'
      vim.g['conjure#client#clojure#nrepl#mapping#last_exception'] = 'rve'
      vim.g['conjure#client#clojure#nrepl#mapping#result_1'] = 'rv1'
      vim.g['conjure#client#clojure#nrepl#mapping#result_2'] = 'rv2'
      vim.g['conjure#client#clojure#nrepl#mapping#result_3'] = 'rv3'
      vim.g['conjure#client#clojure#nrepl#mapping#view_tap'] = 'rvt'
      vim.g['conjure#client#clojure#nrepl#mapping#view_source'] = 'rvs'
      vim.g['conjure#client#clojure#nrepl#mapping#session_clone'] = 'rsc'
      vim.g['conjure#client#clojure#nrepl#mapping#session_fresh'] = 'rsf'
      vim.g['conjure#client#clojure#nrepl#mapping#session_close'] = 'rsq'
      vim.g['conjure#client#clojure#nrepl#mapping#session_close_all'] = 'rsQ'
      vim.g['conjure#client#clojure#nrepl#mapping#session_list'] = 'rsl'
      vim.g['conjure#client#clojure#nrepl#mapping#session_next'] = 'rsn'
      vim.g['conjure#client#clojure#nrepl#mapping#session_prev'] = 'rsp'
      vim.g['conjure#client#clojure#nrepl#mapping#session_select'] = 'rss'
      vim.g['conjure#client#clojure#nrepl#mapping#run_all_tests'] = 'rta'
      vim.g['conjure#client#clojure#nrepl#mapping#run_current_ns_tests'] = 'rtn'
      vim.g['conjure#client#clojure#nrepl#mapping#run_alternate_ns_tests'] = 'rtN'
      vim.g['conjure#client#clojure#nrepl#mapping#run_current_test'] = 'rtc'
      vim.g['conjure#client#clojure#nrepl#mapping#refresh_changed'] = 'rrr'
      vim.g['conjure#client#clojure#nrepl#mapping#refresh_all'] = 'rra'
      vim.g['conjure#client#clojure#nrepl#mapping#refresh_clear'] = 'rrc'
    end,
  },
  {
    'gpanders/nvim-parinfer',
    ft = { 'clojure' },
    config = function()
      vim.g.parinfer_force_balance = true
    end,
  },
}
