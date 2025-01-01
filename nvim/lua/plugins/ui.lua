return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      styles = { transperecy = true },
    },
    config = function()
      require("rose-pine").setup({
        variant = "auto", -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },

        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },

        groups = {
          border = "muted",
          link = "iris",
          panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",

          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },

        palette = {
          -- Override the builtin palette per variant
          -- moon = {
          --     base = '#18191a',
          --     overlay = '#363738',
          -- },
        },

        highlight_groups = {
          -- Comment = { fg = "foam" },
          -- VertSplit = { fg = "muted", bg = "muted" },
        },

        before_highlight = function(group, highlight, palette)
          -- Disable all undercurls
          -- if highlight.undercurl then
          --     highlight.undercurl = false
          -- end
          --
          -- Change palette colour
          -- if highlight.fg == palette.pine then
          --     highlight.fg = palette.foam
          -- end
        end,
      })

      vim.cmd("colorscheme rose-pine")
      -- vim.cmd("colorscheme rose-pine-main")
      -- vim.cmd("colorscheme rose-pine-moon")
      -- vim.cmd("colorscheme rose-pine-dawn")
    end,
  },

  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   ---@class CatppuccinOptions
  --   opts = {
  --     transparent_background = true,
  --     integrations = {
  --       aerial = true,
  --       alpha = true,
  --       cmp = true,
  --       dashboard = true,
  --       flash = true,
  --       grug_far = true,
  --       gitsigns = true,
  --       headlines = true,
  --       illuminate = true,
  --       indent_blankline = { enabled = true },
  --       leap = true,
  --       lsp_trouble = true,
  --       mason = true,
  --       markdown = true,
  --       mini = true,
  --       native_lsp = {
  --         enabled = true,
  --         underlines = {
  --           errors = { "undercurl" },
  --           hints = { "undercurl" },
  --           warnings = { "undercurl" },
  --           information = { "undercurl" },
  --         },
  --       },
  --       navic = { enabled = true, custom_bg = "lualine" },
  --       neotest = true,
  --       neotree = true,
  --       noice = true,
  --       notify = true,
  --       semantic_tokens = true,
  --       telescope = true,
  --       treesitter = true,
  --       treesitter_context = true,
  --       which_key = true,
  --     },
  --   },
  -- },
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   -- "sainnhe/gruvbox-material",
  --   config = true,
  --   opts = {
  --     transparent_mode = true,
  --     -- overrides = {
  --     --   DiagnosticWarn = { bg = "#fe8019" },
  --     -- },
  --   },
  --   {
  --     "sainnhe/gruvbox-material",
  --     lazy = false,
  --     priority = 1000,
  --     config = function()
  --       -- Optionally configure and load the colorscheme
  --       -- directly inside the plugin declaration.
  --       vim.g.gruvbox_material_enable_italic = true
  --       vim.g.gruvbox_material_transparent_background = true
  --       vim.g.gruvbox_material_diagnostic_text_highlight = true
  --       vim.g.gruvbox_material_diagnostic_text_highlight = true
  --     end,
  --   },
  -- },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  -- buefferline before rose-pine
  -- {
  --   "akinsho/bufferline.nvim",
  --   opts = {
  --     options = {
  --       highlights = {
  --         fill = {
  --           bg = {
  --             attribute = "fg",
  --             highlight = "Pmenu",
  --           },
  --         },
  --       },
  --     },
  --   },
  --   -- opts = function(_, opts)
  --   --   local bufferline = require("bufferline")
  --   --   opts.style_preset = bufferline.style_preset.default
  --   --   -- opts.options.separator_style = "padded_slant"
  --   --   -- opts.options.separator_style = { " ", "" }
  --   -- end,
  -- },
  -- bufferline for rose-pine
  {
    "akinsho/bufferline.nvim",
    event = "ColorScheme",
    opts = {
      options = {
        highlights = {
          fill = {
            bg = {
              attribute = "fg",
              highlight = "Pmenu",
            },
          },
        },
      },
    },
    config = function(_, opts)
      local highlights = require("rose-pine.plugins.bufferline")
      opts.highlights = highlights
      require("bufferline").setup(opts)
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  -- {
  --   "rebelot/kanagawa.nvim",
  --   opts = {
  --     -- transparent = true,
  --   },
  -- },
  {
    "LazyVim/LazyVim",
    dependencies = {
      -- "sainnhe/gruvbox-material",
      "rose-pine",
    },
    opts = {
      -- colorscheme = "catppuccin",
      -- colorscheme = "gruvbox-material",
      -- colorscheme = "kanagawa",
      colorscheme = "rose-pine",
    },
  },
  -- {
  --   "tzachar/highlight-undo.nvim",
  -- },
}
