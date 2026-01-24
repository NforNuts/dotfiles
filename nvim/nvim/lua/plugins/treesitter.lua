return {
	--=====================
	--   nvim-treesitter
	--=====================
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufWritePre", "BufNewFile", "VeryLazy" },

		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},

		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"diff",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"rust",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = true,

					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
					},

					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
					},
				},

        --stylua: ignore
        move = {
          enable = true,

          goto_next_start = { ["]f"] = "@function.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]A"] = "@parameter.inner"  },
          goto_previous_start = { ["[f"] = "@function.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[A"] = "@parameter.inner" },
        },
			},
		},

		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	--=============================
	--   nvim-treesitter-context
	--=============================
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufWritePre", "BufNewFile" },
		opts = { mode = "cursor", max_lines = 5 },
	},

	--=====================
	--   nvim-ts-autotag
	--=====================
	{
		"windwp/nvim-ts-autotag",
		-- event = { "BufReadPost", "BufWritePre", "BufNewFile" },
		ft = { "html", "javascript", "typescript", "jsx", "tsx", "markdown", "vue", "svelte", "xml" },
		opts = {},
	},
}
