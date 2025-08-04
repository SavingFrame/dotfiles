-- Completion Configuration
-- Handles blink.cmp, LuaSnip, and completion sources

-- LazyDev configuration for Lua development
if nixCats('completion') then
  require('lazydev').setup {
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      { path = 'snacks.nvim', words = { 'Snacks' } },
    },
  }
end

-- LuaSnip configuration
if nixCats('completion') then
  local luasnip = require('luasnip')
  
  luasnip.setup {
    -- Configuration for LuaSnip
  }
end

-- Blink.cmp configuration
if nixCats('completion') then
  require('blink.cmp').setup {
    keymap = {
      preset = 'default',
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = {
        enabled = true,
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },

    snippets = { preset = 'luasnip' },

    fuzzy = { implementation = 'prefer_rust_with_warning' },

    signature = { enabled = true },
  }
end
