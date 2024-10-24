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
}

return M
