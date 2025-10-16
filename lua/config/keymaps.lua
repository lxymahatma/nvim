local map = vim.keymap.set
local api = vim.api
local uv = vim.loop

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
map("n", "<Leader>o", "o<Esc>", { desc = "Open a new line below", remap = true })
map("n", "<Leader>O", "O<Esc>", { desc = "Open a new line above", remap = true })

-- Don't copy the replaced text
-- map("n", "<Leader>d", "\"_d", { desc = "Delete without copying to the clipboard", remap = true })
-- map("x", "<Leader>d", "\"_d", { desc = "Delete without copying to the clipboard", remap = true })
-- map("x", "<Leader>p", "\"_dP", { desc = "Paste without replacing the clipboard", remap = true })
