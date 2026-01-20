-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"

-- vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.wrap = false
vim.opt.inccommand = "split"
vim.opt.jumpoptions = "stack,view"
vim.opt.undolevels = 32000
vim.opt.undofile = true
local undodir = vim.fn.stdpath("data") .. "/undo"
vim.fn.mkdir(undodir, "p")
vim.opt.undodir = undodir
vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.g.minianimate_disable = true
vim.opt.updatetime = 100
vim.opt.shortmess:append("s")
vim.opt.cmdheight = 1
vim.opt.scrolloff = 6
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 16

vim.opt.list = true
vim.opt.listchars = {
  --trail = '¤',       -- shows trailing spaces
  trail = '-',       -- shows trailing spaces
  extends = '⟩',     -- character shown at line end when text extends past screen
  precedes = '⟨',    -- character shown at start when text is hidden off-screen
  nbsp = '␣'         -- shows non-breaking spaces
}

vim.keymap.set('n', '<A-k>', '<Cmd>wincmd k<CR>', { silent = true })
vim.keymap.set('n', '<A-j>', '<Cmd>wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<A-h>', '<Cmd>wincmd h<CR>', { silent = true })
vim.keymap.set('n', '<A-l>', '<Cmd>wincmd l<CR>', { silent = true })

vim.keymap.set('n', '<A-Down>', 'ddjP')
vim.keymap.set('n', '<A-Up>', 'ddkP')
vim.keymap.set('n', '<A-R>', '<Cmd>e!<CR>', { silent = true, desc = 'Reload current file' })

vim.keymap.set('n', '<C-_>', ':ToggleTerm direction=float<CR>', { silent = true, desc = 'Open terminal' })
vim.keymap.set('n', '<leader>c', ':ToggleTerm direction=float<CR>cargo check<CR>', { silent = true, desc = 'cargo check' })
vim.keymap.set('n', '<leader>r', ':ToggleTerm direction=float<CR>cargo run<CR>', { silent = true, desc = 'cargo run' })
vim.keymap.set('n', '<leader>R', ':ToggleTerm direction=float<CR>cargo run --release<CR>', { silent = true, desc = 'cargo run -r' })
vim.keymap.set('t', '<C-_>', '<C-\\><C-n>:ToggleTerm direction=float<CR>', { silent = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })

vim.keymap.set('n', '<leader>to', function() vim.opt.scrolloff = 999 - vim.o.scrolloff end, { silent = true, desc = 'Toggle ' })
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { silent = true })
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', '<leader>e', function()
  require("telescope").extensions.file_browser.file_browser()
end, { silent = true, desc = 'File Explorer' })

vim.keymap.set('n', '<C-a>', 'ggVG', { silent = true })
vim.keymap.del("n", "<C-q>")

vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], { silent = true })
vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], { silent = true })
vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], { silent = true })
vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], { silent = true })
vim.cmd[[colorscheme tokyonight]]
-- vim.cmd[[colorscheme kanagawa-paper]]
-- vim.cmd[[colorscheme oldworld]]
-- vim.cmd[[colorscheme eldritch]]

