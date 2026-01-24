return {
	{
		"mason-org/mason-lspconfig.nvim",

		dependencies = {
			{ "nvim-lspconfig" },
			{ "mason.nvim" },
		},

		event = { "BufReadPre", "BufNewFile" },

		opts = {
			ensure_installed = {
				"basedpyright",
				"bashls",
				"clangd",
				"gopls",
				"lua_ls",
				"vtsls",
			},
		},

		init = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspKeyBind", { clear = false }),
				callback = function(args)
					local map = function(mode, l, cmd, desc)
						vim.keymap.set(mode, l, cmd, { buffer = args.buf, desc = desc })
					end

          -- stylua: ignore start

          -- Snacks version
          map("n", "gd", function() Snacks.picker.lsp_definitions() end, "Lsp Definition")
          map("n", "grr", function() Snacks.picker.lsp_references() end, "Lsp References")
          map("n", "gri", function() Snacks.picker.lsp_implementations() end, "Lsp Implementations")
          map("n", "grt", function() Snacks.picker.lsp_type_definitions() end, "Lsp Type Definitions")
          map("n", "gO", function() Snacks.picker.lsp_symbols() end, "Lsp Type Definitions")

          -- nvim standard api
          map("n", "gd", vim.lsp.buf.definition, "Lsp Definition")
          map("n", "grr", vim.lsp.buf.references, "Lsp References")
          map("n", "gri", vim.lsp.buf.implementation, "Lsp Implementations")
          map("n", "grt", vim.lsp.buf.type_definition, "Lsp Type Definitions")
          map("n", "gO", vim.lsp.buf.document_symbol, "Lsp Symbols")

          map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
					-- stylua: ignore end
				end,
			})

			vim.lsp.config("clangd", {
				root_dir = vim.fs.root(0, {
					"Makefile",
					"configure.ac",
					"configure.in",
					"config.h.in",
					"meson.build",
					"meson_options.txt",
					"build.ninja",
					".git",
				}),
				capabilities = {
					offsetEncoding = { "utf-16" },
				},
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
			})

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						staticcheck = true,
					},
				},
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "recommended",
						},
					},
				},
			})

			vim.lsp.config("vtsls", {
				settings = {
					complete_function_calls = true,
					vtsls = {
						enableMoveToFileCodeAction = true,
						autoUseWorkspaceTsdk = true,
						experimental = {
							maxInlayHintLength = 30,
							completion = {
								enableServerSideFuzzyMatch = true,
							},
						},
					},
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = {
							completeFunctionCalls = true,
						},
						inlayHints = {
							enumMemberValues = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							variableTypes = { enabled = false },
						},
					},
				},
			})

			vim.diagnostic.config({
				virtual_text = true,
				-- virtual_lines = {
				-- 	current_line = true,
				-- },
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = " ",
						[vim.diagnostic.severity.HINT] = " ",
					},
				},
			})
		end,
	},

	{ "neovim/nvim-lspconfig", lazy = true },
	{
		"mason-org/mason.nvim",
		lazy = true,
		opts = {},
	},
}
