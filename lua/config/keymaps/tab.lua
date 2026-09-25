local map = Snacks.keymap.set

map("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "[T", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "]T", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader>tn", "<cmd>tab split<cr>", { desc = "New tab with current file" })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close Tab" })
