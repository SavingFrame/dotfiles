return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = {
      additional_vim_regex_highlighting = true,
    },

    indent = {
      enable = true,
      disable = { "python" }, -- Disable Tree-sitter indent for Python
    },
    ensure_installed = {
      "bash",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "vim",
      "yaml",
    },
  },
}
