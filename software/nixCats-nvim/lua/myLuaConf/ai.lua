-- AI Configuration
-- Handles Copilot integration and AI-powered features

if nixCats('ai') then
  vim.cmd('packadd copilot-lua')
  vim.cmd('packadd copilot-vim')
  vim.cmd('packadd copilot-chat-nvim')
end

-- Copilot.lua configuration
if nixCats('ai') then
  require('copilot').setup {
    suggestion = { enabled = false },
    panel = { enabled = false },
  }
end

-- Blink-copilot integration (if available)
if nixCats('ai') and nixCats('extra') then
  -- This will be handled by the blink.cmp configuration
  -- The plugin is loaded via the extra category
end

-- Update blink.cmp to include copilot if AI is enabled
if nixCats('ai') and nixCats('completion') then
  local blink_config = require('blink.cmp').get_config()
  
  -- Add copilot to sources
  if blink_config.sources then
    blink_config.sources.default = blink_config.sources.default or {}
    table.insert(blink_config.sources.default, 'copilot')
    
    blink_config.sources.providers = blink_config.sources.providers or {}
    blink_config.sources.providers.copilot = {
      name = 'copilot',
      module = 'blink-copilot',
      score_offset = 100,
      async = true,
    }
  end
  
  -- Add copilot icon
  if blink_config.appearance then
    blink_config.appearance.kind_icons = blink_config.appearance.kind_icons or {}
    blink_config.appearance.kind_icons.Copilot = ''
    
    -- Add other kind icons for completeness
    local kind_icons = {
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
    }
    
    for kind, icon in pairs(kind_icons) do
      if not blink_config.appearance.kind_icons[kind] then
        blink_config.appearance.kind_icons[kind] = icon
      end
    end
  end
  
  -- Reconfigure blink.cmp with copilot support
  require('blink.cmp').setup(blink_config)
end

-- CopilotChat configuration
if nixCats('ai') then
  require('CopilotChat').setup {
    -- See Configuration section for options
  }
  
  -- CopilotChat keymaps
  vim.keymap.set({ 'n', 'v' }, '<leader>aa', function()
    return require('CopilotChat').toggle()
  end, { desc = 'Toggle (CopilotChat)' })
  
  vim.keymap.set({ 'n', 'v' }, '<leader>ap', function()
    require('CopilotChat').select_prompt()
  end, { desc = 'Prompt Actions (CopilotChat)' })
end