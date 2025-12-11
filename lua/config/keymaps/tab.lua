local map = Snacks.keymap.set

map("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous Tab", remap = true })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next Tab", remap = true })
map("n", "[T", "<cmd>tabfirst<cr>", { desc = "First Tab", remap = true })
map("n", "]T", "<cmd>tablast<cr>", { desc = "Last Tab", remap = true })
map("n", "<leader>tn", "<cmd>tab split<cr>", { desc = "New tab with current file", remap = true })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close Tab", remap = true })
