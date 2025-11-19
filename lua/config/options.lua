local o = vim.o

o.autowrite = true -- Enable auto write

-- Enable relative line numbers
o.number = true
o.relativenumber = true

o.clipboard = "unnamedplus" -- Use system clipboard
o.ignorecase = true         -- Ignore case
o.smartcase = true          -- Don't ignore case with capitals

-- Indent
o.smartindent = true -- Insert indents automatically
o.shiftround = true  -- Round indent
o.shiftwidth = 2     -- Size of an indent
o.expandtab = true   -- Use spaces instead of tabs
o.tabstop = 2        -- Number of spaces tabs count for

o.cursorline = true  -- Highlight current line
o.mouse = "a"        -- Enable mouse
o.confirm = true     -- Confirm to save changes before exiting modified buffer
o.showmode = false   -- Don't show mode since we have a statusline

-- Split Window from below and right
o.splitkeep = "screen"
o.splitbelow = true   -- Put new windows below current
o.splitright = true   -- Put new windows right of current

o.signcolumn = "yes"  -- Always show the signcolumn
o.list = true         -- Show some invisible characters
o.scrolloff = 4       -- Lines of context
o.smoothscroll = true -- Enable smooth scrolling
o.jumpoptions = "view"
o.laststatus = 3      -- global statusline
o.linebreak = true    -- Wrap lines at convenient points
o.wrap = false        -- Disable line wrap

-- Folding
o.foldlevel = 99
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"

-- Tabs
o.showtabline = 2

o.termguicolors = true -- True color support

o.sessionoptions = "buffers,curdir,folds,help,localoptions,tabpages,terminal,winpos,winsize"
