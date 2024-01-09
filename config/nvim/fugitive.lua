vim.keymap.set("n", "<leader>gg", vim.cmd.Git);
vim.keymap.set("n", "<leader>gc", ":Git commit<CR>")
vim.keymap.set("n", "<leader>gp", ":Git push<CR>")
vim.keymap.set("n", "<leader>gP", ":Git pull<CR>")
vim.keymap.set("n", "<leader>gb", ":Git checkout ", {noremap = false})
