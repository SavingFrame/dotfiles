-- Editor plugins configuration for lze
return {
  {
    'treesj',
    keys = { '<space>m', '<space>j' },
    after = function()
      require('treesj').setup({})
    end,
  },
  {
    'undotree',
    keys = '<leader>U',
    after = function()
      vim.keymap.set('n', '<leader>U', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle Undotree' })
    end,
  },
  {
    'flash.nvim',
    keys = { 's', 'S', 'r', 'R', '<c-s>' },
    after = function()
      require('flash').setup({})
      
      vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
      vim.keymap.set({ "n", "o", "x" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
      vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
      vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
      vim.keymap.set("c", "<c-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })
    end,
  },
  {
    'grug-far.nvim',
    cmd = 'GrugFar',
    keys = '<leader>sr',
    after = function()
      require('grug-far').setup({ headerMaxWidth = 80 })
      
      vim.keymap.set({ 'n', 'v' }, '<leader>sr', function()
        local grug = require 'grug-far'
        local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
        grug.open {
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
          },
        }
      end, { desc = 'Search and Replace' })
    end,
  },
  {
    'trouble.nvim',
    cmd = 'Trouble',
    keys = { '<leader>xx', '<leader>xX', '<leader>cs', '<leader>cl', '<leader>xL', '<leader>xQ' },
    after = function()
      require('trouble').setup({
        modes = {
          symbols = {
            win = {
              size = 0.15,
            },
          },
        },
      })
      
      vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
      vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer Diagnostics (Trouble)' })
      vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
      vim.keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'LSP Definitions / references / ... (Trouble)' })
      vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location List (Trouble)' })
      vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })
    end,
  },
}