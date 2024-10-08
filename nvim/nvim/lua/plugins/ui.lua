return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  {
    "folke/noice.nvim",

    opts = {
      messages = {
        view = "mini",
      },
      views = {
        cmdline_popup = {
          position = {
            row = "30%",
          },
        },
      },
      presets = {
        bottom_search = false,
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local logo = [[
                                                                               
                                                                             
               ████ ██████           █████      ██                     
              ███████████             █████                             
              █████████ ███████████████████ ███   ███████████   
             █████████  ███    █████████████ █████ ██████████████   
            █████████ ██████████ █████████ █████ █████ ████ █████   
          ███████████ ███    ███ █████████ █████ █████ ████ █████  
         ██████  █████████████████████ ████ █████ █████ ████ ██████ 
                                                                               ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
