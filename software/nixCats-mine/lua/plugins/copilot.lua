-- Copilot plugins configuration for lze
return {
  {
    'copilot.lua',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    'blink-copilot',
    event = 'InsertEnter',
    opts = {
      debounce = 50,
      max_completions = 2,
    },
  },
  {
    'CopilotChat.nvim',
    build = 'make tiktoken',
    keys = {
      { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
      {
        '<leader>aa',
        function()
          return require('CopilotChat').toggle()
        end,
        desc = 'Toggle (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ap',
        function()
          require('CopilotChat').select_prompt()
        end,
        desc = 'Prompt Actions (CopilotChat)',
        mode = { 'n', 'v' },
      },
    },
    opts = {},
  },
}