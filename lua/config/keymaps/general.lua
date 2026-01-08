local map = Snacks.keymap.set
local del = Snacks.keymap.del

-- Insert mode
-- ctrl + h / ctrl + l move to the beginning and end of the line
-- ctrl + j / ctrl + k move up and down a line
map("i", "<C-h>", "<HOME>", { desc = "Go to the beginning of the line", silent = true })
map("i", "<C-l>", "<END>", { desc = "Go to the end of the line", silent = true })
map("i", "<C-j>", "<C-o>gj", { desc = "Go down a line", silent = true })
map("i", "<C-k>", "<C-o>gk", { desc = "Go up a line", silent = true })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Lazy.nvim
map("n", "<leader>lz", "<cmd>Lazy<cr>", { desc = "Open Lazy.nvim" })
map("n", "<leader>lp", "<cmd>Lazy profile<cr>", { desc = "Profile Lazy.nvim plugins" })

-- Code Actions
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", lsp = { method = "textDocument/codeAction" } })

-- Preview
map("n", "<leader>up", "<cmd>Markview<cr>", { desc = "Toggle Preview" })
map("n", "<leader>uP", "<cmd>Markview splitToggle<cr>", { desc = "Toggle Split Preview" })

-- Toolchain
map("n", "<leader>ct", "<cmd>Toolchain<cr>", { desc = "Toolchain" })
