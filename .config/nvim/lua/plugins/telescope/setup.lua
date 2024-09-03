local M = { -- :help telescope.setup()
  defaults = {
    file_ignore_patterns = { 'node_modules', 'venv', 'build' },
    mappings = {
      i = {
        ['<C-Down>'] = require('telescope.actions').cycle_history_next,
        ['<C-Up>'] = require('telescope.actions').cycle_history_prev,
      },
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}
return M
