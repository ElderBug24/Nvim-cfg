-- if true then return {} end

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "clangd",
        "stylua",
        -- "debugpy",
        "tree-sitter-cli",
      },
    },
  },
}
