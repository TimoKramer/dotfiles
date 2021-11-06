require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  },
  ensure_installed = {
      "clojure",
      "lua",
      "python",
      "bash",
      "json",
  },
  incremental_selection = {
    enable  = true,
    keymaps = {
      init_selection    = "gnn",
      node_incremental  = "grn",
      scope_incremental = "grc",
      node_decremental  = "grm",
    },
  },
  rainbow = {
    enable        = true,
    extended_mode = true,
  },
}
