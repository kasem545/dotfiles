return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "black",
        "isort",
        "prettier",
        "stylua",
        "shfmt",
        "clang-format",
        "google-java-format",
        "csharpier",
        "php-cs-fixer",
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 5,
    })
  end,
}
