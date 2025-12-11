local map = Snacks.keymap.set

map("n", "H", "<cmd>bprevious<cr>", { desc = "Previous Buffer", remap = true })
map("n", "L", "<cmd>bnext<cr>", { desc = "Next Buffer", remap = true })
map("n", "<leader>bd", Snacks.bufdelete.delete, { desc = "Delete current buffer", remap = true })
map("n", "<leader>bo", Snacks.bufdelete.other, { desc = "Delete other buffers", remap = true })
map("n", "<leader>bl", function() require("helpers.buffer").close_buffers("left") end, { desc = "Close buffers on the left", remap = true })
map("n", "<leader>br", function() require("helpers.buffer").close_buffers("right") end, { desc = "Close buffers on the right", remap = true })
