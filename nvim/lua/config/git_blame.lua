require("gitblame").setup()

vim.g.gitblame_message_template = '<author>'
vim.cmd("GitBlameDisable")
vim.api.nvim_create_user_command('Blame',function()
  pcall(vim.cmd("GitBlameToggle"))
end,{})
