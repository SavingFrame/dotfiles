return {
  "sindrets/diffview.nvim",
  keys = function()
    local function toggleDiffView(cmd)
      -- Import the diffview library
      local views = require("diffview.lib").views
      -- Toggle between open and close based on the current state
      if next(views) == nil then
        vim.cmd(cmd .. " --imply-local")
      else
        vim.cmd("DiffviewClose")
      end
    end

    -- Return the key mappings to be configured by LazyVim
    return {
      {
        "<leader>gdd",
        function()
          toggleDiffView("DiffviewOpen")
        end,
        desc = "Toggle Diff view",
      },
      {
        "<leader>gdD",
        function()
          toggleDiffView("DiffviewOpen -- %")
        end,
        desc = "Toggle Diff view for current file",
      },
      {
        "<leader>gdf",
        function()
          toggleDiffView("DiffviewFileHistory %")
        end,
        desc = "File history",
      },
    }
  end,
}
