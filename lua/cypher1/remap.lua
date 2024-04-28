vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move the visual selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Prep for HJKL
vim.keymap.set("n", "M", "J") -- mnemonic: [M]erge
vim.keymap.set("n", "<leader>h", "K") -- mnemonic: [h]over

-- HJKL as amplified versions of hjkl
vim.keymap.set("n", "J", "6j")
vim.keymap.set("n", "K", "6k")
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
vim.keymap.set("n", "x", '"_x')
-- Don't override the clipboard when changing
vim.keymap.set("n", "c", '"_c')

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
vim.keymap.set("i", "<A-1>", "⊤")
vim.keymap.set("i", "<A-2>", "⊥")
vim.keymap.set("i", "<A-3>", "⊢")
vim.keymap.set("i", "<A-4>", "⊣")
vim.keymap.set("i", "<A-5>", "→")
vim.keymap.set("i", "<A-6>", "∧")
vim.keymap.set("i", "<A-7>", "Π")
vim.keymap.set("i", "<A-8>", "∀")
vim.keymap.set("i", "<A-9>", "∃")
vim.keymap.set("i", "<A-0>", "λ")
