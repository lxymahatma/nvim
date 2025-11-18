vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("quit", { clear = true }),
    pattern = {
        "checkhealth",
        "grug-far",
        "help",
        "man",
        "notify",
        "qf",
        "vim",
    },
    callback = function(args)
        vim.bo[args.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
            end, {
                buffer = args.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})

local tab_helper = require("helpers.tab")
local tabscope_group = vim.api.nvim_create_augroup("tabscope", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    group = tabscope_group,
    callback = function(args)
        if vim.api.nvim_get_option_value("buflisted", { buf = args.buf }) then tab_helper.add_buffer_to_current_tab(args.buf) end
    end,
})

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
    group = tabscope_group,
    callback = function(args) tab_helper.remove_buffer(args.buf) end,
})

vim.api.nvim_create_autocmd("TabEnter", { group = tabscope_group, callback = tab_helper.on_tab_enter })
vim.api.nvim_create_autocmd("TabLeave", { group = tabscope_group, callback = tab_helper.on_tab_leave })
vim.api.nvim_create_autocmd("TabClosed", { group = tabscope_group, callback = tab_helper.on_tab_close })
vim.api.nvim_create_autocmd("TabNewEntered", { group = tabscope_group, callback = tab_helper.on_tab_new_entered })

vim.api.nvim_create_autocmd("User", {
    group = tabscope_group,
    pattern = "PersistenceSavePost",
    callback = function()
        vim.schedule(function() tab_helper.save_tabscope() end)
    end,
})

vim.api.nvim_create_autocmd("User", {
    group = tabscope_group,
    pattern = "PersistenceLoadPost",
    callback = function()
        vim.schedule(function() tab_helper.load_tabscope() end)
    end,
})
