local M = { -- clangd = {},
  pyright = require 'plugins.lsp.servers.pyright',
  clangd = {
    on_attach = function()
      vim.keymap.set('n', '<C-S>', function()
        vim.cmd 'ClangdSwitchSourceHeader'
      end, { desc = 'Switch header/[S]ource file' })
    end,
  },
  gopls = {
    on_attach = function()
      -- Automatically organize imports on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        callback = function()
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { 'source.organizeImports' } }
          local timeout_ms = 1000
          local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, timeout_ms)
          for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
              if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
              end
            end
          end
          vim.lsp.buf.format { async = false }
        end,
      })
    end,
  },

  lua_ls = {
    -- cmd = {...},
    -- filetypes = { ...},
    -- capabilities = {},
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
}

return M
