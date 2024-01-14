local on_attach = function(_, bufnr)
    local map = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end


    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    -- map('gd', vim.lsp.buf.definition, '[G]oto [d]efinition')
    map('gD', vim.lsp.buf.hover, '[G]oto [D]ocumentation')
    map('gd', ':Telescope lsp_definitions<CR>', '[G]oto [d]efinitions')
    map('gr', ':Telescope lsp_references<CR>', '[G]oto [R]eferences')
    map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    map('<leader>d', vim.diagnostic.open_float, '[D]iagnostic')

    map('<leader>ds', ':Telescope lsp_document_symbols<CR>', '[D]ocument [S]ymbols')
    map('<leader>ws', ':Telescope lsp_dynamic_workspace_symbols<CR>', '[W]orkspace [S]ymbols')



    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end


local servers = {
    clangd = {},
    pyright = {},
    bashls = {
        default_config = {
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh" },
        },
    },
}



-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
require('mason').setup()
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}
