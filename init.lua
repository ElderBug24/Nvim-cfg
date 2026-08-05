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

vim.keymap.set('n', '<A-k>', '<Cmd>wincmd k<CR>', { silent = true })
vim.keymap.set('n', '<A-j>', '<Cmd>wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<A-h>', '<Cmd>wincmd h<CR>', { silent = true })
vim.keymap.set('n', '<A-l>', '<Cmd>wincmd l<CR>', { silent = true })

vim.keymap.set('n', '<A-Down>', 'ddjP')
vim.keymap.set('n', '<A-Up>', 'ddkP')
vim.keymap.set('n', '<A-Right>', '>>')
vim.keymap.set('n', '<A-Left>', '<<')
vim.keymap.set('n', '<A-R>', '<Cmd>e!<CR>', { silent = true, desc = 'Reload current file' })

vim.keymap.set('n', '<C-_>', ':ToggleTerm direction=float<CR>', { silent = true, desc = 'Open terminal' })
vim.keymap.set('t', '<C-_>', '<C-\\><C-n>:ToggleTerm direction=float<CR>', { silent = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })

vim.keymap.set('n', '<leader>to', function() vim.opt.scrolloff = 999 - vim.o.scrolloff end, { silent = true, desc = 'Toggle ' })
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { silent = true })
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- vim.keymap.set('n', '<leader>e', function()
--   require("telescope").extensions.file_browser.file_browser()
-- end, { silent = true, desc = 'File Explorer' })

vim.keymap.set('n', '<A-a>', 'ggVG', { silent = true })
vim.keymap.del("n", "<C-q>")

vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], { silent = true })
vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], { silent = true })
vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], { silent = true })
vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], { silent = true })
vim.cmd[[colorscheme tokyonight]]
-- vim.cmd[[colorscheme kanagawa-paper]]
-- vim.cmd[[colorscheme oldworld]]
-- vim.cmd[[colorscheme eldritch]]

-- vim.keymap.set('n', '<leader>c', ':ToggleTerm direction=float<CR>cd ' .. vim.fn.expand('%:p:h') .. '<CR>', { silent = true, desc = 'terminal' })
vim.keymap.set('n', '<leader>c', ':ToggleTerm direction=float<CR>', { silent = true, desc = 'terminal' })
-- vim.keymap.set('n', '<leader>c', ':ToggleTerm direction=float<CR>cargo check<CR>', { silent = true, desc = 'cargo check' })
-- vim.keymap.set('n', '<leader>T', ':ToggleTerm direction=float<CR>cargo test<CR>', { silent = true, desc = 'cargo test' })
-- vim.keymap.set('n', '<leader>r', ':ToggleTerm direction=float<CR>cargo run<CR>', { silent = true, desc = 'cargo run' })
-- vim.keymap.set('n', '<leader>R', ':ToggleTerm direction=float<CR>cargo run --release<CR>', { silent = true, desc = 'cargo run -r' })
-- vim.keymap.set('n', '<leader>B', ':ToggleTerm direction=float<CR>cargo build --release<CR>', { silent = true, desc = 'cargo build -r' })

require("toggleterm").setup({
  direction = "float"
})

local replacements = {
    ["−"] = "-",
    ["–"] = "-",
    ["—"] = "-",

    ["“"] = '"',
    ["”"] = '"',
    ["‘"] = "'",
    ["’"] = "'",

    ["\u{00A0}"] = " ",
    ["\u{200B}"] = "",
    ["\u{200C}"] = "",
    ["\u{200D}"] = "",
    ["\u{FEFF}"] = "",
}

local function sanitize(text)
    for from, to in pairs(replacements) do
        text = text:gsub(from, to)
    end
    return text
end

local function sanitize_selection()
    local mode = vim.fn.mode()

    local s = vim.fn.getpos("'<")
    local e = vim.fn.getpos("'>")

    local start_row, start_col = s[2], s[3]
    local end_row, end_col = e[2], e[3]

    local lines = vim.fn.getline(start_row, end_row)

    if mode == "V" then
        for i = 1, #lines do
            lines[i] = sanitize(lines[i])
        end
        vim.fn.setline(start_row, lines)
        return
    end

    if #lines == 0 then return end

    lines[1] = lines[1]:sub(start_col)
    lines[#lines] = lines[#lines]:sub(1, end_col)

    local text = sanitize(table.concat(lines, "\n"))
    local new_lines = vim.split(text, "\n", { plain = true })

    local first = vim.fn.getline(start_row)
    local last = vim.fn.getline(end_row)

    new_lines[1] = first:sub(1, start_col - 1) .. new_lines[1]
    new_lines[#new_lines] = new_lines[#new_lines] .. last:sub(end_col + 1)

    vim.fn.setline(start_row, new_lines)

    if end_row > start_row then
        vim.fn.deletebufline(0, start_row + #new_lines, end_row)
    end
end

vim.api.nvim_create_user_command("SanitizeSelection", sanitize_selection, {})

vim.keymap.set("x", "<leader>s", function()
    vim.cmd("SanitizeSelection")
end)

local function cycle(dir)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()

    local c = line:sub(col + 1, col + 1)
    local b = string.byte(c)
    if not b then
        return
    end

    if b >= string.byte("a") and b <= string.byte("z") then
        c = string.char((b - string.byte("a") + dir + 26) % 26 + string.byte("a"))
    elseif b >= string.byte("A") and b <= string.byte("Z") then
        c = string.char((b - string.byte("A") + dir + 26) % 26 + string.byte("A"))
    else
        return
    end

    line = line:sub(1, col) .. c .. line:sub(col + 2)
    vim.api.nvim_set_current_line(line)
    vim.api.nvim_win_set_cursor(0, { row, col })
end

vim.keymap.set("n", "z2", function()
    cycle(1)
end, { silent = true })

vim.keymap.set("n", "z1", function()
    cycle(-1)
end, { silent = true })

-- vim.keymap.del("i", "<Tab>")

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
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
-- vim.api.nvim_set_option('shiftwidth', 2)
-- vim.api.nvim_set_option('tabstop', 2)

vim.opt.list = true
vim.opt.listchars = {
  --trail = '¤',       -- shows trailing spaces
  trail = '-',       -- shows trailing spaces
  extends = '⟩',     -- character shown at line end when text extends past screen
  precedes = '⟨',    -- character shown at start when text is hidden off-screen
  nbsp = '␣'         -- shows non-breaking spaces
}

vim.keymap.set("n", "<leader>e", function()
  local manager = require("neo-tree.sources.manager")
  local state = manager.get_state("filesystem")

  if state and state.winid and vim.api.nvim_win_is_valid(state.winid) then
    vim.api.nvim_set_current_win(state.winid)
  else
    vim.cmd("Neotree filesystem reveal left")
  end
end, { desc = "Neo-tree focus/open" })

