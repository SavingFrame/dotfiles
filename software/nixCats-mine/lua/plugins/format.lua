-- Format plugins configuration for lze
return {
  {
    'conform.nvim',
    event = { 'BufWritePre'       })
    end,
    cmd = { 'ConformInfo'       })
    end,
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[C]ode [F]ormat',
            })
    end,
          })
    end,
    after = function()
      require
      notify_on_error = true,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua'       })
    end,
        python = { 'ruff_fix', 'ruff_format'       })
    end,
        html = { 'prettier'       })
    end,
            })
    end,
          })
    end,
        })
    end,
}