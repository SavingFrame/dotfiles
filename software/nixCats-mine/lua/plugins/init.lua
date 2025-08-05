-- Main plugin configuration using lze
-- Only load plugins that are available via nixCats categories

local lze = require('lze')

-- Load core plugins that are always available
require('plugins.core')

-- Load plugins based on nixCats categories
local plugin_specs = {}

-- UI plugins
if nixCats('ui') then
  table.insert(plugin_specs, require('plugins.ui'))
end

-- Git plugins
if nixCats('git') then
  table.insert(plugin_specs, require('plugins.git'))
end

-- Editor plugins
if nixCats('editor') then
  table.insert(plugin_specs, require('plugins.editor'))
end

-- Copilot plugins
if nixCats('copilot') then
  table.insert(plugin_specs, require('plugins.copilot'))
end

-- LSP plugins
if nixCats('lsp') then
  table.insert(plugin_specs, require('plugins.lsp'))
end

-- Treesitter plugins
if nixCats('treesitter') then
  table.insert(plugin_specs, require('plugins.treesitter'))
end

-- Completion plugins
if nixCats('completion') then
  table.insert(plugin_specs, require('plugins.completion'))
end

-- Format plugins
if nixCats('format') then
  table.insert(plugin_specs, require('plugins.format'))
end

-- Debug plugins
if nixCats('debug') then
  table.insert(plugin_specs, require('plugins.debug'))
end

-- Testing plugins
if nixCats('testing') then
  table.insert(plugin_specs, require('plugins.testing'))
end

-- Python plugins
if nixCats('python') then
  table.insert(plugin_specs, require('plugins.python'))
end

-- Utility plugins
if nixCats('utils') then
  table.insert(plugin_specs, require('plugins.utils'))
end

-- Fold plugins
if nixCats('fold') then
  table.insert(plugin_specs, require('plugins.fold'))
end

-- Overseer plugins
if nixCats('overseer') then
  table.insert(plugin_specs, require('plugins.overseer'))
end

-- Neo-tree plugins
if nixCats('neo_tree') then
  table.insert(plugin_specs, require('plugins.neo-tree'))
end

-- Mini plugins
if nixCats('mini') then
  table.insert(plugin_specs, require('plugins.mini'))
end

-- Which-key plugins
if nixCats('which_key') then
  table.insert(plugin_specs, require('plugins.which-key'))
end

-- Todo comments plugins
if nixCats('todo_comments') then
  table.insert(plugin_specs, require('plugins.todo-comments'))
end

-- Flatten the plugin specs
local flattened_specs = {}
for _, spec_group in ipairs(plugin_specs) do
  if type(spec_group) == 'table' then
    for _, spec in ipairs(spec_group) do
      table.insert(flattened_specs, spec)
    end
  end
end

-- Load all plugins with lze
lze.load(flattened_specs)