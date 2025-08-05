-- Copilot plugins configuration for lze
return {
  {
    'copilot.lua',
    event = 'InsertEnter',
    after = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  -- {
  --   'blink-copilot',
  --   event = 'InsertEnter',
  --   after = function()
  --     require('blink-copilot').setup({
  --       debounce = 50,
  --       max_completions = 2,
  --     })
  --   end,
  -- },
  {
    'CopilotChat.nvim',
    keys = { '<leader>a', '<leader>aa', '<leader>ap' },
    after = function()
      require('CopilotChat').setup({})
      
      vim.keymap.set({'n', 'v'}, '<leader>a', '', { desc = '+ai' })
      vim.keymap.set({'n', 'v'}, '<leader>aa', function()
        return require('CopilotChat').toggle()
      end, { desc = 'Toggle (CopilotChat)' })
      vim.keymap.set({'n', 'v'}, '<leader>ap', function()
        require('CopilotChat').select_prompt()
      end, { desc = 'Prompt Actions (CopilotChat)' })
    end,
  },
}
