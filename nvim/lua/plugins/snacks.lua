local M = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  config = function ()
    require('snacks').setup {
      dashboard = { enabled = true },
      indent = { enabled = true },
      lazygit = {
        enabled = true,
        configure = true,
      },
    }

    vim.keymap.set('n', '<leader>g', Snacks.lazygit.open, { desc = "Open Lazy[G]it" })
  end
}

return M
