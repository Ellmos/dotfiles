local map = function(mode, keymap, action, description)
    vim.keymap.set(mode, keymap, action, { desc = description, silent = true, noremap = true })
end

-------------------Utils------------------
map("i", "<M-BS>", "<C-w>", "Delete previous word")

-- Move through buffers
map("n", "<C-h>", "<C-w>h", "Move to left buffer")
map("n", "<C-l>", "<C-w>l", "Move to right buffer")
map("n", "<C-j>", "<C-w>j", "Move to bottom buffer")
map("n", "<C-k>", "<C-w>k", "Move to top buffer")
map("n", "<C-w>", "<Cmd>Bdelete<CR>", "Close current buffer")

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

map("n", "<C-A-h>", "7<C-w><")
map("n", "<C-A-l>", "7<C-w>>")
map("n", "<C-A-j>", "7<C-w>+")
map("n", "<C-A-k>", "7<C-w>-")
map("n", "<C-f>", "<Cmd>lua toggle_fullscreen()<CR>")

-- Switch buffer
map("n", "<TAB>", "<Cmd>BufferLineCycleNext<CR>", "Move to next buffer")
map("n", "<S-TAB>", "<Cmd>BufferLineCyclePrev<CR>", "Move to previous buffer")

-- Move lines with alt key
map("n", "<A-j>", ":m +1<CR>==", "Move the current line one downward")
map("n", "<A-k>", ":m -2<CR>==", "Move the current line one upward")

map("v", "<A-j>", ":m '>+1<CR>gv=gv", "move the selected lines one downward")
map("v", "<A-k>", ":m '<-2<CR>gv=gv", "move the selected line one upward")

-- Some cool shortcut to add line ends
map("n", "<leader>;", "<s-a>;<ESC>", 'Add ";" at the end of the current line')
map("n", "<leader>,", "<s-a>,<ESC>", 'Add "," at the end of the current line')
map("n", "<leader>:", "<s-a>:<ESC>", 'Add ":" at the end of the current line')

-- Switch off highlighting
map("n", "µ", "<Cmd>noh<CR>", "Switch off highlighting")

-- NvimTree
map("n", "<leader><Tab>", "<Cmd>NvimTreeToggle<CR>", "Toggle nvim_tree")

-- Folder
map("n", "<leader><CR>", '<Cmd>lua require("fold-cycle").open()<CR>', "Open folder")
map("n", "<leader><BS>", '<Cmd>lua require("fold-cycle").close()<CR>', "Close folder")
map("n", "<leader>a<CR>", '<Cmd>lua require("fold-cycle").open_all()<CR>', "Open all folders")
map("n", "<leader>a<BS>", '<Cmd>lua require("fold-cycle").close_all()<CR>', "Close all folders")

-------------------DAP------------------
map("n", "<leader>b", "<Cmd>DapToggleBreakpoint<CR>", "Toggle [B]reakpoint")
map("n", "<leader>fb", "<Cmd>Telescope dap list_breakpoints<CR>", "[F]ind [B]reakpoints")
map("n", "<F5>", "<Cmd>DapContinue<CR>", "Dap run or continue")
map("n", "<F29>", "<Cmd>DapTerminate<CR>", "Ctrl+F5: Dap terminate")
map("n", "<F17>", "<Cmd>DapTerminate<CR><Cmd>DapContinue<CR>", "Shift+F5: Dap Restart")
map("n", "<F6>", "<Cmd>DapStepOver<CR>", "Dap step over")
map("n", "<F7>", "<Cmd>DapStepInto<CR>", "Dap step into")
map("n", "<F31>", "<Cmd>DapStepOut<CR>", "Ctrl+F7: Dap step out")

-------------------Smooth Scrolling------------------
map({ "n", "v" }, "<S-j>", "<Cmd>lua require('cinnamon').scroll('<C-D>')<CR>", "Scroll cursor down")
map({ "n", "v" }, "<S-k>", "<Cmd>lua require('cinnamon').scroll('<C-U>')<CR>", "Scroll cursor down")
map({ "n", "v" }, "<S-h>", "b", "Fast movement left")
map({ "n", "v" }, "<S-l>", "w", "Fast movement right")

