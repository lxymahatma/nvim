-- Git integration for buffers
--- @type LazyPluginSpec
return {
    "lewis6991/gitsigns.nvim",
    event = "BufEdit",

    --- @type Gitsigns.Config
    opts = {
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "▎" },
            untracked = { text = "▎" },
        },
        signs_staged = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "▎" },
        },
        signcolumn = true,
        numhl = true,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
            follow_files = true,
        },
        auto_attach = true,
        current_line_blame = true,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol",
            delay = 200,
            ignore_whitespace = false,
            virt_text_priority = 100,
            use_focus = true,
        },
        trouble = true,
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc, silent = true }) end

            -- Hunk Navigation
            map("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, "Next Hunk")
            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, "Prev Hunk")
            map("n", "]H", function() gitsigns.nav_hunk("last") end, "Last Hunk")
            map("n", "[H", function() gitsigns.nav_hunk("first") end, "First Hunk")

            -- Hunk Actions
            map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<cr>", "Stage Hunk")
            map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<cr>", "Reset Hunk")
            map("n", "<leader>ghS", function() gitsigns.stage_buffer() end, "Stage Buffer")
            map("n", "<leader>ghR", function() gitsigns.reset_buffer() end, "Reset Buffer")

            map("n", "<leader>ghp", function() gitsigns.preview_hunk_inline() end, "Preview Hunk Inline")
            map("n", "<leader>ghb", function() gitsigns.blame_line({ full = true }) end, "Blame Line")
            map("n", "<leader>ghB", function() gitsigns.blame() end, "Blame Buffer")

            map("n", "<leader>ghl", function() gitsigns.setqflist() end, "List Hunks")
            map("n", "<leader>ghL", function() gitsigns.setqflist("all") end, "List All Hunks")

            -- Text object
            map({ "o", "x" }, "ih", function() gitsigns.select_hunk() end, "GitSigns Select Hunk")
        end,
    },
}
