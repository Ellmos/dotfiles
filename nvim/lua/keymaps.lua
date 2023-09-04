local map = function(mode, keymap, action, description)
    vim.keymap.set(mode, keymap, action, { desc = description, silent = true, noremap = true })
end

-------------------Utils------------------
map('i', '<M-BS>', '<C-w>', 'Delete previous word')


-- Move through buffers
map('n', '<C-h>', '<C-w>h', 'Move to left buffer')
map('n', '<C-l>', '<C-w>l', 'Move to right buffer')
map('n', '<C-j>', '<C-w>j', 'Move to bottom buffer')
map('n', '<C-k>', '<C-w>k', 'Move to top buffer')
map('n', '<C-w>', ':bd<CR>', 'Close current buffer')

-- Switch windows
map('n', '<TAB>', ':BufferLineCycleNext<CR>', 'Move to next window')
map('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', 'Move to previous window')

-- Move lines with alt key
map('n', '<A-j>', ':m +1<CR>==', 'Move the current line one downward')
map('n', '<A-k>', ':m -2<CR>==', 'Move the current line one upward')

map('v', '<A-j>', ':m \'>+1<CR>gv=gv', 'move the selected lines one downward')
map('v', '<A-k>', ':m \'<-2<CR>gv=gv', 'move the selected line one upward')

-- Some cool shotcut to add line ends
map('n', '<leader>;', '<s-a>;<ESC>', 'Add ";" at the end of the current line')
map('n', '<leader>,', '<s-a>,<ESC>', 'Add "," at the end of the current line')
map('n', '<leader>:', '<s-a>:<ESC>', 'Add ":" at the end of the current line')

-- Switch off highlighting
map('n', 'µ', ':noh<CR>', 'Switch off highlighting')

-- NvimTree switch on-off
map('n', '<leader><Tab>', ':NvimTreeToggle<CR>', 'Open/Close nvim_tree')

-- Folder
map('n', '<leader><CR>', ':lua require("fold-cycle").open()<CR>', 'Open folder')
map('n', '<leader><BS>', ':lua require("fold-cycle").close()<CR>', 'Close folder')
map('n', '<leader>a<CR>', ':lua require("fold-cycle").open_all()<CR>', 'Open all folders')
map('n', '<leader>a<BS>', ':lua require("fold-cycle").close_all()<CR>', 'Close all folders')


-------------------Telescope------------------
map('n', '<leader>ff', ':Telescope find_files<CR>', '[F]ind [F]iles' )
map('n', '<leader>fof', ':Telescope oldfiles<CR>', '[F]ind [O]ld [F]iles' )
map('n', '<leader>fg', ':Telescope live_grep<CR>', '[F]ind by [G]rep' )
map('n', '<leader>fw', ':Telescope grep_string<CR>', '[F]ind [W]ord' )
map('n', '<leader>fb', ':Telescope buffers<CR>', '[F]ind [B]uffers' )
map('n', '<leader>fib', ':Telescope current_buffer_fuzzy_find<CR>', '[F]ind [I]n [B]uffer' )
map('n', '<leader>fd', ':Telescope diagnostics<CR>', '[F]ind [D]iagnostics' )
map('n', '<leader>fh', ':Telescope help_tags<CR>', '[F]ind [H]elp' )



-------------------LSP------------------
map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
map('n', 'gr', ':Telescope lsp_references<CR>', '[G]oto [R]eferences')
map('n', '<leader>ds', ':Telescope lsp_document_symbols<CR>', '[D]ocument [S]ymbols')
map('n', '<leader>ws', ':Telescope lsp_dynamic_workspace_symbols<CR>', '[W]orkspace [S]ymbols')

-- See `:help K` for why this keymap
map('n', 'gD', vim.lsp.buf.hover, '[G]o [D]ocumentation')
map('n', 'gsD', vim.lsp.buf.signature_help, '[G]o [S]ignature [D]ocumentation')




-------------------Smooth Scrolling------------------
map({'n', 'v'}, '<S-j>', "<Cmd>lua Scroll('<C-d>', 1, 1)<CR>", 'Scroll cursor down')
map({'n', 'v'}, '<S-k>', "<Cmd>lua Scroll('<C-u>', 1, 1)<CR>", 'Scroll cursor down')
map({'n', 'v'}, '<S-h>', "b", 'Fast movement left')
map({'n', 'v'}, '<S-l>', "w", 'Fast movement right')

map({'n', 'v'}, 'zz', ":lua Scroll('zz', 0, 1)<CR>", 'Center window on cusror')
map({'n', 'v'}, 'zj', ":lua Scroll('zt', 0, 1)<CR>", 'Scroll window down')
map({'n', 'v'}, 'zk', ":lua Scroll('zb', 0, 1)<CR>", 'Scroll window up')
map({'n', 'v'}, 'zh', ":lua Scroll('zH')<CR>", 'Scroll window left')
map({'n', 'v'}, 'zl', ":lua Scroll('zL')<CR>", 'Scroll window right')




-------------------Commmenting------------------
local api = require('Comment.api')
local commentMap = vim.keymap.set
local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

-- Commenting/Uncommenting single line
commentMap('n', '<leader>cc', api.call('comment.linewise.current', 'g@$'), { expr = true, desc = 'Comment current line' })
commentMap('n', '<leader>cb', api.call('comment.blockwise.current', 'g@$'), { expr = true, desc = 'Comment current block' })

commentMap('n', '<leader>Cc', api.call('uncomment.linewise.current', 'g@$'), { expr = true, desc = 'Uncomment current line' })
commentMap('n', '<leader>Cb', api.call('uncomment.blockwise.current', 'g@$'), { expr = true, desc = 'Uncomment current block' })

-- Commenting/Uncommenting multiple lines
commentMap('x', '<leader>cc', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.locked('comment.linewise')(vim.fn.visualmode())
end, { desc = 'Comment region linewise (visual)' })
commentMap('x', '<leader>cb', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.locked('comment.blockwise')(vim.fn.visualmode())
end, { desc = 'Comment region blockwise (visual)' })

commentMap('x', '<leader>Cc', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.locked('uncomment.linewise')(vim.fn.visualmode())
end, { desc = 'Uncomment region linewise (visual)' })
commentMap('x', '<leader>Cb', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.locked('uncomment.blockwise')(vim.fn.visualmode())
end, { desc = 'Uncomment region blockwise (visual)' })
