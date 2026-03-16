return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "classic",
    win = {
      border = "rounded",
      padding = { 2, 2 },
      title = true,
      title_pos = "center",
    },
    spec = {
      { "<leader>f", group = "📁 Find/File", icon = "📁" },
      { "<leader>s", group = "🔍 Search", icon = "🔍" },
      { "<leader>g", group = "🔀 Git", icon = "🔀" },
      { "<leader>b", group = "📑 Buffer", icon = "📑" },
      { "<leader>c", group = "💻 Code", icon = "💻" },
      { "<leader>l", group = "🔧 LSP", icon = "🔧" },
      { "<leader>u", group = "🎨 UI/Theme", icon = "🎨" },
      { "<leader>t", group = "📂 Tab/Terminal", icon = "📂" },
      { "<leader>e", group = "📂 Explorer", icon = "📂" },
      { "<leader>h", group = "🔀 Git Hunk", icon = "🔀" },
      { "<leader>x", group = "🐛 Diagnostics", icon = "🐛" },
      { "<leader>m", group = "⚙️  Misc", icon = "⚙️" },
    },
  },
}
