-- ~/.config/nvim/lua/keymaps.lua

local sessions = require('utils.sessions')

-- vim.api.nvim_create_autocmd({ 'VimLeavePre', 'VimResized' }, {
--   callback = function()
--     vim.cmd('echom "INFO: Autocmd VimLeavePre disparado!"')
--
--     vim.cmd('echom "INFO: Módulo sessions carregado."')
--
--     local current_dir = vim.fn.getcwd()
--     vim.cmd('echom "INFO: PWD: ' .. current_dir .. '"')
--
--     local session_filename_encoded = sessions.get_encoded_session_filename(current_dir)
--     vim.cmd('echom "INFO: Nome da sessão codificado: ' .. session_filename_encoded .. '"')
--     if session_filename_encoded == '' then
--       vim.cmd('echom "WARN: Nome da sessão codificado vazio, abortando auto-salvamento."')
--       return
--     end
--
--     local session_dir = sessions.session_dir
--     local session_file_path = session_dir .. '/' .. session_filename_encoded .. '.vim'
--     vim.cmd('echom "INFO: Caminho completo da sessão: ' .. session_file_path .. '"')
--
--     if vim.fn.filereadable(session_file_path) ~= 0 then
--       vim.cmd('echom "INFO: Sessão existente encontrada, salvando automaticamente."')
--       sessions.save_current_session() -- Esta função já tem echom's internos
--     else
--       vim.cmd('echom "INFO: Nenhuma sessão existente para auto-salvamento neste diretório."')
--     end
--   end,
-- })

-- Mapeamento para Salvar a Sessão Atual
vim.keymap.set('n', '<leader>ss', sessions.save_current_session, { desc = 'Salvar sessão do projeto atual' })

-- Mapeamento para Carregar a Sessão do Diretório Atual
vim.keymap.set('n', '<leader>sl', sessions.load_current_session, { desc = 'Carregar sessão do projeto atual' })

-- Mapeamento para Listar e Carregar Sessões com Telescope
vim.keymap.set('n', '<leader>sf', sessions.list_and_load_sessions, { desc = 'Listar e carregar sessões salvas' })
