-- Editor Configuration
-- Handles editor enhancements, navigation, and editing tools

if nixCats('editor') then
  -- Load optional plugins
  vim.cmd('packadd flash-nvim')
  vim.cmd('packadd trouble-nvim')
  vim.cmd('packadd gitsigns-nvim')
  vim.cmd('packadd diffview-nvim')
  vim.cmd('packadd undotree')
  vim.cmd('packadd treesj')
  vim.cmd('packadd grug-far-nvim')
  vim.cmd('packadd which-key-nvim')
  vim.cmd('packadd todo-comments-nvim')
  vim.cmd('packadd mini-nvim')
  vim.cmd('packadd vim-tmux-navigator')
  -- vim.cmd('packadd close-buffers') -- Temporarily disabled
  vim.cmd('packadd marks-nvim')
  vim.cmd('packadd nvim-ufo')
  vim.cmd('packadd promise-async')
  vim.cmd('packadd vim-python-pep8-indent')
end

-- Which-key configuration
if nixCats('editor') then
  require('which-key').setup {
    preset = 'helix',
    delay = 250,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },
    spec = {
      { '<leader>s', group = '[S]earch' },
      { '<leader>b', group = '[B]uffers' },
      { '<leader>f', group = '[F]ind' },
      { '<leader>u', group = '[U]I' },
      { '<leader>c', group = '[C]ode' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>g', group = '[G]it' },
      { '<leader>x', group = 'Trouble' },
      { '<leader>a', group = '[A]I' },
    },
  }
end

-- Gitsigns configuration
if nixCats('editor') then
  require('gitsigns').setup {
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
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end, { desc = 'Next git hunk' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end, { desc = 'Previous git hunk' })

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
      end, { desc = 'Stage hunk' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
      end, { desc = 'Reset hunk' })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
      map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Undo stage hunk' })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
      map('n', '<leader>hb', function()
        gitsigns.blame_line { full = true }
      end, { desc = 'Blame line' })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Diff this' })
      map('n', '<leader>hD', function()
        gitsigns.diffthis('~')
      end, { desc = 'Diff this ~' })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select git hunk' })
    end,
  }
end

-- Flash configuration
if nixCats('editor') then
  require('flash').setup {}
  
  -- Flash keymaps
  vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
    require('flash').jump()
  end, { desc = 'Flash' })
  
  vim.keymap.set({ 'n', 'o', 'x' }, 'S', function()
    require('flash').treesitter()
  end, { desc = 'Flash Treesitter' })
  
  vim.keymap.set('o', 'r', function()
    require('flash').remote()
  end, { desc = 'Remote Flash' })
  
  vim.keymap.set({ 'o', 'x' }, 'R', function()
    require('flash').treesitter_search()
  end, { desc = 'Treesitter Search' })
  
  vim.keymap.set({ 'c' }, '<c-s>', function()
    require('flash').toggle()
  end, { desc = 'Toggle Flash Search' })
end

-- Trouble configuration
if nixCats('editor') then
  require('trouble').setup {
    modes = {
      symbols = {
        win = {
          size = 0.15,
        },
      },
    },
  }
  
  -- Trouble keymaps
  vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
  vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer Diagnostics (Trouble)' })
  vim.keymap.set('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
  vim.keymap.set('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'LSP Definitions / references / ... (Trouble)' })
  vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location List (Trouble)' })
  vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })
end

-- Diffview configuration
if nixCats('editor') then
  require('diffview').setup {}
  
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
end

-- Undotree configuration
if nixCats('editor') then
  vim.keymap.set('n', '<leader>U', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle Undotree' })
end

-- TreeSJ configuration
if nixCats('editor') then
  require('treesj').setup {}
  vim.keymap.set('n', '<space>m', require('treesj').toggle, { desc = 'Toggle TreeSJ' })
  vim.keymap.set('n', '<space>j', require('treesj').join, { desc = 'TreeSJ Join' })
end

-- Grug-far configuration
if nixCats('editor') then
  require('grug-far').setup { headerMaxWidth = 80 }
  
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
end

-- Todo Comments configuration
if nixCats('editor') then
  require('todo-comments').setup { signs = false }
end

-- Mini.nvim configuration
if nixCats('editor') then
  -- Better Around/Inside textobjects
  local ai = require 'mini.ai'
  ai.setup {
    n_lines = 500,
    custom_textobjects = {
      o = ai.gen_spec.treesitter {
        a = { '@block.outer', '@conditional.outer', '@loop.outer' },
        i = { '@block.inner', '@conditional.inner', '@loop.inner' },
      },
      f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
      c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
    },
  }

  -- Add/delete/replace surroundings
  require('mini.surround').setup {
    mappings = {
      add = 'gsa',
      delete = 'gsd',
      find = 'gsf',
      find_left = 'gsF',
      highlight = 'gsh',
      replace = 'gsr',
      update_n_lines = 'gsn',
    },
  }

  -- Auto pairs
  require('mini.pairs').setup {
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    skip_ts = { 'string' },
    skip_unbalanced = true,
    markdown = true,
  }
end

-- Close buffers configuration (temporarily disabled)
--[[ 
if nixCats('editor') then
  require('close_buffers').setup {
    filetype_ignore = { 'neo-tree' },
    file_glob_ignore = {},
    file_regex_ignore = {},
    preserve_window_layout = { 'this', 'nameless' },
    next_buffer_cmd = nil,
  }
  
  vim.keymap.set('n', '<leader>bo', function()
    require('close_buffers').delete { type = 'hidden', force = true }
  end, { desc = 'Delete Other Buffers' })
end
--]]

-- Marks configuration
if nixCats('editor') then
  require('marks').setup {}
end

-- UFO (folding) configuration
if nixCats('editor') then
  require('ufo').setup {
    provider_selector = function(bufnr, filetype, buftype)
      return { 'treesitter', 'indent' }
    end,
  }
  
  vim.o.foldcolumn = '1'
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
  
  vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
end