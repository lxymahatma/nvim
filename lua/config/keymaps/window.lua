local map = Snacks.keymap.set

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Window Splits
map("n", "<leader>wj", "<C-w>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>wl", "<C-w>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wc", "<C-w>c", { desc = "Close Current Window", remap = true })
