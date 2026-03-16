return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "intelephense",
          "bashls",
          "html",
          "cssls",
          "clangd",
          "csharp_ls",
          "jdtls",
          "ts_ls",
          "yamlls",
          "marksman",
          "jsonls",
          "lua_ls",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local deprecate = vim.deprecate
      vim.deprecate = function() end
      
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      
      local keymap = vim.keymap
      
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          
          opts.desc = "Show LSP references"
          keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
          
          opts.desc = "Go to declaration"
          keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          
          opts.desc = "Show LSP definitions"
          keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
          
          opts.desc = "Show LSP implementations"
          keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
          
          opts.desc = "Show LSP type definitions"
          keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
          
          opts.desc = "See available code actions"
          keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          
          opts.desc = "Smart rename"
          keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          
          opts.desc = "Show buffer diagnostics"
          keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
          
          opts.desc = "Show line diagnostics"
          keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
          
          opts.desc = "Go to previous diagnostic"
          keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          
          opts.desc = "Go to next diagnostic"
          keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          
          opts.desc = "Show documentation for what is under cursor"
          keymap.set("n", "K", vim.lsp.buf.hover, opts)
          
          opts.desc = "Restart LSP"
          keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
        end,
      })
      
      local capabilities = cmp_nvim_lsp.default_capabilities()
      
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })
      
      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
      
      lspconfig.intelephense.setup({
        capabilities = capabilities,
      })
      
      lspconfig.bashls.setup({
        capabilities = capabilities,
      })
      
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })
      
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })
      
      lspconfig.csharp_ls.setup({
        capabilities = capabilities,
      })
      
      lspconfig.jdtls.setup({
        capabilities = capabilities,
      })
      
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      
      lspconfig.yamlls.setup({
        capabilities = capabilities,
      })
      
      lspconfig.marksman.setup({
        capabilities = capabilities,
      })
      
      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })
      
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })
      
      if vim.fn.executable("ltex-ls") == 1 then
        lspconfig.ltex.setup({
          capabilities = capabilities,
          filetypes = {
            "python",
            "php",
            "bash",
            "html",
            "css",
            "c",
            "cpp",
            "cs",
            "java",
            "javascript",
            "yaml",
            "markdown",
            "json",
            "lua",
            "text",
            "tex",
          },
          on_attach = function(client, bufnr)
            require("ltex_extra").setup({
              load_langs = { "en-US" },
              init_check = true,
              path = vim.fn.stdpath("data") .. "/ltex",
              log_level = "none",
            })
          end,
          settings = {
            ltex = {
              language = "en-US",
              additionalRules = {
                enablePickyRules = true,
                motherTongue = "en-US",
              },
            },
          },
        })
      end
      
      vim.deprecate = deprecate
    end,
  },
}
