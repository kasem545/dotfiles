return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    
    conform.setup({
      formatters_by_ft = {
        python = { "isort", "black" },
        php = { "php_cs_fixer" },
        bash = { "shfmt" },
        html = { "prettier" },
        css = { "prettier" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        cs = { "csharpier" },
        java = { "google-java-format" },
        javascript = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
    })
    
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
