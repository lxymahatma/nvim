vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("quit", { clear = true }),
  pattern = {
    "checkhealth",
    "grug-far",
    "help",
    "man",
    "qf",
    "vim",
  },
  callback = function(args)
    vim.bo[args.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set(
        "n", "q",
        function()
          vim.cmd("close")
          pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
        end,
        {
          buffer = args.buf,
          silent = true,
          desc = "Quit buffer",
        }
      )
    end)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("Treesitter", { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang or not vim.treesitter.language.add(lang) then return end
    vim.treesitter.start(args.buf, lang)

    if vim.treesitter.query.get(lang, "folds") then
      vim.wo[0][0].foldmethod = "expr"
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
    if vim.treesitter.query.get(lang, "indents") then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

local toolchain = require("toolchain")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("Toolchain", { clear = true }),
  callback = function(args)
    local cfg = toolchain.get_config_by_ft(args.match)
    if not cfg then return end

    for _, on_attach in ipairs(cfg.on_attach) do
      on_attach(args.buf)
    end
  end,
})
