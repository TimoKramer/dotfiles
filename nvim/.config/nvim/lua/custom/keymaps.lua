vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit input mode' })
vim.keymap.set('n', '<Leader>ww', ':write<CR>', { desc = 'write file' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', 'jj', '<Esc>', { desc = 'Exit terminal mode' })

-- Conjure nrepl mappings (all under <localleader>r)
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
