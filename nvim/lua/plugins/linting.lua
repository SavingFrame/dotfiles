return {
  "mfussenegger/nvim-lint",
  opts = {
    events = { "BufWritePost", "BufReadPost" },
    linters_by_ft = {
      -- python = { "flake8", "mypy" },
      python = { "dmypy" },
    },
  },
}
-- {
--   "nvimtools/none-ls.nvim",
--   optional = true,
--   opts = function(_, opts)
--     local nls = require("null-ls")
--     opts.sources = opts.sources or {}
--     table.insert(opts.sources, nls.builtins.formatting.black)
--     table.insert(
--       opts.sources,
--       nls.builtins.diagnostics.mypy.with({
--         -- just default mypy without daemon
--         prefer_local = ".venv/bin",
--         extra_args = function(params)
--           local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
--           local args = {
--             "--ignore-missing-import",
--             "--python-executable",
--             virtual .. "/bin/python3",
--           }
--           return args
--         end,
--         diagnostics_postprocess = function(diagnostic)
--           diagnostic.severity = vim.diagnostic.severity.WARN
--         end,
--         -- Do not run in fugitive windows, or when inside of a .venv area
--         runtime_condition = function(params)
--           if string.find(params.bufname, "lazygit") or string.find(params.bufname, ".venv") then
--             return false
--           else
--             return true
--           end
--         end,
--       })
--     )
--   end,
-- },
