local keymap = vim.keymap

keymap.set("n", "<leader>ut", "<cmd>Telescope colorscheme<cr>", { desc = "Theme Picker" })
keymap.set("n", "<leader>u1", "<cmd>colorscheme tokyonight<cr>", { desc = "Tokyo Night" })
keymap.set("n", "<leader>u2", "<cmd>colorscheme catppuccin<cr>", { desc = "Catppuccin" })
keymap.set("n", "<leader>u3", "<cmd>colorscheme rose-pine<cr>", { desc = "Rose Pine" })
keymap.set("n", "<leader>u4", "<cmd>colorscheme kanagawa<cr>", { desc = "Kanagawa" })
keymap.set("n", "<leader>u5", "<cmd>colorscheme gruvbox-material<cr>", { desc = "Gruvbox Material" })
keymap.set("n", "<leader>u6", "<cmd>colorscheme dracula<cr>", { desc = "Dracula" })

keymap.set("n", "<leader>ul", "<cmd>Lazy<cr>", { desc = "Lazy Plugin Manager" })
keymap.set("n", "<leader>um", "<cmd>Mason<cr>", { desc = "Mason LSP Manager" })
keymap.set("n", "<leader>uc", "<cmd>e $MYVIMRC<cr>", { desc = "Edit Config" })
keymap.set("n", "<leader>ur", "<cmd>source $MYVIMRC<cr>", { desc = "Reload Config" })

keymap.set("n", "<leader>uz", "<cmd>set conceallevel=0<cr>", { desc = "Show Hidden Chars" })
keymap.set("n", "<leader>ux", "<cmd>set conceallevel=2<cr>", { desc = "Hide Hidden Chars" })

keymap.set("n", "<leader>un", "<cmd>set number!<cr>", { desc = "Toggle Line Numbers" })
keymap.set("n", "<leader>ur", "<cmd>set relativenumber!<cr>", { desc = "Toggle Relative Numbers" })
keymap.set("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle Line Wrap" })
keymap.set("n", "<leader>us", "<cmd>set spell!<cr>", { desc = "Toggle Spell Check" })

keymap.set("n", "<leader>uh", "<cmd>nohlsearch<cr>", { desc = "Clear Highlights" })
keymap.set("n", "<leader>ui", "<cmd>Inspect<cr>", { desc = "Inspect Highlight" })
keymap.set("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

keymap.set("n", "<leader>uo", function()
  vim.opt.cmdheight = vim.opt.cmdheight:get() == 0 and 1 or 0
end, { desc = "Toggle Cmdline" })

keymap.set("n", "<leader>uL", function()
  local conceallevel = vim.opt.conceallevel:get()
  vim.opt.conceallevel = conceallevel == 0 and 3 or 0
end, { desc = "Toggle Conceal Level" })

keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "Buffer List" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
keymap.set("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", { desc = "Delete All But Current" })
keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
keymap.set("n", "<leader>bf", "<cmd>bfirst<cr>", { desc = "First Buffer" })
keymap.set("n", "<leader>bl", "<cmd>blast<cr>", { desc = "Last Buffer" })

keymap.set("n", "<leader>ss", "<cmd>Telescope live_grep<cr>", { desc = "Search Text" })
keymap.set("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "Search Word Under Cursor" })
keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Search Help" })
keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Search Keymaps" })
keymap.set("n", "<leader>sc", "<cmd>Telescope commands<cr>", { desc = "Search Commands" })
keymap.set("n", "<leader>sm", "<cmd>Telescope man_pages<cr>", { desc = "Search Man Pages" })
keymap.set("n", "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Search Vim Options" })
keymap.set("n", "<leader>sr", "<cmd>Telescope registers<cr>", { desc = "Search Registers" })
keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Search TODOs" })

keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<cr>", { desc = "Git Files" })

keymap.set("n", "<leader>lI", "<cmd>LspInfo<cr>", { desc = "LSP Info" })
keymap.set("n", "<leader>lR", "<cmd>LspRestart<cr>", { desc = "LSP Restart" })
keymap.set("n", "<leader>lS", "<cmd>LspStart<cr>", { desc = "LSP Start" })
keymap.set("n", "<leader>lK", "<cmd>LspStop<cr>", { desc = "LSP Stop" })

keymap.set("n", "<leader>md", "<cmd>delmarks!<cr>", { desc = "Delete All Marks" })
keymap.set("n", "<leader>mD", "<cmd>delmarks A-Z0-9<cr>", { desc = "Delete Global Marks" })

keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
keymap.set("n", "<leader>qQ", "<cmd>qa!<cr>", { desc = "Quit All Force" })
keymap.set("n", "<leader>qw", "<cmd>wqa<cr>", { desc = "Save & Quit All" })

keymap.set("n", "<leader>ww", "<cmd>w<cr>", { desc = "Save File" })
keymap.set("n", "<leader>wa", "<cmd>wa<cr>", { desc = "Save All Files" })
keymap.set("n", "<leader>wq", "<cmd>wq<cr>", { desc = "Save & Quit" })
