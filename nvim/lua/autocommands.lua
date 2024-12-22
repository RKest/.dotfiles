-- Hightlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('rkest-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.c', '*.cpp' },
  group = vim.api.nvim_create_augroup('rkest-set-makeprg-c', { clear = true }),
  callback = function()
    vim.bo.makeprg = 'cmake --build build -j`nproc`'
    vim.bo.errorformat = '%f:%l:%c: error: %m'
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.odin' },
  group = vim.api.nvim_create_augroup('rkest-set-makeprg-rs', { clear = true }),
  callback = function()
    vim.bo.makeprg = './check'
    vim.bo.errorformat = '%f(%l:%c) Error: %m'
  end,
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = { 'make' },
  group = vim.api.nvim_create_augroup('rkest-post-make', { clear = true }),
  callback = function()
    for _, win in ipairs(vim.fn.getqflist()) do
      if win.valid == 1 then
        vim.cmd 'copen'
        return
      end
    end
    vim.cmd 'cclose'
  end,
})

vim.keymap.set('n', '<leader>m', '<cmd>make<CR>', { desc = 'Silent [M]ake' })
vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>', { desc = '[N]ext quickfix list entry' })
vim.keymap.set('n', '<C-p>', '<cmd>cprev<CR>', { desc = '[P]revious quickfix list entry' })
vim.keymap.set('n', '<C-c>', '<cmd>cclose<CR>', { desc = '[C]lose quickfix list' })

vim.api.nvim_create_autocmd("FileType", {
  pattern =  "*.hs" ,
  callback = function()
    vim.bo.expandtab = true     -- Convert tabs to spaces
    vim.bo.tabstop = 4          -- Number of spaces for a tab
    vim.bo.shiftwidth = 4       -- Number of spaces for indentation
    vim.bo.softtabstop = 2      -- Number of spaces for a tab in insert mode
  end,
})
