-- Python Configuration
-- Handles Python-specific tools and configurations

if nixCats('python') then
  vim.cmd('packadd SchemaStore-nvim')
  vim.cmd('packadd pymple')
  vim.cmd('packadd python-copy-reference')
end

-- Python-specific configurations
if nixCats('python') then
  -- Set up Python-specific settings
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
      -- Python-specific settings
      vim.opt_local.tabstop = 4
      vim.opt_local.softtabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.expandtab = true
      
      -- Python-specific keymaps
      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = true
        vim.keymap.set(mode, lhs, rhs, opts)
      end
      
      -- Python REPL keymaps (if available)
      if vim.fn.executable('python3') == 1 then
        map('n', '<leader>pr', '<cmd>terminal python3<cr>', { desc = 'Python REPL' })
      end
      
      -- Python-specific LSP keymaps are handled in lsp.lua
    end,
  })
  
  -- Python path configuration
  if vim.fn.executable('python3') == 1 then
    vim.g.python3_host_prog = vim.fn.exepath('python3')
  end
end

-- Additional Python tools configuration
if nixCats('python') then
  -- Pymple.nvim configuration (if loaded via python plugins)
  -- This would be configured here if the plugin is available
  
  -- Python copy reference configuration (if loaded via python plugins)
  -- This would be configured here if the plugin is available
end

-- Python testing configuration (handled in testing.lua)
-- Python LSP configuration (handled in lsp.lua)
-- Python formatting configuration (handled in tools.lua via conform)