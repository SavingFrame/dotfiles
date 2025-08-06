-- NOTE: This file uses lzextras.lsp handler https://github.com/BirdeeHub/lzextras?tab=readme-ov-file#lsp-handler
-- This is a slightly more performant fallback function
-- for when you don't provide a filetype to trigger on yourself.
-- nixCats gives us the paths, which is faster than searching the rtp!
local old_ft_fallback = require("lze").h.lsp.get_ft_fallback()
require("lze").h.lsp.set_ft_fallback(function(name)
	local lspcfg = nixCats.pawsible({ "allPlugins", "opt", "nvim-lspconfig" })
		or nixCats.pawsible({ "allPlugins", "start", "nvim-lspconfig" })
	if lspcfg then
		local ok, cfg = pcall(dofile, lspcfg .. "/lsp/" .. name .. ".lua")
		if not ok then
			ok, cfg = pcall(dofile, lspcfg .. "/lua/lspconfig/configs/" .. name .. ".lua")
		end
		return (ok and cfg or {}).filetypes or {}
	else
		return old_ft_fallback(name)
	end
end)

require("lze").load({
	{
		"nvim-lspconfig",
		for_cat = "general",
		on_require = { "lspconfig" },
		-- NOTE: define a function for lsp,
		-- and it will run for all specs with type(plugin.lsp) == table
		-- when their filetype trigger loads them
		lsp = function(plugin)
			vim.lsp.config(plugin.name, plugin.lsp or {})
			vim.lsp.enable(plugin.name)
		end,
		before = function(_)
			vim.lsp.config("*", {
				on_attach = function(_, bufnr)
					-- we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						if desc then
							desc = "LSP: " .. desc
						end
						vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
					end

					map("<leader>cr", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

					map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

					-- Use Snacks picker if available, otherwise fallback to vim.lsp.buf
					if nixCats("general") then
						map("gr", function()
							require("snacks").picker.lsp_references()
						end, "[G]oto [R]eferences")
						map("gi", function()
							require("snacks").picker.lsp_implementations()
						end, "[G]oto [I]mplementation")
						map("<leader>ss", function()
							require("snacks").picker.lsp_symbols()
						end, "Document [S]ymbols")
						map("<leader>sS", function()
							require("snacks").picker.lsp_workspace_symbols()
						end, "Workspace [S]ymbols")
						map("grt", function()
							require("snacks").picker.lsp_type_definitions()
						end, "[G]oto [T]ype Definition")
					else
						map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
						map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
						map("grt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
					end

					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
					map("gK", vim.lsp.buf.signature_help, "Signature Help")

					map("<leader>cd", function()
						vim.diagnostic.open_float(nil, { focusable = true })
					end, "[C]ode [D]iagnostic")

					-- Lesser used LSP functionality
					map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
					map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
					map("<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, "[W]orkspace [L]ist Folders")

					-- Create a command `:Format` local to the LSP buffer
					vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
						vim.lsp.buf.format()
					end, { desc = "Format current buffer with LSP" })

					-- Document highlighting
					local client = vim.lsp.get_client_by_id(vim.lsp.get_clients({ bufnr = bufnr })[1].id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = bufnr,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = bufnr,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- Inlay hints
					if client and client.server_capabilities.inlayHintProvider then
						map("<leader>uh", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
						end, "Toggle Inlay [H]ints")
					end
				end,
			})

			-- Diagnostic Config
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})
		end,
	},
	{
		-- lazydev makes your lsp way better in your config without needing extra lsp configuration.
		"lazydev.nvim",
		for_cat = "general",
		cmd = { "LazyDev" },
		ft = "lua",
		after = function(_)
			require("lazydev").setup({
				library = {
					{ words = { "nixCats" }, path = (nixCats.nixCatsPath or "") .. "/lua" },
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					{ path = "snacks.nvim", words = { "Snacks" } },
				},
			})
		end,
	},
	{
		"fidget.nvim",
		for_cat = "general",
		after = function(_)
			require("fidget").setup({})
		end,
	},
	{
		"rnix",
		-- mason doesn't have nixd
		lsp = {
			filetypes = { "nix" },
		},
	},
	{
		"nil_ls",
		-- mason doesn't have nixd
		lsp = {
			filetypes = { "nix" },
		},
	},
	{
		-- name of the lsp
		"lua_ls",
		lsp = {
			filetypes = { "lua" },
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					formatters = {
						ignoreComments = true,
					},
					signatureHelp = { enabled = true },
					diagnostics = {
						globals = { "nixCats", "vim" },
						disable = { "missing-fields" },
					},
					telemetry = { enabled = false },
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		},
	},
	{
		"gopls",
		for_cat = "general",
		lsp = {
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			settings = {
				gopls = {
					gofumpt = true,
					codelenses = {
						gc_details = false,
						generate = true,
						regenerate_cgo = true,
						run_govulncheck = true,
						test = true,
						tidy = true,
						upgrade_dependency = true,
						vendor = true,
					},
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
					analyses = {
						nilness = true,
						unusedparams = true,
						unusedwrite = true,
						useany = true,
					},
					usePlaceholders = true,
					completeUnimported = true,
					staticcheck = true,
					directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
					semanticTokens = true,
				},
			},
		},
	},
	{
		"basedpyright",
		for_cat = "general",
		lsp = {
			filetypes = { "python" },
			disableOrganizeImports = true,
			settings = {
				basedpyright = {
					analysis = {
						diagnosticMode = "openFilesOnly",
						typeCheckingMode = "basic",
						useLibraryCodeForTypes = true,
						diagnosticSeverityOverrides = {
							reportAssignmentType = "warning",
						},
					},
				},
			},
		},
		after = function(_)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("basedpyright-lsp-attach", { clear = false }),
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.name == "basedpyright" then
						client.server_capabilities.workspaceSymbolProvider = false
						client.server_capabilities.declarationProvider = false
					end
				end,
			})
		end,
	},
	{
		"ruff",
		for_cat = "general",
		lsp = {
			filetypes = { "python" },
			capabilities = {
				hoverProvider = false,
			},
		},
	},
	-- {
	--   "snakelsp",
	--   enabled = false, -- Disabled since it's not in nixCats setup
	--   lsp = {
	--     filetypes = { "python" },
	--     cmd = { 'snakelsp' },
	--     capabilities = {
	--       textDocument = {
	--         documentSymbol = vim.NIL,
	--       },
	--     },
	--     root_markers = {
	--       'pyproject.toml',
	--       'setup.py',
	--       'setup.cfg',
	--       'requirements.txt',
	--       'Pipfile',
	--       'pyrightconfig.json',
	--       '.git',
	--       '.venv',
	--     },
	--     init_options = {
	--       virtualenv_path = os.getenv 'VIRTUAL_ENV',
	--     },
	--   },
	-- },
	{
		"jsonls",
		for_cat = "general",
		lsp = {
			filetypes = { "json", "jsonc" },
			settings = {
				json = {
					schemas = nixCats("general")
							and pcall(require, "schemastore")
							and require("schemastore").json.schemas()
						or {},
					validate = { enable = true },
					format = {
						enable = true,
					},
				},
			},
		},
	},
	{
		"dockerls",
		for_cat = "general",
		lsp = {
			filetypes = { "dockerfile" },
		},
	},
	{
		"docker_compose_language_service",
		for_cat = "general",
		lsp = {
			filetypes = { "yaml.docker-compose" },
		},
	},
	{
		"templ",
		for_cat = "general",
		lsp = {
			filetypes = { "templ" },
		},
	},
	{
		"nixd",
		lsp = {
			filetypes = { "nix" },
			settings = {
				nixd = {
					-- nixd requires some configuration.
					-- luckily, the nixCats plugin is here to pass whatever we need!
					-- we passed this in via the `extra` table in our packageDefinitions
					-- for additional configuration options, refer to:
					-- https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
					nixpkgs = {
						-- in the extras set of your package definition:
						-- nixdExtras.nixpkgs = ''import ${pkgs.path} {}''
						expr = nixCats.extra("nixdExtras.nixpkgs") or [[import <nixpkgs> {}]],
					},
					options = {
						-- If you integrated with your system flake,
						-- you should use inputs.self as the path to your system flake
						-- that way it will ALWAYS work, regardless
						-- of where your config actually was.
						nixos = {
							-- nixdExtras.nixos_options = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").nixosConfigurations.configname.options''
							expr = nixCats.extra("nixdExtras.nixos_options"),
						},
						-- If you have your config as a separate flake, inputs.self would be referring to the wrong flake.
						-- You can override the correct one into your package definition on import in your main configuration,
						-- or just put an absolute path to where it usually is and accept the impurity.
						["home-manager"] = {
							-- nixdExtras.home_manager_options = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").homeConfigurations.configname.options''
							expr = nixCats.extra("nixdExtras.home_manager_options"),
						},
					},
					formatting = {
						command = { "nixfmt" },
					},
					diagnostic = {
						suppress = {
							"sema-escaping-with",
						},
					},
				},
			},
		},
	},
})
