local map = Snacks.keymap.set
local del = Snacks.keymap.del

-- Buffer Keymaps
map("n", "H", "<cmd>bprevious<cr>", { desc = "Previous Buffer", remap = true })
map("n", "L", "<cmd>bnext<cr>", { desc = "Next Buffer", remap = true })
map("n", "<leader>bd", Snacks.bufdelete.delete, { desc = "Delete current buffer", remap = true })
map("n", "<leader>bo", Snacks.bufdelete.other, { desc = "Delete other buffers", remap = true })
map("n", "<leader>bl", function() require("helpers.buffer").close_buffers("left") end, { desc = "Close buffers on the left", remap = true })
map("n", "<leader>br", function() require("helpers.buffer").close_buffers("right") end, { desc = "Close buffers on the right", remap = true })

-- Tabs Keymaps
map("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous Tab", remap = true })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next Tab", remap = true })
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

-- Code Actions
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", lsp = { method = "textDocument/codeAction" } })

-- Open Link
map("n", "gl", function() vim.ui.open(vim.fn.expand("<cfile>")) end, { desc = "Open link/file under cursor" })
map("x", "gl", function()
    local lines = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { type = vim.fn.mode() })
    vim.ui.open(table.concat(vim.iter(lines):map(vim.trim):totable()))
end, { desc = "Open selected link/file" })

map("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
