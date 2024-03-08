local function open_nvim_tree(data)
    -- buffer is not a directory
    if not vim.fn.isdirectory(data.file) == 1 then
        return
    end

    -- if nvim opens on a folder it is doing dome weird fuck so kill nvim-tree buffer and reopen
    if string.find(vim.api.nvim_buf_get_name(0), "NvimTree_1") then
        require("nvim-tree.api").tree.close()
        vim.cmd.bw()
        require("nvim-tree.api").tree.open()
    end
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

require("nvim-tree").setup({ select_prompts = true })
require("lsp-file-operations").setup()
