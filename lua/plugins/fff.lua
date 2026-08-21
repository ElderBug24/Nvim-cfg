---@type LazySpec
return {
  {
    "dmtrKovalenko/fff.nvim",
    build = function() require("fff.download").download_or_build_binary() end,
    opts = {
      debug = {
        enabled = true,
        show_scores = true,
      },
    },
    lazy = false,
    keys = {
      {
        "ff",
        function() return require("fff").find_files() end,
        desc = "Find files",
      },
      {
        "fg",
        function() return require("fff").live_grep() end,
        desc = "Live grep",
      },
      {
        "fz",
        function()
          return require("fff").live_grep {
            grep = { modes = { "fuzzy", "plain" } },
          }
        end,
        desc = "Fuzzy grep",
      },
      {
        "fc",
        function()
          return require("fff").live_grep {
            query = vim.fn.expand "<cword>",
          }
        end,
        desc = "Search current word",
      },
      {
        "Ff",
        function()
          return require("fff").find_files {
            cwd = vim.fn.input("Directory: ", "", "dir"),
          }
        end,
        desc = "Find files in directory",
      },
      {
        "Fg",
        function()
          return require("fff").live_grep {
            cwd = vim.fn.input("Directory: ", "", "dir"),
          }
        end,
        desc = "Live grep in directory",
      },
      {
        "Fz",
        function()
          return require("fff").live_grep {
            cwd = vim.fn.input("Directory: ", "", "dir"),
            grep = { modes = { "fuzzy", "plain" } },
          }
        end,
        desc = "Fuzzy grep in directory",
      },
      {
        "Fc",
        function()
          return require("fff").live_grep {
            cwd = vim.fn.input("Directory: ", "", "dir"),
            query = vim.fn.expand "<cword>",
          }
        end,
        desc = "Search current word in directory",
      },
    },
  },
}