map({ "n", "v" }, "zz", "<Cmd>lua require('cinnamon').scroll('zz')<CR>", "Center window on cusror")
map({ "n", "v" }, "zj", "<Cmd>lua require('cinnamon').scroll('zt')<CR>", "Scroll window down")
map({ "n", "v" }, "zk", "<Cmd>lua require('cinnamon').scroll('zb')<CR>", "Scroll window up")
map({ "n", "v" }, "zh", "<Cmd>lua require('cinnamon').scroll('zH')<CR>", "Scroll window left")
map({ "n", "v" }, "zl", "<Cmd>lua require('cinnamon').scroll('zL')<CR>", "Scroll window right")

-------------------Telescope------------------
function telescope_root_dir(command)
    local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
    local options = {}
    if vim.v.shell_error == 0 then
        options.cwd = root
    end

    require("telescope.builtin")[command](options)
end

map("n", "<leader>ff", '<Cmd>lua telescope_root_dir("find_files")<CR>', "[F]ind [F]iles")
map("n", "<leader>fof", '<Cmd>lua telescope_root_dir("oldfiles")<CR>', "[O]ldfiles")
map("n", "<leader>fg", '<Cmd>lua telescope_root_dir("live_grep")<CR>', "[L]ive [G]rep")
map("n", "<leader>fw", '<Cmd>lua telescope_root_dir("grep_string")<CR>', "[G]rep [S]tring")

map("n", "<leader>fib", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", "[F]ind [I]n [B]uffer")
map("n", "<leader>fd", "<Cmd>Telescope diagnostics<CR>", "[F]ind [D]iagnostics")
map("n", "<leader>fh", "<Cmd>Telescope help_tags<CR>", "[F]ind [H]elp")

-------------------Yanky------------------
map({ "n", "v" }, "y", "<Plug>(YankyYank)", "Yank text")
map({ "n", "v" }, "p", "<Plug>(YankyPutAfter)", "Put yanked text after cursor")
map({ "n", "v" }, "P", "<Plug>(YankyPutBefore)", "Put yanked text before cursor")
map({ "n", "v" }, "<A-p>", "<Plug>(YankyPreviousEntry)", "Select previous entry through yank history")
map({ "n", "v" }, "<A-n>", "<Plug>(YankyNextEntry)", "Select next entry through yank history")
map(
    { "n", "v" },
    "<leader>p",
    '<Cmd>lua require("telescope").extensions.yank_history.yank_history()<CR>',
    "Open Yank History"
)

-------------------Commmenting------------------
local api = require("Comment.api")
local commentMap = vim.keymap.set
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

-- Commenting/Uncommenting single line
commentMap(
    "n",
    "<leader>cc",
    api.call("comment.linewise.current", "g@$"),
    { expr = true, desc = "Comment current line" }
)
commentMap(
    "n",
    "<leader>CC",
    api.call("uncomment.linewise.current", "g@$"),
    { expr = true, desc = "Uncomment current line" }
)
commentMap(
    "n",
    "<leader>cb",
    api.call("comment.blockwise.current", "g@$"),
    { expr = true, desc = "Comment current block" }
)
commentMap(
    "n",
    "<leader>CB",
    api.call("uncomment.blockwise.current", "g@$"),
    { expr = true, desc = "Uncomment current block" }
)

-- Commenting/Uncommenting multiple lines
commentMap("x", "<leader>cc", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    api.locked("comment.linewise")(vim.fn.visualmode())
end, { desc = "Comment region linewise (visual)" })
commentMap("x", "<leader>CC", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    api.locked("uncomment.linewise")(vim.fn.visualmode())
end, { desc = "Uncomment region linewise (visual)" })

commentMap("x", "<leader>cb", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    api.locked("comment.blockwise")(vim.fn.visualmode())
end, { desc = "Comment region blockwise (visual)" })
commentMap("x", "<leader>CB", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    api.locked("uncomment.blockwise")(vim.fn.visualmode())
end, { desc = "Uncomment region blockwise (visual)" })
