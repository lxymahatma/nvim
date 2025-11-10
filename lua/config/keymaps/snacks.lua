local map = Snacks.keymap.set

-- Snacks Toggle
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.inlay_hints():map("<leader>uh")

-- Terminal
map({ "n", "t" }, "<C-/>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })

-- Notifications
map("n", "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Notification History" })

-- Lazygit
map("n", "<leader>lg", function() Snacks.lazygit() end, { desc = "Open Lazygit" })

-- Explorer
map("n", "<C-e>", function() Snacks.explorer() end, { desc = "File Explorer" })

-- Find
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>ff", function() Snacks.picker.smart() end, { desc = "Files" })
map("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "Help" })
map("n", "<leader>fl", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
map("n", "<leader>fn", function() Snacks.picker.notifications() end, { desc = "Notification" })
map("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Project" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
map("n", "<leader>fw", function() Snacks.picker.grep() end, { desc = "Grep" })

-- Search
map("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
map("n", "<leader>sb", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
map("n", "<leader>sc", function() Snacks.picker.commands() end, { desc = "Commands" })
map("n", "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, { desc = "Diagnostics (Buffer)" })
map("n", "<leader>sD", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics (Workspace)" })
map("n", "<leader>sf", function() Snacks.picker.files() end, { desc = "Files" })
map("n", "<leader>sh", function() Snacks.picker.search_history() end, { desc = "Search History" })
map("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
map("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
map("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
map("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
map("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
map("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
map("n", "<leader>sp", function() Snacks.picker.lazy() end, { desc = "Plugin Spec" })
map("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
map("n", "<leader>sR", function() Snacks.picker.registers() end, { desc = "Registers" })
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Selection or Word" })
map("n", "<leader>sz", function() Snacks.picker.zoxide() end, { desc = "Zoxide" })

-- LSP Pickers
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition", lsp = { method = "textDocument/definition" } })
map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration", lsp = { method = "textDocument/declaration" } })
map("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References", lsp = { method = "textDocument/references" }, nowait = true })
map("n", "gi", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation", lsp = { method = "textDocument/implementation" } })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition", lsp = { method = "textDocument/typeDefinition" } })
map("n", "gci", function() Snacks.picker.lsp_incoming_calls() end, { desc = "Calls Incoming", lsp = { method = "callHierarchy/incomingCalls" } })
map("n", "gco", function() Snacks.picker.lsp_outgoing_calls() end, { desc = "Calls Outgoing", lsp = { method = "callHierarchy/outgoingCalls" } })
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols", lsp = { method = "textDocument/documentSymbol" } })
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols", lsp = { method = "workspace/symbols" } })

-- Git
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })

-- GitHub
map("n", "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })
map("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)" })
map("n", "<leader>gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub Pull Requests (open)" })
map("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, { desc = "GitHub Pull Requests (all)" })

-- Scratch
map("n", "<leader>bs", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>bS", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })

-- Todo Comments
---@diagnostic disable:undefined-field
map("n", "<leader>st", function() Snacks.picker.todo_comments() end, { desc = "Todo" })
map("n", "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX" } }) end, { desc = "Todo/Fix" })
