vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- 'Shove': Move the visual selection
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>", {silent=true})
vim.keymap.set("n", "˚", ":silent! m .-2<CR>", {silent=true})
vim.keymap.set("n", "<A-j>", ":m .+1<CR>", {silent=true})
vim.keymap.set("n", "∆", ":m .+1<CR>", {silent=true})
-- These work for all but the first and last characters
vim.keymap.set("n", "<A-h>", "ylxhP", {silent=true})
vim.keymap.set("n", "˙", "ylxhP", {silent=true})
vim.keymap.set("n", "<A-l>", "ylxp", {silent=true})
vim.keymap.set("n", "¬", "ylxp", {silent=true})

vim.keymap.set("n", "!", ":set relativenumber!<CR>", {silent=true})
vim.keymap.set("n", "<C-1>", ":set number!<CR>", {silent=true})

-- HL as amplified versions of hl
vim.keymap.set("n", "H", "0^")
vim.keymap.set("n", "L", "$")

-- Buffer management
vim.keymap.set("n", "<leader>w", vim.cmd.write)
vim.keymap.set("n", "<leader>n", vim.cmd.bnext)
vim.keymap.set("n", "<leader>m", vim.cmd.bprevious)
vim.keymap.set("n", "<leader>q", vim.cmd.bdelete)

-- Clipboard control
-- vim.keymap.set("n", "<leader>y", "\"+y")
-- vim.keymap.set("v", "<leader>y", "\"+y")
-- vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Don't override the clipboard when removing
-- vim.keymap.set("n", "x", '"_x')
-- Don't override the clipboard when changing
vim.keymap.set("n", "c", '"_c')
-- c_ and c$ appear very similar... so lets map it to a common annoyance.
vim.keymap.set("n", "c_", 'h/_[a-z]<cr>x~h:silent! call repeat#set("c_", v:count)<cr>')
-- I don't use c- much and it matches the above, so use it for the opposite.
vim.keymap.set("n", "c-", 'h/[A-Z]<cr>~hi_<esc>l:silent! call repeat#set("c-", v:count)<cr>')

vim.keymap.set("n", "dd", function ()
  -- Don't copy empty lines when deleting.
	if vim.fn.getline(".") == "" then return '"_dd' end
	return "dd"
end, {expr = true})

-- Paste over (not working right now?)
-- vim.keymap.set("x", "<leader>p", "\"_dP")

-- Quick fix
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "Q", "<nop>") -- no more accidental macros
vim.keymap.set("n", ":", ":nohlsearch<CR>:") -- clear highlight

vim.keymap.set(
  "n",
  "<leader>g",
  "/\\(<<<<<<<\\|=======\\|>>>>>>>\\||||||||\\)/\n"
)

-- Symbols for Maths, Lean, Coq
vim.keymap.set("i", "<A-t>", "⊤")
vim.keymap.set("i", "<A-T>", "⊥")
vim.keymap.set("i", "<A-g>", "⊢")
vim.keymap.set("i", "<A-G>", "⊣")

vim.keymap.set("i", "<A-a>", "∧")
vim.keymap.set("i", "<A-A>", "Π")
vim.keymap.set("i", "<A-E>", "∀")
vim.keymap.set("i", "<A-e>", "∃")

vim.keymap.set("i", "<A-y>", "λ")
vim.keymap.set("i", "<A-Y>", "→")
