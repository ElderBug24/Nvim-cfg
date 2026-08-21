---@type LazySpec
return {
  {
    "snacks.nvim",
    opts = function(_, opts)
      opts.dashboard = opts.dashboard or {}
      opts.dashboard.preset = opts.dashboard.preset or {}
      opts.dashboard.preset.keys = {
        {
          key = "n",
          action = ":ene | startinsert",
          icon = " ",
          desc = "New File",
        },
        {
          key = "f",
          action = function() return require("fff").find_files() end,
          icon = " ",
          desc = "Find File",
        },
        {
          key = "o",
          action = "<Leader>fo",
          icon = "󰈙 ",
          desc = "Recents",
        },
        {
          key = "g",
          action = function() return require("fff").live_grep() end,
          icon = "󰈭 ",
          desc = "Find Word",
        },
        {
          key = "z",
          action = function()
            return require("fff").live_grep {
              grep = { modes = { "fuzzy", "plain" } },
            }
          end,
          icon = "󰈭 ",
          desc = "Find Word (Fuzzy)",
        },
        {
          key = "'",
          action = "<Leader>fk",
          icon = " ",
          desc = "Bookmarks",
        },
        {
          key = "s",
          action = "<Leader>Sl",
          icon = " ",
          desc = "Last Session",
        },
      }
    end,
  },
}
