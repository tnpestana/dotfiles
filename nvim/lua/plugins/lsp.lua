-- lua/plugins/lsp.lua
return {
  -- 1) LSP core
  { "neovim/nvim-lspconfig" },

  -- 2) Installer for LSP servers
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- 3) LSP configuration (manual setup, no auto-start)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      local on_attach = function(_, bufnr)
        local keymaps = require('core.keymaps')
        keymaps.setup_lsp_keymaps(bufnr)
      end

      vim.lsp.config('pyright', {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      vim.lsp.config('jsonls', {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            validate = { enable = true },
          },
        },
      })

      vim.lsp.config('lua_ls', {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim", "love" },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
              },
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.lsp.enable({ "pyright", "jsonls", "lua_ls" })
    end,
  },
}
