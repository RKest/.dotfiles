return {
  'yashguptaz/calvera-dark.nvim',
  config = function ()
    vim.g.calvera_italic_keywords = false
    vim.g.calvera_borders = true
    vim.g.calvera_contrast = true
    vim.g.calvera_hide_eob = true
    -- vim.g.calvera_custom_colors = {contrast = "#0f111a"}

    require('calvera').set()
  end
-- -- Required Setting
-- require('calvera').set()
--   'EdenEast/nightfox.nvim',
--   config = function()
--     require('nightfox').setup {
--       options = {
--         transparent = true,
--         terminal_colors = true,
--       }
--     }
--   end,
}
