-- Git plugins configuration for lze
return {
  {
    'gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    after = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '┃' },
          change = { text = '┃' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '┆' },
        },
        signs_staged = {
          add = { text = '┃' },
          change = { text = '┃' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '┆' },
        },
      })
    end,
  },
  {
    'diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = { '<leader>gdd', '<leader>gdD', '<leader>gdf' },
    after = function()
      local function toggleDiffView(cmd)
        local views = require('diffview.lib').views
        if next(views) == nil then
          vim.cmd(cmd .. ' --imply-local')
        else
          vim.cmd 'DiffviewClose'
        end
      end

      vim.keymap.set('n', '<leader>gdd', function()
        toggleDiffView 'DiffviewOpen'
      end, { desc = 'Toggle Diff view' })
      
      vim.keymap.set('n', '<leader>gdD', function()
        toggleDiffView 'DiffviewOpen -- %'
      end, { desc = 'Toggle Diff view for current file' })
      
      vim.keymap.set('n', '<leader>gdf', function()
        toggleDiffView 'DiffviewFileHistory %'
      end, { desc = 'File history' })
    end,
  },
}