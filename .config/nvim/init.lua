------------------------------- Options -------------------------------
-- :help options
vim.opt.backup = false            -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 2             -- more space in the neovim command line for displaying messages
vim.opt.conceallevel = 0          -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"    -- the encoding written to a file
vim.opt.hlsearch = true           -- highlight all matches on previous search pattern
vim.opt.ignorecase = true         -- ignore case in search patterns
vim.opt.smartcase = true          -- case-sensitive when pattern containing uppercase characters
vim.opt.mouse = "a"               -- allow the mouse to be used in neovim
vim.opt.pumheight = 10            -- pop up menu height
vim.opt.showtabline = 2           -- always show tabs
vim.opt.smartindent = true        -- make indenting smarter again
vim.opt.splitbelow = true         -- force all horizontal splits to go below current window
vim.opt.splitright = true         -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false          -- creates a swapfile
vim.opt.termguicolors = true      -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000         -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true           -- enable persistent undo
vim.opt.updatetime = 300          -- faster completion (4000ms default)
vim.opt.writebackup = false       -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true          -- convert tabs to spaces
vim.opt.shiftwidth = 2            -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2               -- insert 2 spaces for a tab
vim.opt.cursorline = true         -- highlight the current line
vim.opt.number = true             -- set numbered lines
vim.opt.relativenumber = false    -- set relative numbered lines
vim.opt.signcolumn = "yes"        -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false              -- display lines as one long line
vim.opt.scroll = 10               -- number of lines to scroll with CTRL-D and CTRL-U
vim.opt.scrolloff = 8             -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications

-- apply options to :help pages
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.scroll = 10
    vim.opt_local.scrolloff = 8
    vim.opt_local.ignorecase = true
    vim.opt_local.smartcase = true
  end,
})

------------------------------- Global Keymap -------------------------------
local opts = { noremap = true }
local keymap = vim.keymap.set

-- remap space as leader key
keymap("", "<space>", "<nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--   normal_mode = "n",
-- keymap("n", "<C-d>", "<C-d>zz", opts)
-- keymap("n", "<C-u>", "<C-u>zz", opts)

--   visual_mode = "v",
-- stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

--   term_mode = "t",
keymap("t", "<C-[>", "<C-\\><C-N>", opts) -- Exit terminal mode

--   insert_mode = "i",

--   visual_block_mode = "x",

--   command_mode = "c"


------------------------------- Colorscheme -------------------------------
vim.pack.add({ "https://github.com/catppuccin/nvim" })
require("catppuccin").setup({
  flavour = "frappe"
})
vim.cmd.colorscheme "catppuccin"

------------------------------- LSP -------------------------------
-- get some quickstart configs rather than reinvent everything 
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
-- lua_ls
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } }
    }
  }
})
vim.lsp.enable("lua_ls")
-- rust-analyzer
vim.lsp.config("rust_analyzer", {
  settings = {
    ['rust-analyzer'] = {}
  }
})
vim.lsp.enable("rust_analyzer")

-- LSP keymap and autocommands
-- :help lsp-attach
vim.api.nvim_create_autocmd("LspAttach", {
  -- args can be found in :help nvim_create_autocmd
  callback = function(args)
    local lsp_keymap_opts = { buffer = args.buf }
    -- Displays hover information about the symbol under the cursor
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', lsp_keymap_opts )

    -- Jump to the definition
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', lsp_keymap_opts )

    -- Jump to declaration
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', lsp_keymap_opts )

    -- Lists all the implementations for the symbol under the cursor
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', lsp_keymap_opts )

    -- Jumps to the definition of the type symbol
    vim.keymap.set('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', lsp_keymap_opts )

    -- Lists all the references
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', lsp_keymap_opts )

    -- Displays a function's signature information
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', lsp_keymap_opts )

    -- Renames all references to the symbol under the cursor
    vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', lsp_keymap_opts )

    -- Selects a code action available at the current cursor position
    vim.keymap.set({ 'n', 'v' }, '<space>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', lsp_keymap_opts)

    -- Show diagnostics in a floating window
    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', lsp_keymap_opts )

    -- Move to the previous diagnostic
    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', lsp_keymap_opts )

    -- Move to the next diagnostic
    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', lsp_keymap_opts )

    -- Format
    vim.keymap.set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', lsp_keymap_opts )
  end
})

----------------------- Plugin: nvim-cmp, cmp-nvim-lsp, cmp-buffer -----------------------
------------------------- code completion / suggestion dropdown --------------------------
vim.pack.add({
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
})
local cmp = require("cmp")
cmp.setup({
  sources = cmp.config.sources({
    -- group of higher priority
    { name = "nvim_lsp" },
  }, {
    -- group of lower priority (can add more groups if needed)
    { name = "buffer" },
  }),
  mapping = cmp.mapping.preset.insert({
    -- Set `select` to `false` to only confirm explicitly selected items, 
    -- `true` to accept currently selected item.
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),
  -- required but not really useful to me
  -- just use Neovim's native snippet to avoid extra dependency
  snippet = {
    expand = function(args)
        vim.snippet.expand(args.body)
    end,
  },
})
-- integrate LSP into nvim-cmp
vim.lsp.config('*', {
  capabilities = require("cmp_nvim_lsp").default_capabilities()
})

---------------------------- Plugin: mini.pairs ----------------------------
------------------------- minimal and fast autopairs -----------------------
vim.pack.add({ "https://github.com/nvim-mini/mini.pairs" })
require("mini.pairs").setup()

---------------------------- Plugin: telescope ----------------------------
------------------------------- fuzzy finder ------------------------------
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim", -- dependency
  "https://github.com/nvim-telescope/telescope.nvim",
})
require("telescope").setup()

-- Use telescope-fzf-native.nvim to improve sorting performance, which needs to be built locally
local build_fzf = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
    vim.system({ 'make' }, { cwd = ev.data.path }):wait()
  end
end
vim.api.nvim_create_autocmd('PackChanged', { callback = build_fzf })
vim.pack.add({ "https://github.com/nvim-telescope/telescope-fzf-native.nvim" })
require("telescope").load_extension("fzf")

-- ripgrep is required for live_grep, which can be installed via package manager

-- Keymaps for telescope
local tele_builtin = require('telescope.builtin')
keymap("n", "<leader>f", tele_builtin.find_files, { desc = "Telescope find files" })
keymap("n", "<leader>g", tele_builtin.live_grep, { desc = "Telescope live grep" })

