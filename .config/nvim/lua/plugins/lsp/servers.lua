local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local M = { -- clangd = {},
  pyright = require 'plugins.lsp.servers.pyright',
  clangd = {
    cmd = { '/sbin/clangd' },
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

  ocamllsp = {
    capabilities = capabilities,
    on_attach = function(_, bufnr)
      local settings = {
        codelens = { enable = true },
        inlayHints = { enable = true },
      }
      vim.lsp.buf_notify(bufnr, vim.lsp.protocol.Methods.workspace_didChangeConfiguration, {
        settings = settings,
      })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'CursorHold' }, {
        group = vim.api.nvim_create_augroup('LSPCodeLens', { clear = true }),
        callback = function()
          vim.lsp.codelens.refresh()
        end,
        buffer = bufnr,
      })
    end,
  },

  -- svelte = {
  --   filetypes = { 'typescript', 'javascript', 'svelte', 'html', 'css' },
  -- },
}

return M
