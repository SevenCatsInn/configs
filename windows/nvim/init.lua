require("paq")({
	-- Paq manager
	"savq/paq-nvim",

	-- LSP, Mason, Treesitter
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"nvim-treesitter/nvim-treesitter",

	-- Git
	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",

	-- LaTeX
	"lervag/vimtex",

	-- Search tools
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"nvim-telescope/telescope.nvim",
	"nvim-lua/plenary.nvim", -- telescope dep

	-- Autocompletion
	"saghen/blink.cmp",

	-- Theming
	"folke/tokyonight.nvim",
	"projekt0n/github-nvim-theme",
	"xiyaowong/transparent.nvim",

	-- Miscellaneous
	"tpope/vim-surround",       -- surround commands
	"petertriho/nvim-scrollbar", -- Add scollbar
	"declancm/cinnamon.nvim",   -- Smooth scroll
	-- "m4xshen/autoclose.nvim",   -- Autoclose brackets
	"nvim-tree/nvim-web-devicons", -- Icons
	"stevearc/oil.nvim",        -- Explorer
	"stevearc/aerial.nvim",     -- Outline
})



-- *** GENERAL OPTIONS
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.shell = "pwsh"
vim.opt.number = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3       -- Lines between windows
vim.opt.signcolumn = "yes:2" -- Left gutter size
vim.g.have_nerd_font = true

-- Colorscheme
vim.cmd.colorscheme("github_dark")
require("transparent").setup({
	exclude_groups = { 'StatusLine', 'StatusLineNC', 'Todo' },
	-- extra_groups = { 'NormalFloat' },
})



-- *** KEYMAPS
vim.g.mapleader = " "

-- Telescope
vim.keymap.set("n", "<leader>sf", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>j", ":Telescope buffers<cr><esc>")
vim.keymap.set("n", "<leader>sg", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>sw", ":Telescope grep_string<cr>") --search word under cursor
vim.keymap.set("n", "<leader>so", ":Telescope aerial<cr>")
vim.keymap.set("n", "<leader>sr", ":Telescope resume<cr>")
vim.keymap.set("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<cr>")
vim.keymap.set('n', '<leader>sm', ":Telescope diagnostics<cr>")
vim.keymap.set('n', '<leader>p', ":Telescope<cr>")

-- LSP
vim.diagnostic.config({ virtual_text = true }) -- enable virt text diagnostics
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gR", ":Telescope lsp_references<cr>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>l", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>mp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>mn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>mm", vim.diagnostic.setloclist)
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]] -- format on save

-- Gitsigns, hunk navigation
vim.keymap.set("n", "<leader>hs", ":Gitsigns stage_hunk<cr>")
vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<cr>")
vim.keymap.set("n", "<leader>hn", ":Gitsigns next_hunk<cr>")
vim.keymap.set("n", "<leader>hp", ":Gitsigns prev_hunk<cr>")
vim.keymap.set("n", "<leader>hv", ":Gitsigns preview_hunk_inline<cr>")

-- General
vim.keymap.set("n", "<leader>e", ":Oil<cr>")
vim.keymap.set("n", "<esc>", ":noh<cr>") -- esc removes search highlights
vim.keymap.set("n", "yA", "ggyG<C-o>") -- yank all lines
vim.keymap.set("i", "jk", "<esc>:w<cr>l") -- insert mode save by pressing jk

-- Terminal
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-N>") -- exit terminal insert mode w/ esc
vim.keymap.set("t", "<C-l>",  "<C-l>")

-- Python string utils
vim.keymap.set("n", "<leader>di", "o\"\"\"<esc>yypO") -- insert docstring
vim.keymap.set("n", "<leader>cs", "i\'\'<esc>ha<cr><esc>ll") -- cut string in two lines
vim.keymap.set("n", "<leader>cf", "i\'f\'<esc>hha<cr><esc>ll") -- cut f-string in two lines


-- *** SETUPS
-- Mason, LSP, Tresitter
require("mason").setup() -- LSP & formatter package manager
require("mason-lspconfig").setup({ automatic_enable = true })
require("nvim-treesitter").setup()

-- Blink (autocomplete)
require("blink.cmp").setup({
	signature = { enabled = true },
	appearance = {
		nerd_font_variant = 'normal',
		use_nvim_cmp_as_default = true, -- theme
	}
})

-- File explorer (oil)
require("oil").setup({
	view_options = {
		sort = { 
			{ "type", "asc" },
			{ "mtime", "desc" },
		}
	}
}) 

require("nvim-web-devicons").setup() -- nerd icons

-- Scrollbar on the right (w/ diagnostics & git)
require("scrollbar").setup({
	marks = {
		Cursor = { text = "█" }
	}
})

-- Gitsigns
require("gitsigns").setup({
	-- signs in gutter & hunk navigation
	signs = {
		add          = { text = "+" },
		delete       = { text = "-" },
		change       = { text = "~" },
		changedelete = { text = "±" },
	},
	-- Scrollbar interface w/ git signs
	require("scrollbar.handlers.gitsigns").setup()
})

-- Brackets autoclose (disabled)
-- require("autoclose").setup({
-- 	options = {
-- 		disable_when_touch = true,
-- 		disable_command_mode = true,
-- 	}
-- })

-- Smooth scroller (Only enable C-d and C-u)
local cinnamon = require("cinnamon")
cinnamon.setup()
-- Centered scrolling:
vim.keymap.set("n", "<C-U>", function() cinnamon.scroll("<C-U>zz") end)
vim.keymap.set("n", "<C-D>", function() cinnamon.scroll("<C-D>zz") end)


-- *** FUNCTIONS
-- Toggle diagnostic messages
function DiagonsticsToggle()
	vim.diagnostic.enable(
		not vim.diagnostic.is_enabled()
	)
end

-- Toggle Aerial  or focus it
-- NOTE: outline is provided by LSP
function AerialToggleFocus()
	local aerial = require("aerial")
	aerial.setup()
	if not aerial.is_open() then
		aerial.toggle()
	else
		aerial.focus()
	end
end

-- Assign keymaps to the functions above defined
vim.keymap.set("n", "<leader>o", AerialToggleFocus)
vim.keymap.set("n", "<leader>mt", DiagonsticsToggle)
