-- Treesitter Configuration
-- Handles syntax highlighting, text objects, and treesitter-based features

if nixCats('treesitter') then
  vim.cmd('packadd nvim-treesitter')
  vim.cmd('packadd nvim-treesitter-textobjects')
end

-- Treesitter configuration
if nixCats('treesitter') then
  require('nvim-treesitter.configs').setup {
    -- Since we're using nixCats, parsers are installed via Nix
    -- No need for ensure_installed or auto_install
    
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system for indent rules
      additional_vim_regex_highlighting = true,
    },
    
    indent = { 
      enable = true, 
      disable = { 'ruby', 'python' } 
    },
    
    -- Incremental selection
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
    
    -- Text objects
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']f'] = '@function.outer',
          [']c'] = '@class.outer',
          [']a'] = '@parameter.inner',
        },
        goto_next_end = {
          [']F'] = '@function.outer',
          [']C'] = '@class.outer',
          [']A'] = '@parameter.inner',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[c'] = '@class.outer',
          ['[a'] = '@parameter.inner',
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
          ['[C'] = '@class.outer',
          ['[A'] = '@parameter.inner',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>na'] = '@parameter.inner',
          ['<leader>nf'] = '@function.outer',
        },
        swap_previous = {
          ['<leader>pa'] = '@parameter.inner',
          ['<leader>pf'] = '@function.outer',
        },
      },
    },
  }
end