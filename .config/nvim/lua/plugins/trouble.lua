return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  config = function()
    require("trouble").setup({
      position = "bottom",
      height = 10,
      width = 50,
      icons = true,
      mode = "workspace_diagnostics",
      fold_open = "",
      fold_closed = "",
      group = true,
      padding = true,
      action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = { "<cr>", "<tab>" },
        open_split = { "<c-x>" },
        open_vsplit = { "<c-v>" },
        open_tab = { "<c-t>" },
        jump_close = { "o" },
        toggle_mode = "m",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = { "zM", "zm" },
        open_folds = { "zR", "zr" },
        toggle_fold = { "zA", "za" },
        previous = "k",
        next = "j",
      },
      indent_lines = true,
      auto_open = false,
      auto_close = false,
      auto_preview = true,
      auto_fold = false,
      auto_jump = { "lsp_definitions" },
      signs = {
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠",
      },
      use_diagnostic_signs = false,
    })
    
    vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", { desc = "Toggle Trouble" })
    vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "Workspace diagnostics" })
    vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { desc = "Document diagnostics" })
    vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { desc = "Location list" })
    vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { desc = "Quickfix list" })
    vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", { desc = "LSP references" })
  end,
}
