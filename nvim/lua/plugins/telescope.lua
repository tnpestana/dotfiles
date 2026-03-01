return {
  'nvim-telescope/telescope.nvim',
  version = '0.2.1',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local keymaps = require('core.keymaps')
    keymaps.setup_telescope_keymaps()
  end,
}