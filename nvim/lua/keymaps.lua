-- Hightlight search
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Moving cursor
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Execute lua line
vim.keymap.set('n', '<leader>x', ":.lua<CR>", { desc = 'E[x]ecute lua code under cursor' })
vim.keymap.set('v', '<leader>x', ":lua<CR>", { desc = 'E[x]ecute lua code under visual selection' })

-- Buffers
vim.keymap.set({'n', 'v', 't'}, '<tab>', '<cmd>:bnext<CR>')
vim.keymap.set({'n', 'v', 't'}, '<S-tab>', '<cmd>:bprev<CR>')

-- Cd
vim.keymap.set('n', '<leader>.', function ()
  vim.cmd 'silent cd %:h'
  vim.notify(vim.fn.getcwd())
end, { desc = 'Change directory to the current file' });
vim.keymap.set('n', '<leader>-', function ()
  vim.cmd 'silent cd ..'
  vim.notify(vim.fn.getcwd())
end, { desc = 'Change directory to the current file' });

-- Duplicate line
vim.keymap.set('n', '<C-d>',
  function ()
    local line_num = vim.fn.line('.')
    local col_num = vim.fn.col('.')
    local current_line = vim.fn.getline(line_num)
    vim.fn.append(line_num, current_line)
    vim.api.nvim_win_set_cursor(0, { line_num + 1, col_num - 1 })
  end, { desc = '[D]uplicate line' }
)
