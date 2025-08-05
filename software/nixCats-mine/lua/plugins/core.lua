-- Core plugins that are always loaded
-- These are loaded at startup and don't need lze

-- Guess indent
if nixCats('general') then
  require('guess-indent').setup({})
end