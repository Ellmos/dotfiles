require("yanky").setup({
    highlight = {
        on_put = false,
        on_yank = false,
    },
    opts = {
        ring = { storage = "sqlite" },
    },
})
