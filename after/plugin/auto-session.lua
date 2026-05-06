
vim.keymap.set("n", "<leader>ss", "<cmd>AutoSession save<cr>", { desc = "Save Session" })
vim.keymap.set("n", "<leader>sr", "<cmd>AutoSession restore<cr>", { desc = "Restore Session" })
vim.keymap.set("n", "<leader>sd", "<cmd>AutoSession delete<cr>", { desc = "Delete Session" })
vim.keymap.set("n", "<leader>sl", "<cmd>AutoSession search<cr>", { desc = "List Sessions" })

-- Garante que o Neovim salve e leia a Jumplist e Marcas corretamente
vim.opt.shada = "!,'100,<50,s10,h"

-- Função para gerar um caminho de shada baseado na pasta atual
-- Isso cria um arquivo único para cada projeto em ~/.local/state/nvim/shada/
local function get_project_shada()
  local cwd = vim.fn.getcwd():gsub("/", "%%")
  local shada_dir = vim.fn.stdpath("state") .. "/shada"
  
  if vim.fn.isdirectory(shada_dir) == 0 then
    vim.fn.mkdir(shada_dir, "p")
  end
  
  local full_path = shada_dir .. "/" .. cwd .. ".shada"
  
  -- CONTRORNO PARA O ERRO:
  -- Se o arquivo não existir, criamos um arquivo vazio (touch)
  -- Isso impede que o Neovim dispare o erro de "arquivo não encontrado"
  if vim.fn.filereadable(full_path) == 0 then
    local f = io.open(full_path, "w")
    if f then 
      f:close() 
    end
  end
  
  return full_path
end

-- Define o shada para o projeto atual ao iniciar
vim.opt.shadafile = get_project_shada()
