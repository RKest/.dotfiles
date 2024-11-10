local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local M = {
  clangd = {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "h", "hpp", "cuda" },
  },
  nixd = {
    cmd = { "nixd" },
    filetypes = { "nix" },
    settings = {
      nixd = {
        options = {
          ['home-manager'] = {
            expr = [[(builtins.getFlake "/home/max/.dotfiles/home").homeConfigurations."max".options]]
          }
        }
      },
    },
  },
  neocmake = {
    cmd = { "neocmakelsp", "--stdio" },
    filetypes = { "cmake", "txt" },
    capabilites = capabilities,
  },
  clojure_lsp = {
    filetyes = { "clj", "clojure", "edn" },
  },
  phpactor = {
    init_options = {
    }
  },
  emmet_language_server = {
    filetypes = { "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "typescriptreact", "htmlangular", "php"}
  },
  gopls = {
    autostart = true,
  },
  basedpyright = {
    cmd = { "basedpyright-langserver", "--stdio", "--pythonpath", "/home/max/.nix-profile/bin/python3" },
  },
  ts_ls = {},

  ocamllsp = {
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
  svelte = {}
}

return M
