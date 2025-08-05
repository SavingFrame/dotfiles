-- Mini plugins configuration for lze
return {
  {
    'mini.nvim',
    -- event = 'VeryLazy',
    config = function()
      local ai = require 'mini.ai'
      ai.setup {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter {
            a = { '@block.outer', '@conditional.outer', '@loop.outer'       })
    end,
            i = { '@block.inner', '@conditional.inner', '@loop.inner'       })
    end,
                })
    end,
          f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner'       })
    end,
          c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner'       })
    end,
              })
    end,
      }

      require('mini.surround').setup {
        mappings = {
          add = 'gsa',
          delete = 'gsd',
          find = 'gsf',
          find_left = 'gsF',
          highlight = 'gsh',
          replace = 'gsr',
          update_n_lines = 'gsn',
              })
    end,
      }

      require('mini.pairs').setup {
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        skip_ts = { 'string'       })
    end,
        skip_unbalanced = true,
        markdown = true,
      }
    end,
        })
    end,
}
