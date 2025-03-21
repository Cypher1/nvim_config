require("cypher1.remap")
require("cypher1.lazy")
require("cypher1.lsp")

-- vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
vim.opt.conceallevel = 1
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.fixeol = false
vim.opt.fixendofline = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.ttimeoutlen = 50 -- Fast
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Make zsh files recognized as sh for bash-ls & treesitter
vim.filetype.add {
	extension = {
		edb = "yaml",
	},
	filename = {
		[".edb"] = "yaml",
	},
}

vim.filetype.add {
	extension = {
		zsh = "sh",
		sh = "sh", -- force sh-files with zsh-shebang to still get sh as filetype
	},
	filename = {
		[".zshrc"] = "sh",
		[".zshenv"] = "sh",
	},
}

vim.filetype.add {
	extension = {
		tk = "tako",
	},
	filename = {
		[".tk"] = "tako",
		[".tako"] = "tako",
	},
}

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.g.genghis_use_systemclipboard = true

vim.g.fzf_history_dir = '~/.local/share/fzf-history'
vim.g.fzf_buffers_jump = 1

function Colors(color)
  color = color or "rose-pine-main"

  vim.fn.matchadd("Overnesting", "^" .. (" "):rep(vim.opt.tabstop:get()*6) .. " *")
  vim.fn.matchadd("Trailing", " " .. " *$")
  vim.cmd.colorscheme(color)

  -- vim.api.nvim_set_hl(0, "Overnesting", { bg = "#400000" })
  vim.api.nvim_set_hl(0, "Trailing", { bg = "#600000" })
  vim.api.nvim_set_hl(0, "Normal", { bg = "black" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "black" })
end

Colors()
