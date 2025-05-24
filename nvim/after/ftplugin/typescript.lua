vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.tsx', '*ts' },
  group = vim.api.nvim_create_augroup('rkest-typescript-fmt', { clear = true }),
  callback = function()
      vim.cmd 'silent !prettier --write %'
  end,
})
