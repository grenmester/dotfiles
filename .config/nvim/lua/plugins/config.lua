vim.g.autoformat = false

return {
	{ import = "lazyvim.plugins.extras.ai.copilot" },
	{ import = "lazyvim.plugins.extras.coding.luasnip" },
	{ import = "lazyvim.plugins.extras.editor.dial" },
	{ import = "lazyvim.plugins.extras.editor.neo-tree" },
	{ import = "lazyvim.plugins.extras.editor.telescope" },
	{ import = "lazyvim.plugins.extras.formatting.prettier" },
	{ import = "lazyvim.plugins.extras.lang.astro" },
	{ import = "lazyvim.plugins.extras.lang.clangd" },
	{ import = "lazyvim.plugins.extras.lang.json" },
	{ import = "lazyvim.plugins.extras.lang.markdown" },
	{ import = "lazyvim.plugins.extras.lang.python" },
	{ import = "lazyvim.plugins.extras.lang.tailwind" },
	{ import = "lazyvim.plugins.extras.lang.yaml" },
	{ import = "lazyvim.plugins.extras.linting.eslint" },
	{ import = "lazyvim.plugins.extras.ui.indent-blankline" },
	{ import = "lazyvim.plugins.extras.ui.treesitter-context" },
	{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
	{ import = "lazyvim.plugins.extras.util.octo" },

	{ "maxmx03/solarized.nvim" },

	{
		"LazyVim/LazyVim",
		opts = { colorscheme = "solarized" },
	},

	{
		"folke/flash.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, false },
		},
	},

	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"pylint",
				"emmet-language-server",
			},
		},
	},

	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<space>f",
				require("conform").format,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				python = { "pylint" },
			},
		},
	},
}
