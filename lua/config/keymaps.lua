local map = vim.keymap.set

-- leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Insert mode, ctrl + h / ctrl + l move to the beginning and end of the line
map("i", "<C-h>", "<HOME>", { desc = "Go to the beginning of the line", remap = true })
map("i", "<C-l>", "<END>", { desc = "Go to the end of the line", remap = true })

-- Space Line
map("n", "<leader>o", "o<Esc>", { desc = "Open a new line below", remap = true })
map("n", "<leader>O", "O<Esc>", { desc = "Open a new line above", remap = true })

-- Folding
map("n", "<leader>z", "za", { desc = "Toggle fold", remap = true })
map("n", "<leader>Z", "zA", { desc = "Toggle all folds", remap = true })

-- Code Actions
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- Clear search highlight
map("n", "<leader>/", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Open Lazy.nvim
map("n", "<leader>lz", ":Lazy<CR>", { desc = "Open Lazy.nvim" })

-- Don't copy the replaced text
-- map("n", "<leader>d", "\"_d", { desc = "Delete without copying to the clipboard", remap = true })
-- map("x", "<leader>d", "\"_d", { desc = "Delete without copying to the clipboard", remap = true })
-- map("x", "<leader>p", "\"_dP", { desc = "Paste without replacing the clipboard", remap = true })
