return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      
      require("mini.bufremove").setup()
      
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
      
      require("mini.indentscope").setup({
        symbol = "│",
        options = { try_as_border = true },
      })
      
      require("mini.pairs").setup()
    end,
  },
}
