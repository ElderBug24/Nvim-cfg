-- if true then return {} end

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        -- "lua-language-server",
        -- "stylua",
        -- "debugpy",
        -- "tree-sitter-cli",
      },
      automatic_enable = false
    },
  },
}
