-- Treesitter configuration for lze
return {
  {
    'nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'python',
        'go',
        'gomod',
        'gowork',
        'gosum',
        'json5',
        'dockerfile',
        'templ',
      },
      auto_install = false, -- Managed by nix
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = true, disable = { 'ruby', 'python' } },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}