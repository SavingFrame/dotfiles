-- Git plugins configuration for lze
return {
  {
    'gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
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
    },
  },
  {
    'diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = function()
      local function toggleDiffView(cmd)
        local views = require('diffview.lib').views
        if next(views) == nil then
          vim.cmd(cmd .. ' --imply-local')
        else
          vim.cmd 'DiffviewClose'
        end
      end

      return {
        {
          '<leader>gdd',
          function()
            toggleDiffView 'DiffviewOpen'
          end,
          desc = 'Toggle Diff view',
        },
        {
          '<leader>gdD',
          function()
            toggleDiffView 'DiffviewOpen -- %'
          end,
          desc = 'Toggle Diff view for current file',
        },
        {
          '<leader>gdf',
          function()
            toggleDiffView 'DiffviewFileHistory %'
          end,
          desc = 'File history',
        },
      }
    end,
  },
}