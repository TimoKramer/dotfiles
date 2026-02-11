local M = {}

M.ensure_installed = {
  'lua-language-server',
  'stylua',
  'clangd',
  'clojure-lsp',
  'gopls',
  'jdtls',
  'ruff',
  'basedpyright',
}

M.servers = {
  clojure_lsp = {
    root_markers = { 'deps.edn', 'project.clj', 'bb.edn', 'workspace.edn', '.git' },
  },
  clangd = {
    cmd = { 'clangd', '--enable-config' },
  },
  gopls = {
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
}

return M
