return {
  { "lukas-reineke/cmp-under-comparator" },
  {
    -- "iguanacucumber/magazine.nvim",
    "hrsh7th/nvim-cmp",
    dependencies = {
      "lukas-reineke/cmp-under-comparator",
    },
    name = "nvim-cmp", -- Otherwise highlighting gets messed up
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.performance = {

        ce = 0, -- default is 60ms
        throttle = 0, -- default is 30ms
      }
      opts.sorting = {
        priority_weight = 1,
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,

          -- copied from cmp-under, but I don't think I need the plugin for this.
          -- I might add some more of my own.
          function(entry1, entry2)
            local _, entry1_under = entry1.completion_item.label:find("^_+")
            local _, entry2_under = entry2.completion_item.label:find("^_+")
            entry1_under = entry1_under or 0
            entry2_under = entry2_under or 0

            if entry1_under > entry2_under then
              return false
            elseif entry1_under < entry2_under then
              return true
            end
          end,
          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
          -- cmp.config.compare.sort_text,
          -- cmp.config.compare.length,
          -- cmp.config.compare.order,
        },
      }
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        signature = {
          enabled = false,
        },
      },
    },
  },
}
