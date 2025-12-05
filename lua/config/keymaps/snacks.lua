local map = Snacks.keymap.set

-- Snacks Toggle
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle({
    name = "Auto Format (Buffer)",
    get = function() return not vim.b.disable_autoformat end,
    set = function(state) vim.b.disable_autoformat = not state end,
}):map("<leader>uf")
Snacks.toggle({
    name = "Auto Format (Global)",
    get = function() return not vim.g.disable_autoformat end,
    set = function(state) vim.g.disable_autoformat = not state end,
}):map("<leader>uF")

-- Terminal
map({ "n", "t" }, "<C-/>", Snacks.terminal.toggle, { desc = "Toggle Terminal" })

-- Notifications
map("n", "<leader>n", Snacks.notifier.show_history, { desc = "Notification History" })

-- Lazygit
map("n", "<leader>lg", Snacks.lazygit.open, { desc = "Open Lazygit" })

-- Explorer
map("n", "<leader>fe", Snacks.explorer.reveal, { desc = "File Explorer" })

-- Find
map("n", "<leader>fb", Snacks.picker.buffers, { desc = "Find Buffers" })
map("n", "<leader>ff", Snacks.picker.smart, { desc = "Find Files" })
map("n", "<leader>fh", Snacks.picker.help, { desc = "Find Help" })
map("n", "<leader>fl", Snacks.picker.lines, { desc = "Find Buffer Lines" })
map("n", "<leader>fn", Snacks.picker.notifications, { desc = "Find Notification" })
map("n", "<leader>fp", Snacks.picker.projects, { desc = "Find Project" })
map("n", "<leader>fr", Snacks.picker.recent, { desc = "Find Recent" })
map("n", "<leader>fw", Snacks.picker.grep, { desc = "Find Text" })

-- Search
map("n", "<leader>sa", Snacks.picker.autocmds, { desc = "Search Autocmds" })
map("n", "<leader>sb", Snacks.picker.grep_buffers, { desc = "Search in Buffer" })
map("n", "<leader>sc", Snacks.picker.commands, { desc = "Search Commands" })
map("n", "<leader>sd", Snacks.picker.diagnostics_buffer, { desc = "Search Diagnostics (Buffer)" })
map("n", "<leader>sD", Snacks.picker.diagnostics, { desc = "Search Diagnostics (Workspace)" })
map("n", "<leader>sf", Snacks.picker.files, { desc = "Search Files" })
map("n", "<leader>sh", Snacks.picker.search_history, { desc = "Search History" })
map("n", "<leader>sH", Snacks.picker.highlights, { desc = "Search Highlights" })
map("n", "<leader>si", Snacks.picker.icons, { desc = "Search Icons" })
map("n", "<leader>sj", Snacks.picker.jumps, { desc = "Search Jumps" })
map("n", "<leader>sk", Snacks.picker.keymaps, { desc = "Search Keymaps" })
map("n", "<leader>sl", Snacks.picker.loclist, { desc = "Search Location List" })
map("n", "<leader>sL", Snacks.picker.lsp_config, { desc = "Search LSP Configurations" })
map("n", "<leader>sm", Snacks.picker.marks, { desc = "Search Marks" })
map("n", "<leader>sM", Snacks.picker.man, { desc = "Search Man Pages" })
map("n", "<leader>sp", Snacks.picker.lazy, { desc = "Search Plugin Spec" })
map("n", "<leader>sq", Snacks.picker.qflist, { desc = "Search Quickfix List" })
map("n", "<leader>sR", Snacks.picker.registers, { desc = "Search Registers" })
map({ "n", "x" }, "<leader>sw", Snacks.picker.grep_word, { desc = "Search Selection or Word" })
map("n", "<leader>sz", Snacks.picker.zoxide, { desc = "Search Zoxide" })

-- LSP Pickers
map("n", "gd", Snacks.picker.lsp_definitions, { desc = "Goto Definition", lsp = { method = "textDocument/definition" } })
map("n", "gD", Snacks.picker.lsp_declarations, { desc = "Goto Declaration", lsp = { method = "textDocument/declaration" } })
map("n", "gR", Snacks.picker.lsp_references, { desc = "Goto References", lsp = { method = "textDocument/references" }, nowait = true })
map("n", "gi", Snacks.picker.lsp_implementations, { desc = "Goto Implementation", lsp = { method = "textDocument/implementation" } })
map("n", "gy", Snacks.picker.lsp_type_definitions, { desc = "Goto Type Definition", lsp = { method = "textDocument/typeDefinition" } })
map("n", "gci", Snacks.picker.lsp_incoming_calls, { desc = "Calls Incoming", lsp = { method = "callHierarchy/incomingCalls" } })
map("n", "gco", Snacks.picker.lsp_outgoing_calls, { desc = "Calls Outgoing", lsp = { method = "callHierarchy/outgoingCalls" } })
map("n", "<leader>ss", Snacks.picker.lsp_symbols, { desc = "LSP Symbols", lsp = { method = "textDocument/documentSymbol" } })
map("n", "<leader>sS", Snacks.picker.lsp_workspace_symbols, { desc = "LSP Workspace Symbols", lsp = { method = "workspace/symbols" } })

-- Git
map("n", "<leader>gl", Snacks.picker.git_log, { desc = "Git Log" })
map("n", "<leader>gf", Snacks.picker.git_log_file, { desc = "Git Log File" })

-- GitHub
map("n", "<leader>gi", Snacks.picker.gh_issue, { desc = "GitHub Issues (open)" })
map("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)" })
map("n", "<leader>gp", Snacks.picker.gh_pr, { desc = "GitHub Pull Requests (open)" })
map("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, { desc = "GitHub Pull Requests (all)" })

-- Scratch
map("n", "<leader>bs", Snacks.scratch.open, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>bS", Snacks.scratch.select, { desc = "Select Scratch Buffer" })

-- Todo Comments
---@diagnostic disable:undefined-field
map("n", "<leader>st", function() Snacks.picker.todo_comments() end, { desc = "Search Todo" })
map("n", "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX" } }) end, { desc = "Search Todo/Fix" })
