-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- Delete sem copiar para o registro padrão
vim.keymap.set("n", "dd", '"_dd') -- Faz dd deletar sem copiar
vim.keymap.set("v", "d", '"_d') -- Mesma coisa em modo visual
