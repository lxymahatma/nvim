local map = Snacks.keymap.set

-- Snacks Toggle
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.inlay_hints():map("<leader>uh")

-- Terminal
map({ "n", "t" }, "<C-/>", Snacks.terminal.toggle, { desc = "Toggle Terminal" })

-- Notifications
map("n", "<leader>n", Snacks.notifier.show_history, { desc = "Notification History" })

-- Lazygit
map("n", "<leader>lg", Snacks.lazygit.open, { desc = "Open Lazygit" })

-- Explorer
map("n", "<leader>fe", Snacks.explorer.reveal, { desc = "File Explorer" })

-- Find
map("n", "<leader>fb", Snacks.picker.buffers, { desc = "Buffers" })
map("n", "<leader>ff", Snacks.picker.smart, { desc = "Files" })
map("n", "<leader>fh", Snacks.picker.help, { desc = "Help" })
map("n", "<leader>fl", Snacks.picker.lines, { desc = "Buffer Lines" })
map("n", "<leader>fn", Snacks.picker.notifications, { desc = "Notification" })
map("n", "<leader>fp", Snacks.picker.projects, { desc = "Project" })
map("n", "<leader>fr", Snacks.picker.recent, { desc = "Recent" })
map("n", "<leader>fw", Snacks.picker.grep, { desc = "Grep" })

-- Search
map("n", "<leader>sa", Snacks.picker.autocmds, { desc = "Autocmds" })
map("n", "<leader>sb", Snacks.picker.grep_buffers, { desc = "Grep Open Buffers" })
map("n", "<leader>sc", Snacks.picker.commands, { desc = "Commands" })
map("n", "<leader>sd", Snacks.picker.diagnostics_buffer, { desc = "Diagnostics (Buffer)" })
map("n", "<leader>sD", Snacks.picker.diagnostics, { desc = "Diagnostics (Workspace)" })
map("n", "<leader>sf", Snacks.picker.files, { desc = "Files" })
map("n", "<leader>sh", Snacks.picker.search_history, { desc = "Search History" })
map("n", "<leader>sH", Snacks.picker.highlights, { desc = "Highlights" })
map("n", "<leader>si", Snacks.picker.icons, { desc = "Icons" })
map("n", "<leader>sj", Snacks.picker.jumps, { desc = "Jumps" })
map("n", "<leader>sk", Snacks.picker.keymaps, { desc = "Keymaps" })
map("n", "<leader>sl", Snacks.picker.loclist, { desc = "Location List" })
map("n", "<leader>sL", Snacks.picker.lsp_config, { desc = "LSP Configurations" })
map("n", "<leader>sm", Snacks.picker.marks, { desc = "Marks" })
map("n", "<leader>sM", Snacks.picker.man, { desc = "Man Pages" })
map("n", "<leader>sp", Snacks.picker.lazy, { desc = "Plugin Spec" })
map("n", "<leader>sq", Snacks.picker.qflist, { desc = "Quickfix List" })
map("n", "<leader>sR", Snacks.picker.registers, { desc = "Registers" })
map({ "n", "x" }, "<leader>sw", Snacks.picker.grep_word, { desc = "Selection or Word" })
map("n", "<leader>sz", Snacks.picker.zoxide, { desc = "Zoxide" })

-- LSP Pickers
map("n", "gd", Snacks.picker.lsp_definitions, { desc = "Goto Definition", lsp = { method = "textDocument/definition" } })
map("n", "gD", Snacks.picker.lsp_declarations, { desc = "Goto Declaration", lsp = { method = "textDocument/declaration" } })
map("n", "gr", Snacks.picker.lsp_references, { desc = "References", lsp = { method = "textDocument/references" }, nowait = true })
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
map("n", "<leader>st", function() Snacks.picker.todo_comments() end, { desc = "Todo" })
map("n", "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX" } }) end, { desc = "Todo/Fix" })
