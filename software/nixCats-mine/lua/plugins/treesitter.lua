-- Treesitter configuration for lze
return {
  {
    'nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile'       })
    end,
    build = ':TSUpdate',
    after = function()
      require
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
            })
    end,
      auto_install = false, -- Managed by nix
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
            })
    end,
      indent = { enable = true, disable = { 'ruby', 'python' }       })
    end,
          })
    end,
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
        })
    end,
}