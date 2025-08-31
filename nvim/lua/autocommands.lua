-- Hightlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('rkest-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern =  { "lua" },
  callback = function()
    vim.bo.tabstop = 2          -- Number of spaces for a tab
    vim.bo.shiftwidth = 2       -- Number of spaces for indentation
  end,
})
