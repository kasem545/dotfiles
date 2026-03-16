-- ============================================================================
-- ULTIMATE NEOVIM CONFIGURATION
-- ============================================================================
-- Modern, feature-rich Neovim setup for professional developers
-- Includes: LSP, autocompletion, treesitter, UI enhancements, and more

-- Set leader key before loading anything
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configurations
require("core.options")
require("core.keymaps")
require("core.ui-keymaps")

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  -- Import all plugin configurations from lua/plugins/
  { import = "plugins" },
}, {
  -- Lazy.nvim configuration
  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
    },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
