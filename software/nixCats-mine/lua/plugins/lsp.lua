-- LSP configuration for lze
return {
  {
    'lazydev.nvim',
    ft = 'lua',
    after = function()
      require
      library = {
        { path = 'library', words = { 'vim%.uv' }       })
    end,
        { path = 'snacks.nvim', words = { 'Snacks' }       })
    end,
            })
    end,
          })
    end,
        })
    end,
  {
    'fidget.nvim',
    after = function()
      require      })
    end,
        })
    end,
  {
    'nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile'       })
    end,
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('<leader>cr', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          map('gr', function()
            Snacks.picker.lsp_references()
          end, '[G]oto [R]eferences')

          map('gi', function()
            Snacks.picker.lsp_implementations()
          end, '[G]oto [I]mplementation')

          map('gd', function()
            Snacks.picker.lsp_definitions()
          end, '[G]oto [D]efinition')

          map('<leader>ss', function()
            Snacks.picker.lsp_symbols()
          end, 'Open Document Symbols')

          map('<leader>sS', function()
            Snacks.picker.lsp_workspace_symbols()
          end, 'Open Workspace Symbols')

          map('grt', function()
            Snacks.picker.lsp_type_definitions()
          end, '[G]oto [T]ype Definition')

          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          map('<leader>cd', function()
            vim.diagnostic.open_float(nil, { focusable = true })
          end, '[C]ode [D]iagnostic')
          
          map('gK', function()
            return vim.lsp.buf.signature_help()
          end, 'Signature Help')

          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>uh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many'       })
    end,
        underline = { severity = vim.diagnostic.severity.ERROR       })
    end,
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
                })
    end,
        } or {      })
    end,
        virtual_text = {
          source = 'if_many',
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
              })
    end,
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        gopls = {
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
                    })
    end,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
                    })
    end,
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
                    })
    end,
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules'       })
    end,
              semanticTokens = true,
                  })
    end,
                })
    end,
              })
    end,
        basedpyright = {
          disableOrganizeImports = true,
          settings = {
            basedpyright = {
              analysis = {
                diagnosticMode = 'openFilesOnly',
                typeCheckingMode = 'basic',
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                  reportAssignmentType = 'warning',
                      })
    end,
                    })
    end,
                  })
    end,
                })
    end,
              })
    end,
        ruff = {
          capabilities = {
            hoverProvider = false,
                })
    end,
              })
    end,
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true       })
    end,
              format = {
                enable = true,
                    })
    end,
                  })
    end,
                })
    end,
              })
    end,
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
                    })
    end,
                  })
    end,
                })
    end,
              })
    end,
        dockerls = {      })
    end,
        docker_compose_language_service = {      })
    end,
        templ = {      })
    end,
      }

      -- Configure all available servers
      for server_name, config in pairs(servers) do
        vim.lsp.config(server_name, config)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = false }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == 'basedpyright' then
            client.server_capabilities.workspaceSymbolProvider = false
            client.server_capabilities.declarationProvider = false
          end
        end,
      })
    end,
        })
    end,
}
