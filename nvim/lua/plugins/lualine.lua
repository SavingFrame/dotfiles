return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "navarasu/onedark.nvim",
    },
    event = "VeryLazy",
    opts = function(_, opts)
      -- opts.options.theme = "rose-pine"
      opts.options.theme = "onedark"
      opts.sections.lualine_c[4] = {
        LazyVim.lualine.pretty_path({
          length = 10,
          relative = "cwd",
          modified_hl = "MatchParen",
          directory_hl = "",
          filename_hl = "Bold",
          modified_sign = "",
          readonly_icon = " 󰌾 ",
        }),
      }
    end,
  },
}
