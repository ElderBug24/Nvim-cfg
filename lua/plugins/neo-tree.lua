return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      mappings = {
        ["b"] = function()
          require("neo-tree.command").execute({
            action = "show",
            source = "buffers",
            position = "left",
          })
        end,
        ["f"] = function()
          require("neo-tree.command").execute({
            action = "show",
            source = "filesystem",
            position = "left",
          })
        end,
        ["g"] = function()
          require("neo-tree.command").execute({
            action = "show",
            source = "git_status",
            position = "left",
          })
        end,
      },
    },
  },
}
