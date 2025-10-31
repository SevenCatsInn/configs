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

	-- Search tools
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"nvim-telescope/telescope.nvim",
	"nvim-lua/plenary.nvim",

	-- Autocompletion
	"saghen/blink.cmp",
	-- "hrsh7th/nvim-cmp",
	-- "hrsh7th/cmp-nvim-lsp",
	-- "hrsh7th/cmp-nvim-lsp-signature-help",
	-- "hrsh7th/cmp-buffer",
	-- "hrsh7th/cmp-path",

	-- Theming
	"folke/tokyonight.nvim",
	"projekt0n/github-nvim-theme",
	"sainnhe/everforest",
	"xiyaowong/transparent.nvim",

	-- Miscellaneous
	"petertriho/nvim-scrollbar", -- Add scollbar
	"m4xshen/autoclose.nvim",   -- Autoclose brackets
	"tpope/vim-surround",       -- surround commands
	"nvim-tree/nvim-web-devicons", -- Icons
	"stevearc/oil.nvim",        -- Explorer
	"stevearc/aerial.nvim",     -- Outline
	"declancm/cinnamon.nvim",   -- Smooth scroll
})

-- **** GENERAL OPTIONS
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3       -- Lines between windows
vim.opt.signcolumn = "yes:2" -- Left gutter size
vim.g.have_nerd_font = true

-- Colorscheme
vim.cmd.colorscheme("github_dark")
require("transparent").setup({
	-- extra_groups = { 'NormalFloat' },
	exclude_groups = { 'StatusLine', 'StatusLineNC', 'Todo' },
})


-- **** KEYMAPS
vim.g.mapleader = " "

-- Telescope
vim.keymap.set("n", "<leader>sf", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>sg", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>so", ":Telescope aerial<cr>")
vim.keymap.set("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<cr>")
vim.keymap.set('n', '<leader>sm', ":Telescope diagnostics<cr>")
vim.keymap.set('n', '<leader>p', ":Telescope<cr>")


-- LSP
vim.diagnostic.config({ virtual_text = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>l", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>mp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>mn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>mm", vim.diagnostic.setloclist)
vim.keymap.set("n", "gr", ":Telescope lsp_references<cr>")
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]] -- autoformat

-- Git
vim.keymap.set("n", "<leader>hs", ":Gitsigns stage_hunk<cr>")
vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<cr>")
vim.keymap.set("n", "<leader>hn", ":Gitsigns next_hunk<cr>")
vim.keymap.set("n", "<leader>hp", ":Gitsigns prev_hunk<cr>")
vim.keymap.set("n", "<leader>hv", ":Gitsigns preview_hunk_inline<cr>")

-- General
vim.keymap.set("n", "<leader>e", ":Oil<cr>")
vim.keymap.set("n", "<esc>", ":noh<cr>")
vim.keymap.set("i", "jk", "<esc>:w<cr>")         -- insert mode save
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-N>") -- exit terminal



-- **** SETUPS
-- Mason + LSP
require("mason").setup()
require("mason-lspconfig").setup({
	automatic_enable = true
})


-- BLINK CMP
require("blink.cmp").setup({
	keymap = { preset = 'enter' },
	signature = { enabled = true },
	appearance = {
		nerd_font_variant = 'normal',
		use_nvim_cmp_as_default = true,
	}
})


-- Various
require("oil").setup()
require("oil").set_sort({ { "type", "asc" }, { "mtime", "desc" } })
require("scrollbar").setup({
	marks = {
		Cursor = { text = "▢" }
	}
})
require("nvim-treesitter").setup()
require("nvim-web-devicons").setup()
require("gitsigns").setup({
	signs = {
		add          = { text = "+" },
		delete       = { text = "-" },
		change       = { text = "±" },
		changedelete = { text = "±" },
	},
	-- Scrollbar signs
	require("scrollbar.handlers.gitsigns").setup()
})
require("autoclose").setup({
	options = {
		disable_when_touch = true,
		disable_command_mode = true,
	}
})
require("cinnamon").setup({
	keymaps = { basic = true },
	options = { delay = 2 },
})



-- **** FUNCTIONS
-- Toggle diagnostic messages
function ToggleDiagnostics()
	vim.diagnostic.enable(
		not vim.diagnostic.is_enabled()
	)
end

-- Toggle Aerial or focus it
function ToggleAerialFocus()
	local aerial = require "Aerial"
	aerial.setup()
	if not aerial.is_open() then
		aerial.toggle()
	else
		aerial.focus()
	end
end

vim.keymap.set("n", "<leader>o", ToggleAerialFocus)
vim.keymap.set("n", "<leader>mt", ToggleDiagnostics)

----------------------------
-------- OLD STUFF ---------
----------------------------

-- NVIM-CMP, superseeded by BLINK
-- local cmp = require 'cmp'
-- cmp.setup({
-- 	mapping = cmp.mapping.preset.insert({
-- 		['<C-b>'] = cmp.mapping.scroll_docs(-4),
-- 		['<C-f>'] = cmp.mapping.scroll_docs(4),
-- 		['<C-Space>'] = cmp.mapping.complete(),
-- 		['<C-e>'] = cmp.mapping.abort(),
-- 		['<CR>'] = cmp.mapping.confirm({ select = true }),
-- 	}),
-- 	window = {
-- 		-- completion = cmp.config.window.bordered(),
-- 		-- documentation = cmp.config.window.bordered(),
-- 	},
-- 	sources = cmp.config.sources({
-- 		{ name = 'nvim_lsp' },
-- 		{ name = 'nvim_lsp_signature_help' },
-- 		{ name = 'buffer' },
-- 	})
-- })
--
-- Manual transparency (done by extension now)
-- vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
