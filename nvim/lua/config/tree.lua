local function open_nvim_tree(data)
    if data.file == "" then
        require("nvim-tree.api").tree.close()
    elseif string.find(vim.api.nvim_buf_get_name(0), "NvimTree_1") then
        require("nvim-tree.api").tree.close()
        vim.cmd.bw()
        require("nvim-tree.api").tree.open()
    end
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

require("nvim-tree").setup({ select_prompts = true })
require("lsp-file-operations").setup()
