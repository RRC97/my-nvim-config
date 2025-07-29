-- Importações necessárias para o Telescope, já que o picker está aqui
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local M = {}

-- Diretório onde as sessões serão salvas
local session_dir = vim.fn.expand(vim.env.HOME .. '/.local/share/nvim/manual_sessions')

-- Garante que o diretório exista
if vim.fn.isdirectory(session_dir) == 0 then
  vim.fn.mkdir(session_dir, 'p')
end

--- Funções auxiliares para codificação/decodificação URL (simplificadas) ---
-- Esta é uma implementação básica. Para casos complexos, considere uma biblioteca externa.
-- Codifica caracteres não-alfanuméricos/numeros, mas mantém ., -, _
-- OBS: Não codifica '/' aqui, ele será tratado separadamente para nomes de arquivo.
local function url_encode_strict(str)
  if not str then return "" end
  -- Substitui espaços por %20 para clareza
  str = str:gsub(" ", "%%20")
  -- Codifica outros caracteres especiais, exceto os que queremos manter para nomes de arquivo (., -, _)
  -- NOTA: '/' não está na lista de exceções aqui, então ele seria codificado.
  -- Usaremos esta função para o DISPLAY, mas uma versão modificada para o FILENAME.
  str = str:gsub("([^%w%.%-_/])", function(c) -- Manter /, mas ainda assim codificar outros especiais
    return string.format("%%%02X", string.byte(c))
  end)
  return str
end

local function url_decode(str)
  if not str then return "" end
  str = str:gsub("%%(%x%x)", function(hex)
    return string.char(tonumber(hex, 16))
  end)
  return str
end
--------------------------------------------------------------------------

--- Gera o nome do arquivo da sessão a partir do caminho completo.
-- O nome do arquivo será uma versão codificada em URL, mas com '/' substituído por '_' ou um caracter seguro.
-- Ex: "/home/user/my-project/sub dir" -> "home_user_my-project_sub%20dir"
local function get_encoded_session_filename(path)
  -- Começa pelo caminho completo
  local filename_base = path

  -- 1. Remover barra inicial se existir
  filename_base = filename_base:gsub('^/', '')

  -- 2. Substituir TODAS as barras ('/') por underscores ('_') para a parte do NOME DO ARQUIVO.
  -- Isso é crucial para que o sistema de arquivos não interprete como subdiretórios.
  filename_base = filename_base:gsub('[/\\]', '_') -- Lida com / (Linux) e \ (Windows)

  -- 3. Codificar o restante da string usando url_encode_strict para caracteres como espaços, etc.
  local encoded_filename = url_encode_strict(filename_base)

  -- Remover qualquer underscore extra que possa ter surgido no processo de normalização
  encoded_filename = encoded_filename:gsub('__+', '_')
  encoded_filename = encoded_filename:gsub('^_', '')
  encoded_filename = encoded_filename:gsub('_$', '')

  if encoded_filename == '' then
    -- Se o path era apenas "/", ou algo que resultou em vazio, use um nome padrão
    encoded_filename = "root_session"
  end

  return encoded_filename
end

--- Salva a sessão atual. O nome do arquivo será o path completo codificado em URL.
M.save_current_session = function()
  local current_dir = vim.fn.getcwd()
  local session_filename_encoded = get_encoded_session_filename(current_dir)

  if session_filename_encoded == '' then
    print('Não foi possível determinar o nome da sessão. Verifique o PWD.')
    return
  end

  local session_file_path = session_dir .. '/' .. session_filename_encoded .. '.vim'
  vim.cmd('mksession! ' .. session_file_path)
  print('Sessão salva em: ' .. session_file_path)
end

--- Carrega uma sessão específica pelo seu nome de arquivo (codificado em URL).
-- @param session_filename_encoded string O nome do arquivo de sessão (sem a extensão .vim), codificado.
M.load_session_by_name = function(session_filename_encoded)
  if not session_filename_encoded or session_filename_encoded == '' then
    print('Nome da sessão não pode ser vazio.')
    return
  end
  local session_file_path = session_dir .. '/' .. session_filename_encoded .. '.vim'
  if vim.fn.filereadable(session_file_path) == 0 then
    print('Sessão não encontrada: ' .. session_file_path)
    return
  end

  vim.cmd('silent! %bdelete!')
  vim.cmd('silent! source ' .. session_file_path)
  -- Mensagem de confirmação usando o path decodificado para legibilidade
  print('Sessão carregada: ' .. url_decode(session_filename_encoded:gsub('_', '/'))) -- Decodifica e reverte _ para / para display
end

--- Tenta carregar a sessão automaticamente baseada no diretório de trabalho atual.
M.load_current_session = function()
  local current_dir = vim.fn.getcwd()
  local session_filename_encoded = get_encoded_session_filename(current_dir)
  if session_filename_encoded == '' then return end

  -- CORREÇÃO: Mude 'current_dir_encoded_filename' para 'session_filename_encoded'
  local session_file_path = session_dir .. '/' .. session_filename_encoded .. '.vim'
  if vim.fn.filereadable(session_file_path) ~= 0 then
    print('Tentando carregar sessão para o PWD atual: ' .. url_decode(session_filename_encoded:gsub('_', '/')))
    M.load_session_by_name(session_filename_encoded)
  else
    print('Nenhuma sessão encontrada para o PWD atual: ' .. url_decode(session_filename_encoded:gsub('_', '/')))
  end
