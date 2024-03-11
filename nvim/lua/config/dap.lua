require("mason-nvim-dap").setup({
    ensure_installed = {
        "codelldb",
    },
})

local dap = require("dap")
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    name = "lldb",
}
dap.configurations.cpp = {
    {
        name = "Prompt",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
    },
}

dapui.setup({
    mappings = {
        edit = "e",
        expand = { "<TAB>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t",
    },
})

require("neodev").setup({
    library = {
        plugins = {
            "nvim-dap-ui",
        },
        types = true,
    },
})

require("nvim-dap-virtual-text").setup()
