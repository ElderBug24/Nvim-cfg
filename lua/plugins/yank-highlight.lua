return {
  "AstroNvim/astroui",
  -- opts = {
  --   highlights = {
  --     init = {
  --       IncSearch = {
  --         bg = "#89b4fa",
  --         fg = "#1e1e2e",
  --       },
  --     },
  --   },
  -- },
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          highlightyank = {
            {
              event = "TextYankPost",
              callback = function()
                vim.highlight.on_yank({
                  higroup = "IncSearch",
                  timeout = 50,
                })
              end,
            },
          },
        },
      },
    },
  },
}
