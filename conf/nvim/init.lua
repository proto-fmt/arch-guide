-- Basic settings
vim.opt.number = true          -- Line numbers
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.tabstop = 4            -- Tab size in spaces
vim.opt.shiftwidth = 4         -- Indent size for > and <
vim.opt.expandtab = false       -- Convert tabs to spaces
vim.opt.autoindent = true      -- Auto indentation
vim.opt.smartindent = true     -- Smart indentation

-- Search settings
vim.opt.ignorecase = true      -- Ignore case when searching
vim.opt.smartcase = true       -- Case sensitive if capital letters present
vim.opt.hlsearch = true        -- Highlight search results
vim.opt.incsearch = true       -- Incremental search

-- UI settings
vim.opt.termguicolors = true   -- True color support
vim.opt.signcolumn = "yes"     -- Always show sign column
vim.opt.cursorline = true      -- Highlight current line
vim.opt.wrap = false           -- Don't wrap long lines
vim.opt.scrolloff = 8          -- Minimum lines to screen edge when scrolling
vim.opt.sidescrolloff = 8      -- Minimum columns to screen edge

-- File handling
vim.opt.encoding = "utf-8"     -- File encoding
vim.opt.fileencoding = "utf-8" -- File encoding
vim.opt.backup = false         -- No backup files
vim.opt.writebackup = false    -- No backup while writing
vim.opt.swapfile = false       -- No swap files

-- Other useful settings
vim.opt.mouse = "a"            -- Enable mouse in all modes
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.opt.timeoutlen = 300       -- Timeout for mappings
vim.opt.updatetime = 300       -- Update time for CursorHold
