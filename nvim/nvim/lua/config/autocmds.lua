vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	pattern = { "help", "qf", "git", "fugitive", "grug-far", "neotest-output", "neotest-output-panel" },
	callback = function(args)
		vim.bo[args.buf].buflisted = false
		vim.schedule(function()
			local close_buffer = function()
				-- vim.cmd("close")
				vim.cmd("q")
				pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
			end

      -- stylua: ignore start
			vim.keymap.set("n", "q", close_buffer, { buffer = args.buf, silent = true, desc = "Close buffer", nowait = true })
			vim.keymap.set("n", "<esc>",close_buffer,{ buffer = args.buf, silent = true, desc = "Close buffer", nowait = true })
			-- stylua: ignore end
		end)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function(args)
		vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>", { buffer = args.buf })
	end,
})

local hlg = vim.api.nvim_create_augroup("hl_cursorline_on_recording", { clear = true })
vim.api.nvim_create_autocmd({ "RecordingEnter" }, {
	group = hlg,
	callback = function()
		vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
	end,
})
vim.api.nvim_create_autocmd({ "RecordingLeave" }, {
	group = hlg,
	callback = function()
		vim.api.nvim_set_hl(0, "CursorLine", { underline = false })
	end,
})
