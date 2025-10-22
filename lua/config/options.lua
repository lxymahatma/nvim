local opt = vim.opt

opt.autowrite = true -- Enable auto write

-- Enable relative line numbers
opt.number = true
opt.relativenumber = true

opt.clipboard = "unnamedplus" -- Use system clipboard
opt.ignorecase = true         -- Ignore case
opt.smartcase = true          -- Don't ignore case with capitals

-- Indent
opt.smartindent = true -- Insert indents automatically
opt.shiftround = true  -- Round indent
opt.shiftwidth = 2     -- Size of an indent
opt.expandtab = true   -- Use spaces instead of tabs
opt.tabstop = 2        -- Number of spaces tabs count for

opt.cursorline = true  -- Highlight current line
opt.mouse = "a"        -- Enable mouse
opt.confirm = true     -- Confirm to save changes before exiting modified buffer
opt.showmode = false   -- Don't show mode since we have a statusline

-- Split Window from below and right
opt.splitkeep = "screen"
opt.splitbelow = true   -- Put new windows below current
opt.splitright = true   -- Put new windows right of current

opt.signcolumn = "yes"  -- Always show the signcolumn
opt.list = true         -- Show some invisible characters
opt.scrolloff = 4       -- Lines of context
opt.smoothscroll = true -- Enable smooth scrolling
opt.jumpoptions = "view"
opt.laststatus = 3      -- global statusline
opt.linebreak = true    -- Wrap lines at convenient points
opt.wrap = false        -- Disable line wrap

-- Folding
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.termguicolors = true -- True color support
