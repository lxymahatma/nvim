local map = Snacks.keymap.set

map("n", "H", "<cmd>TabScopePrev<cr>", { desc = "Previous Buffer", remap = true })
map("n", "L", "<cmd>TabScopeNext<cr>", { desc = "Next Buffer", remap = true })
map("n", "<leader>bd", Snacks.bufdelete.delete, { desc = "Delete current buffer", remap = true })
map("n", "<leader>bo", Snacks.bufdelete.other, { desc = "Delete other buffers", remap = true })
map("n", "<leader>bl", "<cmd>TabScopeCloseLeft<cr>", { desc = "Close buffers on the left", remap = true })
map("n", "<leader>br", "<cmd>TabScopeCloseRight<cr>", { desc = "Close buffers on the right", remap = true })
