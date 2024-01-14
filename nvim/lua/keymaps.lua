local map = function(mode, keymap, action, description)
    vim.keymap.set(mode, keymap, action, { desc = description, silent = true, noremap = true })
end

-- Utils
map('i', '<M-BS>', '<C-w>', 'Delete previous word')

-- Move through buffers
map('n', '<C-h>', '<C-w>h', 'Move to left buffer')
map('n', '<C-l>', '<C-w>l', 'Move to right buffer')
map('n', '<C-j>', '<C-w>j', 'Move to bottom buffer')
map('n', '<C-k>', '<C-w>k', 'Move to top buffer')
map('n', '<C-w>', ':Bdelete<CR>', 'Close current buffer')

-- Switch windows
map('n', '<TAB>', ':BufferLineCycleNext<CR>', 'Move to next window')
map('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', 'Move to previous window')

-- Move lines with alt key
map('n', '<A-j>', ':m +1<CR>==', 'Move the current line one downward')
map('n', '<A-k>', ':m -2<CR>==', 'Move the current line one upward')

map('v', '<A-j>', ':m \'>+1<CR>gv=gv', 'move the selected lines one downward')
map('v', '<A-k>', ':m \'<-2<CR>gv=gv', 'move the selected line one upward')

-- Some cool shortcut to add line ends
map('n', '<leader>;', '<s-a>;<ESC>', 'Add ";" at the end of the current line')
map('n', '<leader>,', '<s-a>,<ESC>', 'Add "," at the end of the current line')
map('n', '<leader>:', '<s-a>:<ESC>', 'Add ":" at the end of the current line')

-- Switch off highlighting
map('n', '"', ':noh<CR>', 'Switch off highlighting')

-- NvimTree switch on-off
map('n', '<leader><Tab>', ':NvimTreeToggle<CR>', 'Open/Close nvim_tree')


-------------------Smooth Scrolling------------------
map({ 'n', 'v' }, '<S-j>', "<Cmd>lua Scroll('<C-d>', 1, 1)<CR>", 'Scroll cursor down')
map({ 'n', 'v' }, '<S-k>', "<Cmd>lua Scroll('<C-u>', 1, 1)<CR>", 'Scroll cursor down')
map({ 'n', 'v' }, '<S-h>', "b", 'Fast movement left')
map({ 'n', 'v' }, '<S-l>', "w", 'Fast movement right')

map({ 'n', 'v' }, 'zz', ":lua Scroll('zz', 0, 1)<CR>", 'Center window on cusror')
map({ 'n', 'v' }, 'zj', ":lua Scroll('zt', 0, 1)<CR>", 'Scroll window down')
map({ 'n', 'v' }, 'zk', ":lua Scroll('zb', 0, 1)<CR>", 'Scroll window up')
map({ 'n', 'v' }, 'zh', ":lua Scroll('zH')<CR>", 'Scroll window left')
map({ 'n', 'v' }, 'zl', ":lua Scroll('zL')<CR>", 'Scroll window right')


-------------------Telescope------------------
function telescope_root_dir(command)
    local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")
    local options = {}
    if vim.v.shell_error == 0 then
        options.cwd = root
    end

    require("telescope.builtin")[command](options)
end

map('n', '<leader>ff', ':lua telescope_root_dir("find_files")<CR>', '[F]ind [F]iles')
map('n', '<leader>fof', ':lua telescope_root_dir("oldfiles")<CR>', '[O]ldfiles')
map('n', '<leader>fg', ':lua telescope_root_dir("live_grep")<CR>', '[L]ive [G]rep')
map('n', '<leader>fw', ':lua telescope_root_dir("grep_string")<CR>', '[G]rep [S]tring')

map('n', '<leader>fb', ':Telescope buffers<CR>', '[F]ind [B]uffers')
map('n', '<leader>fib', ':Telescope current_buffer_fuzzy_find<CR>', '[F]ind [I]n [B]uffer')
map('n', '<leader>fd', ':Telescope diagnostics<CR>', '[F]ind [D]iagnostics')
map('n', '<leader>fh', ':Telescope help_tags<CR>', '[F]ind [H]elp')


-------------------Yanky------------------
map({ 'n', 'v' }, 'y', '<Plug>(YankyYank)', 'Yank text')
map({ 'n', 'v' }, 'p', '<Plug>(YankyPutAfter)', 'Put yanked text after cursor')
map({ 'n', 'v' }, 'P', '<Plug>(YankyPutBefore)', 'Put yanked text before cursor')
map({ 'n', 'v' }, '<A-p>', "<Plug>(YankyPreviousEntry)", "Select previous entry through yank history")
map({ 'n', 'v' }, '<A-n>', "<Plug>(YankyNextEntry)", "Select next entry through yank history")
map({ 'n', 'v' }, '<leader>p', ':lua require("telescope").extensions.yank_history.yank_history()<CR>', 'Open Yank History')


-------------------Commmenting------------------
local api = require('Comment.api')
local commentMap = vim.keymap.set
local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

-- Commenting/Uncommenting single line
commentMap('n', '<leader>cc', api.call('comment.linewise.current', 'g@$'), { expr = true, desc = 'Comment current line' })
commentMap('n', '<leader>CC', api.call('uncomment.linewise.current', 'g@$'), { expr = true, desc = 'Uncomment current line' })

commentMap('n', '<leader>cb', api.call('comment.blockwise.current', 'g@$'), { expr = true, desc = 'Comment current block' })
commentMap('n', '<leader>CB', api.call('uncomment.blockwise.current', 'g@$'), { expr = true, desc = 'Uncomment current block' })

-- Commenting/Uncommenting multiple lines
commentMap('x', '<leader>cc', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.locked('comment.linewise')(vim.fn.visualmode())
end, { desc = 'Comment region linewise (visual)' })
commentMap('x', '<leader>CC', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.locked('uncomment.linewise')(vim.fn.visualmode())
end, { desc = 'Uncomment region linewise (visual)' })

commentMap('x', '<leader>cb', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.locked('comment.blockwise')(vim.fn.visualmode())
end, { desc = 'Comment region blockwise (visual)' })
commentMap('x', '<leader>CB', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.locked('uncomment.blockwise')(vim.fn.visualmode())
end, { desc = 'Uncomment region blockwise (visual)' })
