local opt = vim.opt
local g = vim.g

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.wrap = false
opt.breakindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

opt.scrolloff = 8
opt.sidescrolloff = 8
opt.updatetime = 250
opt.timeoutlen = 300

opt.completeopt = "menu,menuone,noselect"

opt.pumheight = 10
opt.showmode = false
opt.conceallevel = 0

opt.fileencoding = "utf-8"
opt.cmdheight = 1

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.iskeyword:append("-")

opt.formatoptions:remove({ "c", "r", "o" })

opt.laststatus = 3
opt.showcmd = false
opt.ruler = false

opt.fillchars = {
  eob = " ",
  fold = " ",
  foldsep = " ",
}

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end
