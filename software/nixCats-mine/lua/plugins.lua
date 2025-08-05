-- Main plugin configuration using lze
-- Only load plugins that are available via nixCats categories

local lze = require('lze')

-- Load core plugins that are always available
require('plugins.core')

-- Collect all plugin specs based on nixCats categories
local plugin_specs = {}

-- Helper function to safely require and add specs
local function add_specs(category, module_name)
  if nixCats(category) then
    local ok, specs = pcall(require, 'plugins.' .. module_name)
    if ok and specs then
      for _, spec in ipairs(specs) do
        table.insert(plugin_specs, spec)
      end
    end
  end
end

-- Load plugins based on categories
add_specs('ui', 'ui')
add_specs('git', 'git')
add_specs('editor', 'editor')
add_specs('copilot', 'copilot')
add_specs('lsp', 'lsp')
add_specs('treesitter', 'treesitter')
add_specs('completion', 'completion')
add_specs('format', 'format')
add_specs('debug', 'debug')
add_specs('testing', 'testing')
add_specs('python', 'python')
add_specs('utils', 'utils')
add_specs('fold', 'fold')
add_specs('overseer', 'overseer')
add_specs('neo_tree', 'neo-tree')
add_specs('mini', 'mini')
add_specs('which_key', 'which-key')
add_specs('todo_comments', 'todo-comments')

-- Load all plugins with lze
if #plugin_specs > 0 then
  lze.load(plugin_specs)
end