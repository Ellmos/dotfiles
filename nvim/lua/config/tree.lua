local function open_nvim_tree(data)
    -- buffer is not a directory
    if not vim.fn.isdirectory(data.file) == 1 then
        return
    end

    require("nvim-tree.api").tree.close()
    vim.cmd.bw()
    require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

require("nvim-tree").setup({ select_prompts = true })
require("lsp-file-operations").setup()
