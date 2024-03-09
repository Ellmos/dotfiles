local on_attach = function(_, bufnr)
    local map = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    -- map('gd', vim.lsp.buf.definition, '[G]oto [d]efinition')
    map("gD", vim.lsp.buf.hover, "[G]oto [D]ocumentation")
    map("gd", "<Cmd>Telescope lsp_definitions<CR>", "[G]oto [d]efinitions")
    map("gr", "<Cmd>Telescope lsp_references<CR>", "[G]oto [R]eferences")
    map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    map("<leader>d", vim.diagnostic.open_float, "[D]iagnostic")

    map("<leader>ds", "<Cmd>Telescope lsp_document_symbols<CR>", "[D]ocument [S]ymbols")
    map("<leader>ws", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "[W]orkspace [S]ymbols")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

local servers = {
    clangd = {},
    pyright = {},
    tsserver = {},
    rust_analyzer = {},
    html = {},
    jsonls = {},
    bashls = {
        default_config = {
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh" },
        },
    },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
            completion = {
                callSnippet = "Replace",
            },
        },
    },
    -- hls = {}, -- In Mason: haskell-language-server
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = vim.tbl_keys(servers),
})

require("mason-lspconfig").setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        })
    end,
})
