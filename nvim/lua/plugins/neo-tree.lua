return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>fV",
      function()
        local site_packages_path = require("utils.path").get_venv_site_packages_path()
        if site_packages_path then
          require("neo-tree.command").execute({
            toggle = true,
            dir = site_packages_path,
            filters = {
              hide_dotfiles = false, -- Ensure dotfiles are shown
              hide_gitignored = false,
              hide_by_pattern = { "__pycache__/", "%.so", "%.dist-info/", "*.egg-info/", "*.pyc", "*dist-info/" },
            },
          })
        end
      end,
      desc = "Explorer NeoTree (Libraries)",
    },
  },
  opts = {
    filesystem = {
      components = {
        harpoon_index = function(config, node, _)
          local harpoon_list = require("harpoon"):list()
          local path = node:get_id()
          local harpoon_key = vim.uv.cwd()

          for i, item in ipairs(harpoon_list.items) do
            local value = item.value
            if string.sub(item.value, 1, 1) ~= "/" then
              value = harpoon_key .. "/" .. item.value
            end

            if value == path then
              return {
                text = string.format(" ⥤ %d", i), -- <-- Add your favorite harpoon like arrow here
                -- text = "⥤",
                highlight = config.highlight or "NeoTreeDirectoryIcon",
              }
            end
          end
          return {}
        end,
      },
      renderers = {
        file = {
          { "icon" },
          { "name", use_git_status_colors = true },
          { "harpoon_index" }, --> This is what actually adds the component in where you want it
          { "diagnostics" },
          { "git_status", highlight = "NeoTreeDimText" },
        },
      },
      window = {
        mappings = {
          -- disable fuzzy finder
          ["/"] = "noop",
          ["f"] = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require("telescope.builtin").find_files(require("utils.path").getTelescopeOpts(state, path))
          end,
          ["g"] = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require("fzf-lua").live_grep(require("utils.path").getFzfOpts(state, path))
            -- require("telescope.builtin").live_grep(require("utils.path").getTelescopeOpts(state, path))
          end,
          ["Y"] = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify

            local vals = {
              ["FILENAME"] = filename,
              ["PATH (CWD)"] = modify(filepath, ":."),
              ["BASENAME"] = modify(filename, ":r"),
              ["EXTENSION"] = modify(filename, ":e"),
              ["PATH (HOME)"] = modify(filepath, ":~"),
              ["PATH"] = filepath,
              ["URI"] = vim.uri_from_fname(filepath),
            }

            local options = vim.tbl_filter(function(val)
              return vals[val] ~= ""
            end, vim.tbl_keys(vals))
            if vim.tbl_isempty(options) then
              vim.notify("No values to copy", vim.log.levels.WARN)
              return
            end
            table.sort(options)
            vim.ui.select(options, {
              prompt = "Choose to copy to clipboard:",
              format_item = function(item)
                return ("%s: %s"):format(item, vals[item])
              end,
            }, function(choice)
              local result = vals[choice]
              if result then
                vim.notify(("Copied: `%s`"):format(result))
                vim.fn.setreg("+", result)
              end
            end)
          end,
        },
      },
    },
  },
}
