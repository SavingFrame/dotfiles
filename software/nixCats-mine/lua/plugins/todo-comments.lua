-- Todo comments plugins configuration for lze
return {
    {
    'todo-comments.nvim',
    event = 'VimEnter',
    after = function()
      require('todo-comments').setup({
      signs = false,
    })
    end,
},
}
