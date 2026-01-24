return {
	{
		"stevearc/conform.nvim",

		event = { "BufWritePre" },
		dependencies = { "mason.nvim" },
		cmd = "ConformInfo",
		lazy = true,

		opts = {
			formatters_by_ft = {
				go = { "goimports", "gofumpt" },
				lua = { "stylua" },
				-- python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},

			formatters = {
				["clang-format"] = {
					prepend_args = { "--style=file", "--fallback-style=LLVM" },
				},
			},

			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},

	{
		"mfussenegger/nvim-lint",

		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},

		config = function(_, opts)
			local lint = require("lint")
			lint.linters_by_ft = {
				python = { "ruff" },
				javascript = { "biome_js" },
				typescript = { "bioem_js" },
			}

			lint.linters.biome_js = {
				name = "biome_js",
				cmd = "biome",
				stdin = true,
				ignore_exitcode = true,
				args = {
					"lint",
					"--stdin-file-path",
					function()
						return vim.fn.expand("%:t")
					end,
				},
				stream = "stdout",
				parser = function(output)
					local diagnostics = {}

					-- The diagnostic details we need are spread in the first 3 lines of
					-- each error report.  These variables are declared out of the FOR
					-- loop because we need to carry their values to parse multiple lines.
					local fetch_message = false
					local lnum, col, code, message

					-- When a lnum:col:code line is detected fetch_message is set to true.
					-- While fetch_message is true we will search for the error message.
					-- When a error message is detected, we will create the diagnostic and
					-- set fetch_message to false to restart the process and get the next
					-- diagnostic.
					for _, line in ipairs(vim.fn.split(output, "\n")) do
						if fetch_message then
							_, _, message = string.find(line, "%s×(.+)")

							if message then
								message = (message):gsub("^%s+×%s*", "")

								table.insert(diagnostics, {
									source = "biomejs",
									lnum = tonumber(lnum) - 1,
									col = tonumber(col),
									message = message,
									code = code,
								})

								fetch_message = false
							end
						else
							_, _, lnum, col, code = string.find(line, "[^:]+:(%d+):(%d+)%s([%a%/]+)")

							if lnum then
								fetch_message = true
							end
						end
					end

					return diagnostics
				end,
			}

			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
