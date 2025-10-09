return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  {
    "folke/noice.nvim",

    opts = {
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
    "folke/snacks.nvim",

    keys = {
      {
        "<leader>:",
        function()
          Snacks.picker.command_history({
            layout = {
              layout = {
                row = vim.api.nvim_win_get_height(vim.api.nvim_get_current_win()) * 0.3 - 1,
                position = "float",
              },
            },
          })
        end,
        desc = "Command History",
      },
    },

    opts = function(_, opts)
      opts.dashboard = {
        preset = {
          header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████]],
        },
      }

      opts.terminal.win.keys.nav_h = false
      opts.terminal.win.keys.nav_l = false

      opts.picker.win.input.keys["<c-l>"] = false
      opts.picker.win.input.keys["<c-h>"] = false

      opts.picker.exclude = {
        ".git",
        ".cache",
        "node_modules",
        "Library",
        "Applications",
      }

      opts.picker.sources = {
        explorer = {
          hidden = true,
          auto_close = true,
          layout = {
            layout = {
              position = "right",
            },
          },
        },
      }

      return opts
    end,
  },
}
