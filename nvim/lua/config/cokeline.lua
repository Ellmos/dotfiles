local get_hex = require("cokeline.hlgroups").get_hl_attr

require("cokeline").setup({
    history = {
        enabled = true,
        size = 100,
    },
    sidebar = {
        filetype = { "NvimTree" },
        components = {
            {
                text = function(buf)
                    return buf.filetype
                end,
                bold = true,
            },
        },
    },
    default_hl = {
        fg = function(buffer)
            return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
        end,
        bg = "NONE",
    },
    components = {
        {
            text = function(buffer)
                return (buffer.index ~= 1) and " ▏" or ""
            end,
            fg = function()
                return get_hex("Normal", "fg")
            end,
        },
        {
            text = function(buffer)
                return " " .. buffer.devicon.icon
            end,
            fg = function(buffer)
                return buffer.devicon.color
            end,
        },
        {
            text = function(buffer)
                return buffer.filename .. " "
            end,
        },
        {
            text = function(buffer)
                return buffer.is_modified and " " or "󰖭"
            end,
            on_click = function(_, _, _, _, buffer)
                if not buffer.is_modified then
                    return buffer:delete()
                end
            end,
            bold = function(buffer)
                return buffer.is_focused
            end,
            fg = function(buffer)
                return buffer.is_modified and "#00FFFF" or get_hex("Normal", "fg")
            end,

        },
        {
            text = " ",
        },
    },
})
