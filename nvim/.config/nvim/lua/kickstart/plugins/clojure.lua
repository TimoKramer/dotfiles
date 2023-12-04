return {
  {
    "olical/conjure",
    ft = { "python", "clojure" },
    dependencies = {
      {
        "PaterJason/cmp-conjure",
        config = function()
            local cmp = require("cmp")
            local config = cmp.get_config()
            table.insert(config.sources, {
                name = "buffer",
                option = {
                    sources = {
                        { name = "conjure" },
                    },
                },
            })
            cmp.setup(config)
        end,
      },
    },
    config = function()
      require("conjure.main").main()
      require("conjure.mapping")["on-filetype"]()
      vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = "conjure-log-*",
        callback = function()
            vim.diagnostic.disable(0)
        end,
        desc = "This disables LSP-evaluation of conjure.log-files"
      })
    end,
    init = function()
      vim.g['conjure#log#hud#ignore_low_priority'] = false
    end,
  },
  {
    "gpanders/nvim-parinfer",
    ft = { "python", "clojure" },
    config = function()
      vim.g.parinfer_force_balance = true
    end,
  },
}
