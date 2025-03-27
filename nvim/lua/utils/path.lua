local M = {}

--- Get the 'site-packages' path of the currently activated virtual environment.
-- @return string|nil: The 'site-packages' path if found, or nil if not found.
function M.get_venv_site_packages_path()
  -- Get the path to the virtual environment
  local env_path = os.getenv("VIRTUAL_ENV")
  if not env_path then
    print("VIRTUAL_ENV is not set.")
    return nil
  end

  -- The lib directory contains Python version folders
  local lib_path = env_path .. "/lib"

  -- Find the pythonX.Y folder (like python3.11)
  local python_version_folder = nil
  for folder in io.popen('ls "' .. lib_path .. '"'):lines() do
    if folder:match("^python%d+%.%d+$") then
      python_version_folder = folder
      break
    end
  end

  -- If we found the python version folder, return the path to site-packages
  if python_version_folder then
    return lib_path .. "/" .. python_version_folder .. "/site-packages"
  else
    print("Could not find a Python version folder inside: " .. lib_path)
    return nil
  end
end

function M.getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    no_ignore = true,
    hidden = true,
    additional_args = { "--hidden", "--no-ignore" },
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        -- any way to open the file without triggering auto-close event of neo-tree?
        require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
      end)
      return true
    end,
  }
end

function M.getFzfOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    additional_args = { "--hidden", "--no-ignore" },
    rg_opts = "--no-ignore-parent --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
  }
end
return M
