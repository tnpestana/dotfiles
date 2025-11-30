return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()

    local keymaps = require('core.keymaps')
    keymaps.setup_gitsigns_keymaps()
  end
}
