-- UI plugins configuration for lze
return {
  {
    'snacks.nvim',
    priority = 1000,
    lazy = false,
    after = function()
      require('snacks').setup({
        dashboard = { enabled = true },
        indent = {
          enabled = true,
          chunk = {
            enabled = true,
          },
        },
        lazygit = {
          enabled = true,
        },
        input = { enabled = true },
        picker = {
          formatters = {
            file = {
              truncate = 120,
            },
          },
          previewers = {
            git = {
              native = true,
            },
          },
        },
        notifier = {
          enabled = true,
        },
        quickfile = { enabled = true },
        scope = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
      })
      
      -- Set up keymaps
      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        vim.keymap.set(mode, lhs, rhs, opts)
      end
      
      -- Top Pickers & Explorer
      map('n', '<leader><space>', function() Snacks.picker.smart() end, { desc = 'Smart Find Files' })
      map('n', '<leader>,', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
      map('n', '<leader><tab>', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
      map('n', '<leader>:', function() Snacks.picker.command_history() end, { desc = 'Command History' })
      map('n', '<leader>n', function() Snacks.picker.notifications() end, { desc = 'Notification History' })
      
      -- find
      map('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
      map('n', '<leader>fc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Find Config File' })
      map('n', '<leader>ff', function()
        Snacks.picker.files {
          finder = 'files',
          format = 'file',
          hidden = true,
          ignored = true,
          follow = false,
          supports_live = true,
        }
      end, { desc = 'Find Files' })
      map('n', '<leader>fr', function() Snacks.picker.recent() end, { desc = 'Recent' })
      
      -- git
      map('n', '<leader>gd', function() Snacks.picker.git_diff() end, { desc = 'Git Diff (Hunks)' })
      map('n', '<leader>gf', function() Snacks.picker.git_log_file() end, { desc = 'Git Log File' })
      map('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })
      
      -- Grep
      map('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = 'Grep' })
      map({'n', 'x'}, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = 'Visual selection or word' })
      
      -- search
      map('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = 'Buffer Lines' })
      map('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
      map('n', '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
      map('n', '<leader>sh', function() Snacks.picker.help() end, { desc = 'Help Pages' })
      map('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = 'Highlights' })
      map('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = 'Jumps' })
      map('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
      map('n', '<leader>sl', function() Snacks.picker.loclist() end, { desc = 'Location List' })
      map('n', '<leader>sm', function() Snacks.picker.marks() end, { desc = 'Marks' })
      map('n', '<leader>sM', function() Snacks.picker.man() end, { desc = 'Man Pages' })
      map('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = 'Quickfix List' })
      map('n', '<leader>sR', function() Snacks.picker.resume() end, { desc = 'Resume' })
      map('n', '<leader>su', function() Snacks.picker.undo() end, { desc = 'Undo History' })
      map('n', '<leader>sp', function() Snacks.picker.lazy() end, { desc = 'Search for Plugin Spec' })
      map('n', '<leader>uC', function() Snacks.picker.colorschemes() end, { desc = 'Colorschemes' })
      map('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete Buffer' })
      map('n', '<leader>cR', function() Snacks.rename.rename_file() end, { desc = 'Rename File' })
      map({'n', 'v'}, '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })
      map({'n', 'v'}, '<leader>gb', function() Snacks.git.blame_line() end, { desc = 'Git Blame' })
      map('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Lazygit' })
      map('n', '<leader>un', function() Snacks.notifier.hide() end, { desc = 'Dismiss All Notifications' })
      map({'n', 't'}, ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = 'Next Reference' })
      map({'n', 't'}, '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = 'Prev Reference' })
    end,
  },
  {
    'lualine.nvim',
    after = function()
      require('lualine').setup({
        options = {
          theme = 'kanagawa',
          section_separators = '',
          component_separators = '',
          disabled_filetypes = {
            statusline = { 'neo-tree' },
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = {
            {
              'filename',
              file_status = true,
              newfile_status = false,
              path = 1,
              shorting_target = 120,
              symbols = {
                modified = '[+]',
                readonly = '[-]',
                unnamed = '[No Name]',
                newfile = '[New]',
              },
            },
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        winbar = {
          lualine_c = {
            {
              'filename',
              file_status = true,
              newfile_status = false,
              path = 1,
              shorting_target = 120,
              symbols = {
                modified = '[+]',
                readonly = '[-]',
                unnamed = '[No Name]',
                newfile = '[New]',
              },
            },
            {
              'navic',
              color_correction = nil,
              navic_opts = nil,
            },
          },
        },
      })
    end,
  },
  {
    'marks.nvim',
    after = function()
      require('marks').setup({})
    end,
  },
  {
    'nvim-navic',
    event = 'LspAttach',
    after = function()
      require('nvim-navic').setup {
        lsp = {
          auto_attach = true,
          preference = { 'clangd', 'basedpyright', 'tsserver' },
        },
        highlight = true,
        separator = ' > ',
        depth_limit = 0,
        depth_limit_indicator = '..',
      }
    end,
  },
  {
    'lackluster.nvim',
    lazy = false,
    priority = 1000,
    after = function()
      local lackluster = require 'lackluster'
      lackluster.setup {
        tweak_syntax = {
          comment = lackluster.color.gray5,
        },
        tweak_highlight = {
          ['DiagnosticWarn'] = {
            fg = lackluster.color.yellow,
          },
          ['DiagnosticVirtualTextWarn'] = {
            fg = lackluster.color.yellow,
          },
        },
      }
      vim.api.nvim_set_hl(0, 'WinBar', { fg = '#7a7a7a', bg = '#242424' })
      vim.api.nvim_set_hl(0, 'WinBarNC', { fg = '#7a7a7a', bg = '#242424' })
    end,
  },
  {
    'kanagawa.nvim',
    lazy = false,
    priority = 1000,
    after = function()
      require('kanagawa').setup {
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = 'none',
              },
            },
          },
        },
      }
      vim.cmd.colorscheme 'kanagawa'
    end,
  },
  {
    'close-buffers.nvim',
    keys = '<leader>bo',
    after = function()
      require('close_buffers').setup({
        filetype_ignore = { 'neo-tree' },
        file_glob_ignore = {},
        file_regex_ignore = {},
        preserve_window_layout = { 'this', 'nameless' },
        next_buffer_cmd = nil,
      })
      
      vim.keymap.set('n', '<leader>bo', function()
        require('close_buffers').delete { type = 'hidden', force = true }
      end, { desc = 'Delete Other Buffers' })
    end,
  },
  {
    'nui.nvim',
  },
  {
    'noice.nvim',
    after = function()
      require('noice').setup({})
    end,
  },
}
