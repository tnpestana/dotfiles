return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local keymaps = require('core.keymaps')
    keymaps.setup_telescope_keymaps()
  end,
}