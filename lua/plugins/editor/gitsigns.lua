-- Git integration for buffers
---@type LazyPluginSpec
return {
    "lewis6991/gitsigns.nvim",
    event = "BufEdit",

    ---@type Gitsigns.Config
    opts = {
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

            ---@diagnostic disable: need-check-nil
            -- Hunk Navigation
            map("n", "]h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, "Next Hunk")
            map("n", "[h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, "Prev Hunk")
            map("n", "]H", function() gitsigns.nav_hunk("last") end, "Last Hunk")
            map("n", "[H", function() gitsigns.nav_hunk("first") end, "First Hunk")

            -- Hunk Actions
            map({ "n", "x" }, "<leader>hs", ":Gitsigns stage_hunk<cr>", "Stage Hunk")
            map({ "n", "x" }, "<leader>hr", ":Gitsigns reset_hunk<cr>", "Reset Hunk")
            map("n", "<leader>hS", gitsigns.stage_buffer, "Stage Buffer")
            map("n", "<leader>hR", gitsigns.reset_buffer, "Reset Buffer")

            map("n", "<leader>hp", gitsigns.preview_hunk_inline, "Preview Hunk Inline")
            map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, "Blame Line")
            map("n", "<leader>hB", function() gitsigns.blame() end, "Blame Buffer")

            map("n", "<leader>hd", gitsigns.diffthis, "Diff This")
            map("n", "<leader>hD", function() gitsigns.diffthis("~") end, "Diff This ~")

            map("n", "<leader>hl", gitsigns.setqflist, "List Hunks")
            map("n", "<leader>hL", function() gitsigns.setqflist("all") end, "List All Hunks")

            -- Text object
            map({ "o", "x" }, "ih", gitsigns.select_hunk, "GitSigns Select Hunk")
        end,
    },
}
