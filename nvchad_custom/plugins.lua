local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options
	{
		"okuuva/auto-save.nvim",
		event = { "InsertLeave", "TextChanged" },
		lazy = false,
		opts = {
			debounce_delay = 100,
			enabled = true,
		},
	},

	{ "tpope/vim-fugitive", lazy = false },

	{ "tpope/vim-surround", lazy = false },

	{ "tpope/vim-repeat", lazy = false },

	{
		"zbirenbaum/copilot.lua",
		lazy = false,
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup(overrides.copilot)
		end,
	},

	{ "mg979/vim-visual-multi", lazy = false },

	{ "mfussenegger/nvim-dap", lazy = false },

	{ "rust-lang/rust.vim" },

	{
		"rcarriga/nvim-dap-ui",
		config = function()
			require("dapui").setup()
		end,
	},

	{
		"saecki/crates.nvim",
		tag = "stable",
		config = function()
			require("crates").setup()
		end,
	},

	{
		"David-Kunz/cmp-npm",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "json",
		config = function()
			require("cmp-npm").setup({
				only_semantic_versions = false,
			})
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local opts = require("plugins.configs.cmp")

			opts.completion = {
				completeopt = "menu,menuone,noselect,noinsert",
			}

			opts.sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "crates" },
				{ name = "npm", keyword_length = 4 },
			}

			return opts
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "User FilePost",
		opts = overrides.gitsigns,
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "git")
			require("gitsigns").setup(opts)
		end,
	},

	{
		"stevearc/conform.nvim",
		--  for users those who want auto-save conform + lazyloading!
		-- event = "BufWritePre"
		config = function()
			require("custom.configs.conform")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = "Telescope",
		init = function()
			require("core.utils").load_mappings("telescope")
		end,
		opts = function()
			return require("custom.configs.telescope")
		end,
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "telescope")
			local telescope = require("telescope")
			telescope.setup(opts)

			-- load extensions
			for _, ext in ipairs(opts.extensions_list) do
				telescope.load_extension(ext)
			end
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = false, -- Enable debugging
			window = {
				width = 0.4,
			},
		},
		lazy = false,
		-- See Commands section for default commands if you want to lazy load on them
	},

	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = false,
		init = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
					javascript = "rainbow-parens",
					tsx = "rainbow-parens",
				},
				priority = {
					[""] = 110,
					lua = 210,
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},
}

return plugins
