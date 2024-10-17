return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    ---@class CatppuccinOptions
    opts = {
      transparent_background = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    -- "sainnhe/gruvbox-material",
    config = true,
    opts = {
      transparent_mode = true,
      -- overrides = {
      --   DiagnosticWarn = { bg = "#fe8019" },
      -- },
    },
    {
      "sainnhe/gruvbox-material",
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.gruvbox_material_enable_italic = true
        vim.g.gruvbox_material_transparent_background = true
        vim.g.gruvbox_material_diagnostic_text_highlight = true
        vim.g.gruvbox_material_diagnostic_text_highlight = true
      end,
    },
  },
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
  {
    "akinsho/bufferline.nvim",
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
    -- opts = function(_, opts)
    --   local bufferline = require("bufferline")
    --   opts.style_preset = bufferline.style_preset.default
    --   -- opts.options.separator_style = "padded_slant"
    --   -- opts.options.separator_style = { " ", "" }
    -- end,
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      -- transparent = true,
    },
  },
  {
    "LazyVim/LazyVim",
    dependencies = {
      "sainnhe/gruvbox-material",
    },
    opts = {
      -- colorscheme = "catppuccin",
      -- colorscheme = "gruvbox-material",
      colorscheme = "kanagawa",
    },
  },
}
