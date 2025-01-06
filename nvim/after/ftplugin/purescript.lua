
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.purs' },
  group = vim.api.nvim_create_augroup('rkest-purs-fmt', { clear = true }),
  callback = function()
      vim.cmd 'silent !purs-tidy format-in-place "%"'
  end,
})
