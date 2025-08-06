-- Completion configuration for lze
return {
  {
    'luasnip',
  },
  {
    'blink.cmp',
    event = 'InsertEnter',
    after = function()
      require('blink.cmp').setup({
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
        -- default = { 'lsp', 'path', 'snippets', 'lazydev', 'copilot' },
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          -- copilot = {
          --   name = 'copilot',
          --   module = 'blink-copilot',
          --   score_offset = 100,
          --   async = true,
          -- },
        },
      },
      appearance = {
        nerd_font_variant = 'mono',
        kind_icons = {
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
        },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
        signature = { enabled = true },
      })
    end,
  },
}
