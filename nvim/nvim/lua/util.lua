M = {}

M.root = function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	for _, client in pairs(clients or {}) do
		local workspace = client.config.workspace_folders
		for _, ws in pairs(workspace or {}) do
			return vim.uri_to_fname(ws.uri)
		end

		if client.root_dir then
			return client.root_dir
		end
	end

	return vim.uv.cwd()
end

return M
