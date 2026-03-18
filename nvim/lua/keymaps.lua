local noremap = function(mode, keymap, action, description)
    vim.keymap.set(mode, keymap, action, { desc = description, silent = true, noremap = true })
end

local remap = function(mode, keymap, action, description)
    vim.keymap.set(mode, keymap, action, { desc = description, silent = true, remap = true })
end

-------------------Utils------------------
noremap("i", "<M-BS>", "<C-w>", "Delete previous word")
noremap("i", "<C-BS>", "<C-w>", "Delete previous word")
noremap({ "n", "v", "i" }, "<C-s>", "<Cmd>w<CR>", "Save")

-- Move through buffers
noremap("n", "<C-h>", "<C-w>h", "Move to left buffer")
noremap("n", "<C-l>", "<C-w>l", "Move to right buffer")
noremap("n", "<C-j>", "<C-w>j", "Move to bottom buffer")
noremap("n", "<C-k>", "<C-w>k", "Move to top buffer")
noremap("n", "<C-w>", "<Cmd>Bdelete<CR>", "Close current buffer")

-- Cycle through old edits
noremap("n", "<A-h>", require("before").jump_to_last_edit, "Jump to last edit")
noremap("n", "<A-l>", require("before").jump_to_next_edit, "Jump to next edit")

-- Resize buffers
function toggle_fullscreen()
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
noremap("n", "<C-f>", "<Cmd>lua toggle_fullscreen()<CR>")

-- Switch buffer
noremap("n", "<TAB>", "<Plug>(cokeline-focus-next)", "Move to next buffer")
noremap("n", "<S-TAB>", "<Plug>(cokeline-focus-prev)", "Move to previous buffer")
noremap("n", "<C-TAB>", function() require('cokeline.history'):last():focus() end, "Move to previous buffer")

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

-- NvimTree
noremap("n", "<leader><TAB>", "<Cmd>NvimTreeToggle<CR>", "Toggle nvim_tree")

-- Formatting
noremap({ "n", "v", "i" }, "<C-S-s>", "<Cmd>Format<CR><Cmd>w<CR>", "Format current buffer")

-- Folder
noremap("n", "<leader><CR>", require("fold-cycle").open, "Open folder")
noremap("n", "<leader><BS>", require("fold-cycle").close, "Close folder")
noremap("n", "<C-m><C-l>", require("fold-cycle").open_all, "Open all folders")
noremap("n", "<C-m><C-o>", require("fold-cycle").close_all, "Close all folders")

-- multi line editing
vim.g.VM_default_mappings = 0
noremap("n", "<C-d>", "<Plug>(VM-Find-Under)", "Multi cursor editing")
noremap("x", "<C-d>", "<Plug>(VM-Find-Subword-Under)", "Multi cursor editing")

-------------------Smooth Scrolling------------------
local cinnamon = require("cinnamon")
noremap({ "n", "v" }, "<S-j>", function() cinnamon.scroll("<C-D>") end, "Scroll cursor down")
noremap({ "n", "v" }, "<S-k>", function() cinnamon.scroll("<C-U>") end, "Scroll cursor down")
noremap({ "n", "v" }, "<S-h>", "b", "Fast movement left")
noremap({ "n", "v" }, "<S-l>", "w", "Fast movement right")

noremap({ "n", "v" }, "zz", function() cinnamon.scroll("zz") end, "Center window on cusror")
noremap({ "n", "v" }, "zj", function() cinnamon.scroll("zt") end, "Scroll window down")
noremap({ "n", "v" }, "zk", function() cinnamon.scroll("zb") end, "Scroll window up")
noremap({ "n", "v" }, "zh", function() cinnamon.scroll("zH") end, "Scroll window left")
noremap({ "n", "v" }, "zl", function() cinnamon.scroll("zL") end, "Scroll window right")

-------------------Telescope------------------
function telescope_root_dir(command)
    local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
    local options = {}
    if vim.v.shell_error == 0 then
        options.cwd = root
    end

    require("telescope.builtin")[command](options)
end

noremap("n", "<leader>ff", '<Cmd>lua telescope_root_dir("find_files")<CR>', "[F]ind [F]iles")
noremap("n", "<leader>fof", '<Cmd>lua telescope_root_dir("oldfiles")<CR>', "[F]ind [O]ld [F]iles")
noremap("n", "<leader>fb", '<Cmd>lua telescope_root_dir("buffers")<CR>', "[F]ind [B]uffers")
noremap("n", "<leader>fg", '<Cmd>lua telescope_root_dir("live_grep")<CR>', "[F]ind [G]rep")
noremap("n", "<leader>fw", '<Cmd>lua telescope_root_dir("grep_string")<CR>', "[F]ind [W]ord")
noremap("n", "<leader>fib", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", "[F]ind [I]n [B]uffer")
noremap("n", "<leader>fd", "<Cmd>Telescope diagnostics<CR>", "[F]ind [D]iagnostics")
noremap("n", "<leader>fh", "<Cmd>Telescope help_tags<CR>", "[F]ind [H]elp")

-------------------Yanky------------------
noremap("n", "y", "<Plug>(YankyYank)", "Yank text")
noremap("n", "p", "<Plug>(YankyPutAfter)", "Put yanked text after cursor")
noremap("n", "P", "<Plug>(YankyPutBefore)", "Put yanked text before cursor")
noremap("n", "<A-p>", "<Plug>(YankyPreviousEntry)", "Select previous entry through yank history")
noremap("n", "<A-n>", "<Plug>(YankyNextEntry)", "Select next entry through yank history")
noremap("n", "<leader>p", require("telescope").extensions.yank_history.yank_history, "Open Yank History")

-------------------Commmenting------------------
remap("n", "<C-/>", "gcc", "Toggle comment on current line") -- qwerty 
remap("v", "<C-/>", "gc", "Toggle comments on selected lines")-- qwerty 

remap("n", "<C-:>", "gcc", "Toggle comment on current line") -- azerty
remap("v", "<C-:>", "gc", "Toggle comments on selected lines")-- azerty
