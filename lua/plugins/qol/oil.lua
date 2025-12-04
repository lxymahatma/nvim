-- Buffer like Filesystem
---@type LazyPluginSpec
return {
    "stevearc/oil.nvim",

    ---@type oil.SetupOpts
    opts = {
        default_file_explorer = false,
        columns = {
            "icon",
        },
        buf_options = {
            buflisted = false,
            bufhidden = "hide",
        },
        delete_to_trash = false,
        skip_confirm_for_simple_edits = true,
        lsp_file_methods = {
            enabled = true,
            timeout_ms = 1000,
            autosave_changes = false,
        },
        constrain_cursor = "editable",
        keymaps = {
            ["g?"] = { "actions.show_help", mode = "n" },
            ["<CR>"] = "actions.select",
            ["\\"] = { "actions.select", opts = { horizontal = true } },
            ["|"] = { "actions.select", opts = { vertical = true } },
            ["<C-t>"] = { "actions.select", opts = { tab = true } },
            ["<C-r>"] = "actions.refresh",
            ["<S-h>"] = { "actions.toggle_hidden", mode = "n" },
            ["-"] = { "actions.parent", mode = "n" },
            ["_"] = { "actions.open_cwd", mode = "n" },
            ["`"] = { "actions.cd", mode = "n" },
            ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
            ["gs"] = { "actions.change_sort", mode = "n" },
            ["gx"] = "actions.open_external",
        },
        use_default_keymaps = false,
        view_options = {
            show_hidden = true,
        },
    },
}
