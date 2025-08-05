-- Which-key plugins configuration for lze
return {
  {
    'which-key.nvim',
    lazy = false,
    after = function()
      require
      preset = 'helix',
      delay = 250,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
              })
    end,
            })
    end,
      spec = {
        { '<leader>s', group = '[S]earch'       })
    end,
        { '<leader>b', group = '[B]uffers'       })
    end,
        { '<leader>f', group = '[F]ind'       })
    end,
        { '<leader>u', group = '[U]I'       })
    end,
        { '<leader>c', group = '[C]ode'       })
    end,
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' }       })
    end,
            })
    end,
          })
    end,
        })
    end,
}
