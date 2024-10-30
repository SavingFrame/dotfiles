return {
  "nvim-treesitter/nvim-treesitter",
  opts = {

    indent = {
      enable = true,
      -- disable = { "python" }, -- Disable Tree-sitter indent for Python
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
