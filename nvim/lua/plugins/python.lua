return {
  { "microsoft/python-type-stubs" },
  { "Vimjas/vim-python-pep8-indent", ft = "python" },
  {
    "ranelpadon/python-copy-reference.vim",
    keys = {
      { "<leader>cid", "<cmd>PythonCopyReferenceDotted<CR>", desc = "Copy Dotted Reference" },
      { "<leader>cii", "<cmd>PythonCopyReferenceImport<CR>", desc = "Copy Import Reference" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        basedpyright = {
          disableOrganizeImports = true,
          analysis = {
            diagnosticMode = "openFilesOnly",
            stubPath = "/Users/user/.local/share/nvim/lazy/python-type-stubs",
            typeCheckingMode = "basic",
            useLibraryCodeForTypes = true,
            diagnosticSeverityOverrides = {
              reportAssignmentType = "warning",
            },
          },
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
              analysis = {
                diagnosticMode = "openFilesOnly",
                stubPath = "/Users/user/.local/share/nvim/lazy/python-type-stubs",
                typeCheckingMode = "basic",
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                  reportAssignmentType = "warning",
                },
              },
            },
          },
        },
      },
    },
  },
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     table.insert(opts.ensure_installed, "black")
  --   end,
  -- },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      log_level = "debug",
      adapters = {
        ["neotest-python"] = {
          dap = {
            justMyCode = false,
            console = "integratedTerminal",
          },
          args = { "-s" },
          runner = "pytest",
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },
}
