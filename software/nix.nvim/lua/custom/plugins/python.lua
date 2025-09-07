return {
  {
    'alexpasmantier/pymple.nvim',
    name = 'pymple',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      -- optional (nicer ui)
      'stevearc/dressing.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('pymple').setup()
    end,
  },
  { 'microsoft/python-type-stubs' },
  { 'Vimjas/vim-python-pep8-indent', ft = 'python' },
  {
    'ranelpadon/python-copy-reference.vim',
    name = 'python-copy-reference',
    keys = {
      { '<leader>cid', '<cmd>PythonCopyReferenceDotted<CR>', desc = 'Copy Dotted Reference' },
      { '<leader>cii', '<cmd>PythonCopyReferenceImport<CR>', desc = 'Copy Import Reference' },
      { '<leader>cit', '<cmd>PythonCopyReferencePytest<CR>', desc = 'Copy pytest Reference' },
    },
  },
}
