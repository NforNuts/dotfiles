return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"sindrets/diffview.nvim",
			cmd = { "DiffviewOpen", "DiffviewClose" },
			opts = {},
		},

		"nvim-telescope/telescope.nvim",
	},

	cmd = { "Neogit" },
	opts = {},
}
