return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = { "__pycache__/", "%.so", "%.dist-info/", "*.egg-info/", "*.pyc", "*dist-info/" },
      },
    },
    keys = {
      { "<leader><leader>", false },
      { "<leader>ff", LazyVim.pick("files", { no_ignore = true, hidden = true }), desc = "Find Files (Root Dir)" },
      {
        "<leader>fv",
        function()
          local site_packages_path = require("utils.path").get_venv_site_packages_path()
          print(site_packages_path)
          if site_packages_path then
            require("telescope.builtin").find_files({
              cwd = site_packages_path, -- Limit the search to site-packages
              -- hidden = true,
              no_ignore = true,
              file_ignore_patterns = { "__pycache__/", "%.so", "%.dist-info/", "*.egg-info/", "*.pyc", "*dist-info/" },
            })
          end
        end,
        desc = "Find in VirtualEnv",
      },
    },
  },
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function()
      require("telescope").load_extension("smart_open")
    end,
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
    keys = {
      {
        "<leader><leader>",
        function()
          require("telescope").extensions.smart_open.smart_open()
        end,
      },
    },
  },
}