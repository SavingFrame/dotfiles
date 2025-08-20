-- Mini plugins configuration for lze
return { -- Collection of various small independent plugins/modules
	{
		"mini.nvim",
		-- keys = {
		-- 	{ "gsa", desc = "Add Surrounding", mode = { "n", "v" } },
		-- 	{ "gsd", desc = "Delete Surrounding" },
		-- 	{ "gsf", desc = "Find Right Surrounding" },
		-- 	{ "gsF", desc = "Find Left Surrounding" },
		-- 	{ "gsh", desc = "Highlight Surrounding" },
		-- 	{ "gsr", desc = "Replace Surrounding" },
		-- 	{ "gsn", desc = "Update `MiniSurround.config.n_lines`" },
		-- },
		-- keys = function(_, keys)
		-- 	-- Populate the keys based on the user's options
		-- 	local mappings = {
		-- 		{ "gas", desc = "Add Surrounding", mode = { "n", "v" } },
		-- 		{ "gsd", desc = "Delete Surrounding" },
		-- 		{ "gsf", desc = "Find Right Surrounding" },
		-- 		{ "gsF", desc = "Find Left Surrounding" },
		-- 		{ "gsh", desc = "Highlight Surrounding" },
		-- 		{ "gsr", desc = "Replace Surrounding" },
		-- 		{ "gsn", desc = "Update `MiniSurround.config.n_lines`" },
		-- 	}
		-- 	mappings = vim.tbl_filter(function(m)
		-- 		return m[1] and #m[1] > 0
		-- 	end, mappings)
		-- 	return vim.list_extend(mappings, keys)
		-- end,
		after = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			local ai = require("mini.ai")
			ai.setup({
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({ -- code block
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
				},
			})

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup({

				mappings = {
					add = "gsa", -- Add surrounding in Normal and Visual modes
					delete = "gsd", -- Delete surrounding
					find = "gsf", -- Find surrounding (to the right)
					find_left = "gsF", -- Find surrounding (to the left)
					highlight = "gsh", -- Highlight surrounding
					replace = "gsr", -- Replace surrounding
					update_n_lines = "gsn", -- Update `n_lines`
				},
			})

			require("mini.pairs").setup({
				-- skip autopair when next character is one of these
				skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
				-- skip autopair when the cursor is inside these treesitter nodes
				skip_ts = { "string" },
				-- and there are more closing pairs than opening pairs
				skip_unbalanced = true,
				-- better deal with markdown code blocks
				markdown = true,
			})
			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			-- local statusline = require 'mini.statusline'
			-- set use_icons to true if you have a Nerd Font
			-- statusline.setup { use_icons = vim.g.have_nerd_font }

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			-- ---@diagnostic disable-next-line: duplicate-set-field
			-- statusline.section_location = function()
			--   return '%2l:%-2v'
			-- end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
}
