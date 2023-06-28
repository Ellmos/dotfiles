require('neoscroll').setup()

local t = {}
t['<S-k>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
t['<S-j>'] = {'scroll', { 'vim.wo.scroll', 'true', '250'}}

require('neoscroll.config').set_mappings(t)
