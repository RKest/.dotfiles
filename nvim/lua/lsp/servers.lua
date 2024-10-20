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
}

return M
