-- Git plugins configuration for lze
return {
	{
		"gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		after = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]h", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, { desc = "Jump to next git [c]hange" })

					map("n", "[h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[h", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, { desc = "Jump to previous git [c]hange" })

					-- Actions
					-- visual mode
					map("v", "<leader>ghs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "git [s]tage hunk" })
					map("v", "<leader>ghr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "git [r]eset hunk" })
					-- normal mode
					map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
					map("n", "<leader>ghu", gitsigns.stage_hunk, { desc = "git [u]ndo stage hunk" })
					map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
					map("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
					-- Toggles
				end,
			})
		end,
	},
	{
		"diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		keys = { "<leader>gdd", "<leader>gdD", "<leader>gdf" },
		after = function()
			local function toggleDiffView(cmd)
				local views = require("diffview.lib").views
				if next(views) == nil then
					vim.cmd(cmd .. " --imply-local")
				else
					vim.cmd("DiffviewClose")
				end
			end

			vim.keymap.set("n", "<leader>gdd", function()
				toggleDiffView("DiffviewOpen")
			end, { desc = "Toggle Diff view" })

			vim.keymap.set("n", "<leader>gdD", function()
				toggleDiffView("DiffviewOpen -- %")
			end, { desc = "Toggle Diff view for current file" })

			vim.keymap.set("n", "<leader>gdf", function()
				toggleDiffView("DiffviewFileHistory %")
			end, { desc = "File history" })
		end,
	},
}

