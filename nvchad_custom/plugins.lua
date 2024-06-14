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

	{ "github/copilot.vim", lazy = false },

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
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
		dependencies = { "williamboman/mason.nvim" },
		init = function()
			vim.g.rustaceanvim = function()
				-- Update this path
				local codelldb_root = require("mason-registry").get_package("codelldb"):get_install_path()
					.. "/extension/"
				local codelldb_path = codelldb_root .. "adapter/codelldb"
				local liblldb_path = codelldb_root .. "lldb/lib/liblldb"
				local this_os = vim.loop.os_uname().sysname

				-- The path is different on Windows
				if this_os:find("Windows") then
					codelldb_path = extension_path .. "adapter\\codelldb.exe"
					liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
				else
					-- The liblldb extension is .so for Linux and .dylib for MacOS
					liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
				end

				local cfg = require("rustaceanvim.config")
				return {
					dap = {
						adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
						configuration = {
							name = "Rust debug client",
							type = "codelldb",
							request = "launch",
							stopOnEntry = false,
						},
					},
				}
			end
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
			local cmp = require("cmp")

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

			opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					local copilot_keys = vim.fn["copilot#Accept"]()
					if copilot_keys ~= "" then
						vim.api.nvim_feedkeys(copilot_keys, "i", true)
					elseif require("luasnip").expand_or_jumpable() then
						vim.fn.feedkeys(
							vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
							""
						)
					else
						fallback()
					end
				end
			end, {
				"i",
				"s",
			})

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

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
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
			{ "github/copilot.vim" }, -- or github/copilot.vim
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
