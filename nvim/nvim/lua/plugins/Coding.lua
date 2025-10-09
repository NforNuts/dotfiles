return {
  {
    "nvim-mini/mini.pairs",

    enabled = false,

    opts = {
      mappings = {
        [" "] = {
          action = "closeopen",
          pair = "  ",
          neigh_pattern = "[%(%[{<][%s]*[%]})>]",
        },
      },
    },
  },

  {
    "saghen/blink.cmp",

    opts = {
      sources = {
        providers = {
          cmdline = {
            min_keyword_length = function(ctx)
              if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
                return 3
              end
              return 0
            end,
          },
        },
      },
    },
  },
}
