vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("quit", { clear = true }),
    pattern = {
        "checkhealth",
        "gitsigns-blame",
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

local lang_parser = require("langs.lang-parser")
local filetypes = lang_parser.get_filetypes()
local group = vim.api.nvim_create_augroup("LangConfig", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = filetypes,
    callback = function(args)
        vim.treesitter.start()

        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

        local ft_config = lang_parser.get_config_by_ft(args.match)
        if ft_config.on_attach then ft_config.on_attach(args.buf) end
    end,
})
