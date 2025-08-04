-- Tools Configuration
-- Handles development tools like harpoon, overseer, neo-tree, etc.

if nixCats('tools') then
  vim.cmd('packadd harpoon')
  vim.cmd('packadd overseer-nvim')
  vim.cmd('packadd neo-tree-nvim')
  vim.cmd('packadd conform-nvim')
  vim.cmd('packadd persistence-nvim')
  vim.cmd('packadd screenkey')
end

-- Harpoon configuration
if nixCats('tools') then
  local harpoon = require('harpoon')
  harpoon:setup()
  
  -- Harpoon keymaps
  vim.keymap.set('n', '<leader>ha', function()
    harpoon:list():add()
  end, { desc = 'Harpoon add file' })
  
  vim.keymap.set('n', '<leader>hh', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = 'Harpoon quick menu' })
  
  vim.keymap.set('n', '<leader>h1', function()
    harpoon:list():select(1)
  end, { desc = 'Harpoon to file 1' })
  
  vim.keymap.set('n', '<leader>h2', function()
    harpoon:list():select(2)
  end, { desc = 'Harpoon to file 2' })
  
  vim.keymap.set('n', '<leader>h3', function()
    harpoon:list():select(3)
  end, { desc = 'Harpoon to file 3' })
  
  vim.keymap.set('n', '<leader>h4', function()
    harpoon:list():select(4)
  end, { desc = 'Harpoon to file 4' })
  
  -- Toggle previous & next buffers stored within Harpoon list
  vim.keymap.set('n', '<leader>hp', function()
    harpoon:list():prev()
  end, { desc = 'Harpoon previous' })
  
  vim.keymap.set('n', '<leader>hn', function()
    harpoon:list():next()
  end, { desc = 'Harpoon next' })
end

-- Neo-tree configuration
if nixCats('tools') then
  require('neo-tree').setup {
    close_if_last_window = false,
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = '│',
        last_indent_marker = '└',
        highlight = 'NeoTreeIndentMarker',
        with_expanders = nil,
        expander_collapsed = '',
        expander_expanded = '',
        expander_highlight = 'NeoTreeExpander',
      },
      icon = {
        folder_closed = '',
        folder_open = '',
        folder_empty = '󰜌',
        default = '*',
        highlight = 'NeoTreeFileIcon',
      },
      modified = {
        symbol = '[+]',
        highlight = 'NeoTreeModified',
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = 'NeoTreeFileName',
      },
      git_status = {
        symbols = {
          added = '',
          modified = '',
          deleted = '✖',
          renamed = '󰁕',
          untracked = '',
          ignored = '',
          unstaged = '󰄱',
          staged = '',
          conflict = '',
        },
      },
    },
    window = {
      position = 'left',
      width = 40,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true,
      },
      follow_current_file = {
        enabled = false,
        leave_dirs_open = false,
      },
      group_empty_dirs = false,
      hijack_netrw_behavior = 'open_default',
      use_libuv_file_watcher = false,
    },
    buffers = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      group_empty_dirs = true,
      show_unloaded = true,
    },
    git_status = {
      window = {
        position = 'float',
        mappings = {
          ['A'] = 'git_add_all',
          ['gu'] = 'git_unstage_file',
          ['ga'] = 'git_add_file',
          ['gr'] = 'git_revert_file',
          ['gc'] = 'git_commit',
          ['gp'] = 'git_push',
          ['gg'] = 'git_commit_and_push',
        },
      },
    },
  }
  
  -- Neo-tree keymaps
  vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle Neo-tree' })
  vim.keymap.set('n', '<leader>E', '<cmd>Neotree focus<cr>', { desc = 'Focus Neo-tree' })
end

-- Conform (formatting) configuration
if nixCats('tools') then
  require('conform').setup {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_fix', 'ruff_format' },
      html = { 'prettier' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
    },
  }
  
  -- Conform keymap
  vim.keymap.set('', '<leader>cf', function()
    require('conform').format { async = true, lsp_format = 'fallback' }
  end, { desc = '[C]ode [F]ormat' })
end

-- Overseer configuration
if nixCats('tools') then
  require('overseer').setup {
    templates = { 'builtin', 'user.go_build' },
  }
  
  -- Overseer keymaps
  vim.keymap.set('n', '<leader>or', '<cmd>OverseerRun<cr>', { desc = 'Overseer Run' })
  vim.keymap.set('n', '<leader>ot', '<cmd>OverseerToggle<cr>', { desc = 'Overseer Toggle' })
  vim.keymap.set('n', '<leader>oa', '<cmd>OverseerTaskAction<cr>', { desc = 'Overseer Task Action' })
end

-- Persistence (session management) configuration
if nixCats('tools') then
  require('persistence').setup {
    dir = vim.fn.stdpath('state') .. '/sessions/',
    options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' },
    pre_save = nil,
    save_empty = false,
  }
  
  -- Persistence keymaps
  vim.keymap.set('n', '<leader>qs', function()
    require('persistence').load()
  end, { desc = 'Restore Session' })
  
  vim.keymap.set('n', '<leader>ql', function()
    require('persistence').load({ last = true })
  end, { desc = 'Restore Last Session' })
  
  vim.keymap.set('n', '<leader>qd', function()
    require('persistence').stop()
  end, { desc = "Don't Save Current Session" })
end