end

--- Deleta uma sessão específica pelo seu nome de arquivo (codificado em URL).
-- @param session_filename_encoded string O nome do arquivo de sessão a ser deletado (sem a extensão .vim), codificado.
M.delete_session_by_name = function(session_filename_encoded)
  if not session_filename_encoded or session_filename_encoded == '' then
    print('Nome da sessão não pode ser vazio para deletar.')
    return
  end

  local session_file_path = session_dir .. '/' .. session_filename_encoded .. '.vim'
  if vim.fn.filereadable(session_file_path) == 0 then
    print('Nenhuma sessão encontrada com o nome: ' .. url_decode(session_filename_encoded:gsub('_', '/')))
    return
  end

  local display_name = url_decode(session_filename_encoded:gsub('_', '/')) -- Decodifica e reverte _ para / para confirmação
  vim.ui.select(
    { 'Sim', 'Não' },
    { prompt = 'Tem certeza que deseja deletar a sessão: ' .. display_name .. '?' },
    function(choice)
      if choice == 'Sim' then
        local success = vim.fn.delete(session_file_path)
        if success == 0 then
          print('Sessão "' .. display_name .. '" deletada com sucesso.')
          vim.api.nvim_exec_autocmds('User', {
            pattern = 'TelescopeSessionsChanged',
            modeline = false,
            buffer = 0,
          })
        else
          print('Erro ao deletar a sessão "' .. display_name .. '".')
        end
      else
        print('Exclusão da sessão cancelada.')
      end
    end
  )
end

--- Retorna uma lista de objetos de sessão para o Telescope.
-- Cada objeto terá 'value' (nome do arquivo codificado) e 'display' (path completo decodificado e com barras).
M.get_available_sessions_for_telescope = function()
  local sessions_data = {}
  local files = vim.fn.systemlist('find ' .. session_dir .. ' -maxdepth 1 -name "*.vim" -printf "%f\\n"')

  for _, file_name_with_ext in ipairs(files) do
    local session_filename_encoded = file_name_with_ext:gsub('%.vim$', '') -- Nome do arquivo sem .vim, ainda codificado

    -- Decodifica o nome do arquivo, e depois reverte os underscores para barras
    -- para exibir o path completo original no Telescope.
    local display_name = url_decode(session_filename_encoded):gsub('_', '/')

    table.insert(sessions_data, {
      value = session_filename_encoded, -- O nome real do arquivo (codificado), usado para load/delete
      display = display_name,           -- O que o usuário verá e poderá buscar (path completo decodificado e com barras)
      ordinal = display_name,           -- Importante para que a busca fuzzy use o 'display'
    })
  end

  -- Ordenar alfabeticamente pelo nome de exibição (display)
  table.sort(sessions_data, function(a, b)
    return a.display < b.display
  end)

  return sessions_data
end


-- === Função do Picker do Telescope, agora dentro do M ===
M.list_and_load_sessions = function(opts)
  opts = opts or {}

  -- Função interna para criar e encontrar o picker
  local function find_sessions()
    -- Usa a nova função que retorna dados formatados para o Telescope
    local sessions_for_telescope = M.get_available_sessions_for_telescope()

    pickers.new(opts, {
      prompt_title = 'Minhas Sessões Salvas',
      finder = finders.new_table({
        results = sessions_for_telescope,
        entry_maker = function(entry) -- Define como cada entrada é processada
          return {
            value = entry.value,
            display = entry.display,
            ordinal = entry.ordinal, -- Garante que o fuzzy finder use o 'display'
          }
        end,
      }),
      sorter = conf.file_sorter(opts), -- O sorter padrão funciona com o 'ordinal'
      attach_mappings = function(prompt_bufnr, map)
        -- Mapeamento para carregar a sessão (Enter)
        actions.select_default:enhance({
          fn = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if selection then
              M.load_session_by_name(selection.value) -- Usa o 'value' real do arquivo (codificado)
            end
          end,
        })

        -- Mapeamento para deletar a sessão (ex: <C-d> para Ctrl+d)
        map('i', '<C-d>', function()
          local selection = action_state.get_selected_entry()
          if selection then
            M.delete_session_by_name(selection.value) -- Usa o 'value' real do arquivo (codificado)
            -- Não feche o Telescope aqui. Deixe o autocmd lidar com a atualização.
          end
        end)
        map('n', '<C-d>', function()
          local selection = action_state.get_selected_entry()
          if selection then
            M.delete_session_by_name(selection.value) -- Usa o 'value' real do arquivo (codificado)
            -- Não feche o Telescope aqui. Deixe o autocmd lidar com a atualização.
          end
        end)

        return true
      end,
    }):find()
  end

  -- === NOVO AUTOCMD PARA RECARREGAR O PICKER ===
  -- Quando a lista de sessões muda (após uma deleção), recria o picker para atualizar a lista.
  vim.api.nvim_create_autocmd('User', {
    pattern = 'TelescopeSessionsChanged',
    group = vim.api.nvim_create_augroup('TelescopeSessionReload', { clear = true }),
    callback = function()
      find_sessions() -- Chama a função novamente para recriar o picker com a lista atualizada
    end,
  })

  -- Chama a função find_sessions pela primeira vez para iniciar o picker
  find_sessions()
end

return M
