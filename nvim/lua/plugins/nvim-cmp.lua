return {
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      -- debug = true,
      -- bind = true,
      -- handler_opts = {
      --   border = "rounded",
      -- },
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        signature = {
          enabled = false,
        },
      },
    },
  },
}
