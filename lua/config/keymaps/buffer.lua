local map = Snacks.keymap.set

map("n", "H", "<cmd>TabScopePrev<cr>", { desc = "Previous Buffer" })
map("n", "L", "<cmd>TabScopeNext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bd", Snacks.bufdelete.delete, { desc = "Delete current buffer" })
map("n", "<leader>bo", Snacks.bufdelete.other, { desc = "Delete other buffers" })
map("n", "<leader>bl", "<cmd>TabScopeCloseLeft<cr>", { desc = "Close buffers on the left" })
map("n", "<leader>br", "<cmd>TabScopeCloseRight<cr>", { desc = "Close buffers on the right" })
