-- ~/.config/nvim/lua/keymaps.lua

local sessions = require('utils.sessions')

-- vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
--   callback = function()
--     local cwd = vim.fn.getcwd() or sessions.cwd
--     if not cwd or cwd == '' then
--       local session_filename_encoded = sessions.get_encoded_session_filename(cwd)
--       if session_filename_encoded == '' then
--         vim.cmd('echom "WARN: Encoded session filename is empty, aborting auto-save."')
--         return
--       end
--
--       local session_dir = sessions.session_dir
--       local session_file_path = session_dir .. '/' .. session_filename_encoded .. '.vim'
--
--       if vim.fn.filereadable(session_file_path) ~= 0 then
--         sessions.save_current_session()
--       else
--         vim.cmd('echom "INFO: No existing session to auto-save in this directory."')
--       end
--     end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd({ 'BufEnter', 'VimEnter' }, {
--   callback = function()
--     local cwd = vim.fn.getcwd()
--     sessions.cwd = cwd
--   end
-- })

-- Mapeamento para Salvar a Sessão Atual
vim.keymap.set('n', '<leader>ss', sessions.save_current_session, { desc = 'Salvar sessão do projeto atual' })

-- Mapeamento para Carregar a Sessão do Diretório Atual
vim.keymap.set('n', '<leader>sl', sessions.load_current_session, { desc = 'Carregar sessão do projeto atual' })

-- Mapeamento para Listar e Carregar Sessões com Telescope
vim.keymap.set('n', '<leader>sf', sessions.list_and_load_sessions, { desc = 'Listar e carregar sessões salvas' })
