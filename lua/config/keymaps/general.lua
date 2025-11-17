local map = Snacks.keymap.set
local del = Snacks.keymap.del

-- Buffer Keymaps
map("n", "H", "<cmd>bp<cr>", { desc = "Previous Buffer", remap = true })
map("n", "L", "<cmd>bn<cr>", { desc = "Next Buffer", remap = true })
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete buffer", remap = true })
map("n", "<leader>bl", function() require("helpers.buffer").close_buffers("left") end, { desc = "Close buffers on the left", remap = true })
map("n", "<leader>br", function() require("helpers.buffer").close_buffers("right") end, { desc = "Close buffers on the right", remap = true })

-- Tabs Keymaps
map("n", "[t", "<cmd>tabp<cr>", { desc = "Previous Tab", remap = true })
map("n", "]t", "<cmd>tabn<cr>", { desc = "Next Tab", remap = true })
map("n", "[T", "<cmd>tabfirst<cr>", { desc = "First Tab", remap = true })
map("n", "]T", "<cmd>tablast<cr>", { desc = "Last Tab", remap = true })
map("n", "<leader>tn", "<cmd>tab split<cr>", { desc = "New tab with current file", remap = true })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close Tab", remap = true })

-- Insert mode, ctrl + h / ctrl + l move to the beginning and end of the line
map("i", "<C-h>", "<HOME>", { desc = "Go to the beginning of the line", remap = true })
map("i", "<C-l>", "<END>", { desc = "Go to the end of the line", remap = true })

-- Space Line
map("n", "<leader>o", "o<Esc>", { desc = "Open a new line below", remap = true })
map("n", "<leader>O", "O<Esc>", { desc = "Open a new line above", remap = true })

-- Folding
map("n", "<leader>z", "za", { desc = "Toggle fold", remap = true })
map("n", "<leader>Z", "zA", { desc = "Toggle all folds", remap = true })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Lazy.nvim
map("n", "<leader>lz", "<cmd>Lazy<cr>", { desc = "Open Lazy.nvim" })
map("n", "<leader>lp", "<cmd>Lazy profile<cr>", { desc = "Profile Lazy.nvim plugins" })

-- Don't copy the replaced text
-- map("n", "<leader>d", "\"_d", { desc = "Delete without copying to the clipboard", remap = true })
-- map("x", "<leader>d", "\"_d", { desc = "Delete without copying to the clipboard", remap = true })
-- map("x", "<leader>p", "\"_dP", { desc = "Paste without replacing the clipboard", remap = true })

-- Code Actions
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", lsp = { method = "textDocument/codeAction" } })

-- Delete Keymaps
del("n", "gra")
del("n", "gri")
del("n", "grn")
del("n", "grr")
del("n", "grt")
