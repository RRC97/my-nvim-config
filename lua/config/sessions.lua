-- ~/.config/nvim/lua/keymaps.lua

local sessions = require('utils.sessions')

-- Mapeamento para Salvar a Sessão Atual
vim.keymap.set('n', '<leader>ss', sessions.save_current_session, { desc = 'Salvar sessão do projeto atual' })

-- Mapeamento para Carregar a Sessão do Diretório Atual
vim.keymap.set('n', '<leader>sl', sessions.load_current_session, { desc = 'Carregar sessão do projeto atual' })

-- Mapeamento para Listar e Carregar Sessões com Telescope
vim.keymap.set('n', '<leader>sf', sessions.list_and_load_sessions, { desc = 'Listar e carregar sessões salvas' })
