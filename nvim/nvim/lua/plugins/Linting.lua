return {
  "mfussenegger/nvim-lint",

  opts = function(_, opts)
    opts.linters = {
      biome_js = {
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
      },
    }
    return opts
  end,
}
