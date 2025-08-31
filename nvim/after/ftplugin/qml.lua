vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.qml'},
  group = vim.api.nvim_create_augroup('rkest-qml-fmt', { clear = true }),
  callback = function()
      vim.cmd 'silent !qmlformat -i %'
  end,
})
