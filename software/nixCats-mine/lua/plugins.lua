-- Main plugin configuration using lze
-- Load all plugins without category restrictions

local lze = require('lze')

-- Load core plugins that are always available
require('plugins.core')

-- Collect all plugin specs without category checks
local plugin_specs = {}

-- Helper function to safely require and add specs
local function add_specs(module_name)
  local ok, specs = pcall(require, 'plugins.' .. module_name)
  if ok and specs then
    for _, spec in ipairs(specs) do
      table.insert(plugin_specs, spec)
    end
  end
end

-- Load all plugin modules
add_specs('ui')
add_specs('git')
add_specs('editor')
add_specs('copilot')
-- add_specs('lsp')
require('plugins/lsp')
add_specs('treesitter')
add_specs('completion')
add_specs('format')
add_specs('debug')
add_specs('testing')
add_specs('python')
add_specs('utils')
add_specs('fold')
add_specs('overseer')
add_specs('neo-tree')
add_specs('mini')
add_specs('which-key')
add_specs('todo-comments')

-- Load all plugins with lze
if #plugin_specs > 0 then
  lze.load(plugin_specs)
end
