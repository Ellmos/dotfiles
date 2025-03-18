local api = require("nvim-tree.api")

local function open_nvim_tree(data)
    -- buffer is not a directory
    if not vim.fn.isdirectory(data.file) == 1 then
        return
    end

    -- if nvim opens on a folder it is doing some weird fuck so kill nvim-tree buffer and reopen
    if string.find(vim.api.nvim_buf_get_name(0), "NvimTree_1") then
        api.tree.close()
        vim.cmd.bw()
        api.tree.open()
    end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

require("nvim-tree").setup({
    select_prompts = true,
    view = {
        width = {
            min = 30,
            max = -1
        }
    },
})

require("lsp-file-operations").setup()
