-- Completion configuration for lze
return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '1.*',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'folke/lazydev.nvim',
    },
    opts = {
      keymap = {
        preset = 'default',
      },



      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = {
          enabled = true,
        },
      },

      sources = {
        default = nixCats('copilot') and { 'lsp', 'path', 'snippets', 'lazydev', 'copilot' } or { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          copilot = nixCats('copilot') and {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          } or nil,
        },
      },

      appearance = {
        nerd_font_variant = 'mono',
        kind_icons = nixCats('copilot') and {
          Copilot = '',
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',
          Field = '󰜢',
          Variable = '󰆦',
          Property = '󰖷',
          Class = '󱡠',
          Interface = '󱡠',
          Struct = '󱡠',
          Module = '󰅩',
          Unit = '󰪚',
          Value = '󰦨',
          Enum = '󰦨',
          EnumMember = '󰦨',
          Keyword = '󰻾',
          Constant = '󰏿',
          Snippet = '󱄽',
          Color = '󰏘',
          File = '󰈔',
          Reference = '󰬲',
          Folder = '󰉋',
          Event = '󱐋',
          Operator = '󰪚',
          TypeParameter = '󰬛',
        } or {},
      },

      snippets = { preset = 'luasnip' },

      fuzzy = { implementation = 'prefer_rust_with_warning' },

      signature = { enabled = true },
    },
  },
  {
    'L3MON4D3/LuaSnip',
    version = '2.*',
    build = function()
      if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
        return
      end
      return 'make install_jsregexp'
    end,
    opts = {},
  },
}