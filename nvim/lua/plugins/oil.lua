local M = {
  'stevearc/oil.nvim',
  config = function ()
    vim.keymap.set('n', '<leader>o', '<cmd>Oil<cr>', { desc = 'Open [O]il' })
    require 'oil'.setup {
      default_file_explorer = true,
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime"
      },
      preview_win = {
        update_on_cursor_moved = true
      },
      keymaps = {
        ["gh"] = "actions.toggle_hidden",
        ["g."] = "actions.cd",
      },
    }
  end,
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
}

return M
