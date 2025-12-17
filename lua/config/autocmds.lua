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

        local ft_config = lang_parser.get_config_by_ft(args.match)
        if ft_config.on_attach_buf then ft_config.on_attach_buf(args.buf) end
    end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if not vim.tbl_contains(filetypes, ft) then return end

        local winid = vim.api.nvim_get_current_win()
        vim.wo[winid].foldmethod = "expr"
        vim.wo[winid].foldexpr = "v:lua.vim.treesitter.foldexpr()"

        local ft_config = lang_parser.get_config_by_ft(ft)
        if ft_config and ft_config.on_attach_win then ft_config.on_attach_win(winid, args.buf) end
    end,
})
