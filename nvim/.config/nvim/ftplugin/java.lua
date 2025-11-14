vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

-- JDTLS (Java LSP) setup with DAP support
local jdtls = require 'jdtls'
local home = os.getenv 'HOME'

-- Find root of project
local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)

-- Eclipse jdtls location (installed via Mason)
local jdtls_path = vim.fn.stdpath 'data' .. '/mason/packages/jdtls'
local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')

-- Project-specific workspace folder
local workspace_folder = home .. '/.local/share/eclipse/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

-- DAP configuration
local bundles = {
  vim.fn.glob(home .. '/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', 1),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/.local/share/nvim/mason/packages/java-test/extension/server/*.jar', 1), '\n'))

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    launcher_jar,
    '-configuration',
    jdtls_path .. '/config_linux',
    '-data',
    workspace_folder,
  },
  root_dir = root_dir,
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath 'config' .. '/lang-servers/intellij-java-google-style.xml',
          profile = 'GoogleStyle',
        },
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        'org.hamcrest.MatcherAssert.assertThat',
        'org.hamcrest.Matchers.*',
        'org.hamcrest.CoreMatchers.*',
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'java.util.Objects.requireNonNullElse',
        'org.mockito.Mockito.*',
      },
    },
    contentProvider = { preferred = 'fernflower' },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
      },
      useBlocks = true,
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = bundles,
  },
}

-- Start or attach to language server
jdtls.start_or_attach(config)

-- DAP keybindings (additional to the global ones from debug.lua)
vim.keymap.set('n', '<leader>dt', jdtls.test_class, { desc = 'Debug: Test Class' })
vim.keymap.set('n', '<leader>dn', jdtls.test_nearest_method, { desc = 'Debug: Test Nearest Method' })
