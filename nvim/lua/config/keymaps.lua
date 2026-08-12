-- This file set keymaps for default nvim features
-- Per plugin keymaps are set in their respective config files

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function noremap(mode, keymap, action, description)
    vim.keymap.set(mode, keymap, action, { desc = description, silent = true, noremap = true })
end

local function remap(mode, keymap, action, description)
    vim.keymap.set(mode, keymap, action, { desc = description, silent = true, remap = true })
end

vim.keymap.del('n', '<C-w>d')
vim.keymap.del('n', '<C-w><C-d>')

-------------------Utils------------------
noremap("i", "<M-BS>", "<C-w>", "Delete previous word")
noremap("i", "<C-BS>", "<C-w>", "Delete previous word")
noremap({ "n", "v", "i" }, "<C-s>", "<Cmd>w<CR>", "Save")
noremap("n", "<leader><BS>", "J", "Collapse line above")

-- Move
noremap({ "n", "v" }, "<S-h>", "b", "Fast movement left")
noremap({ "n", "v" }, "<S-l>", "w", "Fast movement right")

-- Move through windows
noremap("n", "<C-h>", "<C-w>h", "Move to left window")
noremap("n", "<C-l>", "<C-w>l", "Move to right window")
noremap("n", "<C-j>", "<C-w>j", "Move to bottom window")
noremap("n", "<C-k>", "<C-w>k", "Move to top window")

-- Move through windows
noremap("n", "<C-t>", "<CMD>tabn<CR>", "Move to next tabpage")
noremap("n", "<C-S-t>", "<CMD>tabp<CR>", "Move to previous tabpage")

-- Resize windows
local function toggle_fullscreen()
	if vim.bo.filetype == "NvimTree" then
		return
	end

	local buf_width = vim.api.nvim_win_get_width(0)
	local buf_height = vim.api.nvim_win_get_height(0)
	if buf_width >= vim.api.nvim_get_option("columns") - 10 and buf_height >= vim.api.nvim_get_option("lines") - 10 then
		vim.api.nvim_command("wincmd =")
	else
		vim.api.nvim_command("wincmd |")
		vim.api.nvim_command("wincmd _")
	end
end

noremap("n", "<C-A-h>", "7<C-w><")
noremap("n", "<C-A-l>", "7<C-w>>")
noremap("n", "<C-A-j>", "7<C-w>+")
noremap("n", "<C-A-k>", "7<C-w>-")
noremap("n", "<C-f>", toggle_fullscreen, "Toggle fullscreen window")

-- Move lines with alt key
noremap("n", "<A-j>", ":m +1<CR>==", "Move the current line one downward")
noremap("n", "<A-k>", ":m -2<CR>==", "Move the current line one upward")
noremap("v", "<A-j>", ":m '>+1<CR>gv=gv", "move the selected lines one downward")
noremap("v", "<A-k>", ":m '<-2<CR>gv=gv", "move the selected line one upward")

-- Some cool shortcut to add line ends
noremap("n", "<leader>;", "<s-a>;<ESC>", 'Add ";" at the end of the current line')
noremap("n", "<leader>,", "<s-a>,<ESC>", 'Add "," at the end of the current line')
noremap("n", "<leader>:", "<s-a>:<ESC>", 'Add ":" at the end of the current line')

-- Switch off highlighting
noremap("n", "µ", "<Cmd>noh<CR>", "Switch off highlighting")

-- Commmenting
remap("n", "<C-/>", "gcc", "Toggle comment on current line") -- qwerty
remap("v", "<C-/>", "gc", "Toggle comments on selected lines") -- qwerty

remap("n", "<C-:>", "gcc", "Toggle comment on current line") -- azerty
remap("v", "<C-:>", "gc", "Toggle comments on selected lines") -- azerty
