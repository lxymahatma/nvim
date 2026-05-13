local map = Snacks.keymap.set

map({ "n", "v" }, "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code action", lsp = { method = "textDocument/codeAction" } })

map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition", lsp = { method = "textDocument/definition" } })
map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration", lsp = { method = "textDocument/declaration" } })
map("n", "gR", function() Snacks.picker.lsp_references() end, { desc = "Goto References", lsp = { method = "textDocument/references" }, nowait = true })
map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation", lsp = { method = "textDocument/implementation" } })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition", lsp = { method = "textDocument/typeDefinition" } })
map("n", "<leader>ci", function() Snacks.picker.lsp_incoming_calls() end, { desc = "Calls Incoming", lsp = { method = "callHierarchy/incomingCalls" } })
map("n", "<leader>co", function() Snacks.picker.lsp_outgoing_calls() end, { desc = "Calls Outgoing", lsp = { method = "callHierarchy/outgoingCalls" } })
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols", lsp = { method = "textDocument/documentSymbol" } })
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols", lsp = { method = "workspace/symbol" } })
