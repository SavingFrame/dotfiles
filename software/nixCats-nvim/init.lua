--[[
nixCats-nvim Configuration
Ported from lua.nvim (Kickstart.nvim based)

This configuration uses nixCats for plugin management while preserving
the original Lua configuration structure and functionality.
--]]

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }

-- Enable mouse mode
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Tab settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Cursor settings
vim.opt.guicursor =
  'n-v-c-sm:block-blinkwait700-blinkon400-blinkoff250,i-ci-ve:ver25-blinkwait700-blinkon400-blinkoff250,r-cr-o:hor20-blinkwait700-blinkon400-blinkoff250'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital letters
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Configure splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.o.inccommand = 'split'

-- Show cursor line
vim.o.cursorline = true

-- Minimal screen lines around cursor
vim.o.scrolloff = 10

-- Confirm before failing operations
vim.o.confirm = true

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Basic Autocommands ]]
-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Close certain filetypes with 'q'
local function augroup(name)
  return vim.api.nvim_create_augroup('nixcats_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dbout',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

-- [[ nixCats Plugin Loading ]]
-- nixCats provides a function to check if categories are enabled
-- This replaces lazy.nvim's plugin loading system

-- Load plugins based on nixCats categories
if nixCats('core') then
  -- Core plugins are loaded automatically via startupPlugins
  require('guess-indent').setup {}
end

if nixCats('ui') then
  -- UI plugins configuration
  require 'myLuaConf.ui'
end

if nixCats('completion') then
  -- Completion system
  require 'myLuaConf.completion'
end

if nixCats('lsp') then
  -- LSP configuration
  require 'myLuaConf.lsp'
end

if nixCats('treesitter') then
  -- Treesitter configuration
  require 'myLuaConf.treesitter'
end

if nixCats('editor') then
  -- Editor enhancements
  require 'myLuaConf.editor'
end

if nixCats('ai') then
  -- AI/Copilot configuration
  require 'myLuaConf.ai'
end

if nixCats('tools') then
  -- Development tools
  require 'myLuaConf.tools'
end

if nixCats('testing') then
  -- Testing configuration
  require 'myLuaConf.testing'
end

if nixCats('python') then
  -- Python-specific configuration
  require 'myLuaConf.python'
end

-- Enable snakelsp if available
if vim.fn.executable('snakelsp') == 1 then
  vim.lsp.enable 'snakelsp'
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
