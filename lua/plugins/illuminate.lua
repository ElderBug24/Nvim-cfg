return {
  {
    "RRethy/vim-illuminate",
    opts = function(_, opts)
      opts.delay = 0
      opts.providers = { "lsp", "regex" }
    end,
  },
}
