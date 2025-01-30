return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        formatters = {
          file = {
            truncate = 120,
          },
        },
        previewers = {
          git = {
            native = true,
          },
        },
      },
    },
    keys = {
      {
        "<leader>ff",
        function()
          Snacks.picker.files({
            finder = "files",
            format = "file",
            hidden = true,
            ignored = true,
            follow = false,
            supports_live = true,
            -- debug = false,
          })
        end,
        desc = "Find Files (Root Dir)",
      },
    },
  },
}
