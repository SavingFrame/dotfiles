-- LSP Configuration
-- Handles LSP servers, diagnostics, and LSP-related functionality

if nixCats('lsp') then
  vim.cmd('packadd fidget-nvim')
  vim.cmd('packadd nvim-navic')
end

-- Fidget configuration for LSP progress
if nixCats('lsp') then
  require('fidget').setup {}
end

-- Navic configuration for breadcrumbs
if nixCats('lsp') then
  require('nvim-navic').setup {
    lsp = {
      auto_attach = true,
      preference = { 'clangd', 'basedpyright', 'tsserver' },
    },
    highlight = true,
    separator = ' > ',
    depth_limit = 0,
    depth_limit_indicator = '..',
  }
end

-- LSP configuration
if nixCats('lsp') then
  -- LSP attach autocommand
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('nixcats-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- LSP keymaps
      map('<leader>cr', vim.lsp.buf.rename, '[R]e[n]ame')
      map('<leader>ca', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

      -- Use Snacks picker for LSP navigation if available
      if nixCats('ui') then
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
      else
        -- Fallback to built-in LSP functions
        map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
        map('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        map('grt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
      end

      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      map('<leader>cd', function()
        vim.diagnostic.open_float(nil, { focusable = true })
      end, '[C]ode [D]iagnostic')

      map('gK', function()
        return vim.lsp.buf.signature_help()
      end, 'Signature Help')

      -- Helper function for client method support
      local function client_supports_method(client, method, bufnr)
        if vim.fn.has 'nvim-0.11' == 1 then
          return client:supports_method(method, bufnr)
        else
          return client.supports_method(method, { bufnr = bufnr })
        end
      end

      -- Document highlighting
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('nixcats-lsp-highlight', { clear = false })
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
          group = vim.api.nvim_create_augroup('nixcats-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'nixcats-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- Inlay hints toggle
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map('<leader>uh', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, 'Toggle Inlay [H]ints')
      end
    end,
  })

  -- Diagnostic configuration
  vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    } or {},
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
    },
  }

  -- Get capabilities from blink.cmp
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  -- LSP server configurations
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
          directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
          semanticTokens = true,
        },
      },
    },
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
            },
          },
        },
      },
    },
    ruff = {
      capabilities = {
        hoverProvider = false,
      },
    },
    jsonls = {
      settings = {
        json = {
          schemas = nixCats('python') and require('schemastore').json.schemas() or {},
          validate = { enable = true },
          format = {
            enable = true,
          },
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    },
    dockerls = {},
    docker_compose_language_service = {},
    templ = {},
  }

  -- Configure LSP servers
  for server_name, config in pairs(servers) do
    -- Only configure if the server is available via nixCats
    if nixCats('go') and server_name == 'gopls' then
      config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
      vim.lsp.config(server_name, config)
    elseif nixCats('python') and (server_name == 'basedpyright' or server_name == 'ruff') then
      config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
      vim.lsp.config(server_name, config)
    elseif nixCats('json') and server_name == 'jsonls' then
      config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
      vim.lsp.config(server_name, config)
    elseif nixCats('nix') and server_name == 'lua_ls' then
      config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
      vim.lsp.config(server_name, config)
    elseif nixCats('docker') and (server_name == 'dockerls' or server_name == 'docker_compose_language_service') then
      config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
      vim.lsp.config(server_name, config)
    elseif server_name == 'templ' then
      config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
      vim.lsp.config(server_name, config)
    end
  end

  -- Special handling for basedpyright
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('nixcats-lsp-attach', { clear = false }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.name == 'basedpyright' then
        client.server_capabilities.workspaceSymbolProvider = false
        client.server_capabilities.declarationProvider = false
      end
    end,
  })
end
