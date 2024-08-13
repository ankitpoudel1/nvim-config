-- Plugin management with vim-plug
vim.cmd [[
  call plug#begin('~/.local/share/nvim/plugged')

  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'mattn/emmet-vim'
  Plug 'tpope/vim-fugitive'
  Plug 'morhetz/gruvbox'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdtree'

  call plug#end()
]]

-- Set color scheme
vim.cmd [[colorscheme gruvbox]]

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}

-- Enable LSP for JavaScript/TypeScript
require'lspconfig'.tsserver.setup{}

-- Enable auto-completion
vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
  enabled = true,
  autocomplete = true,
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = false,
  },
}

-- Enable relative line numbers
vim.wo.relativenumber = true

-- Enable absolute line numbers for the current line
vim.wo.number = true

-- Enable Emmet for HTML and CSS
vim.g.user_emmet_leader_key = '<C-Z>'

-- Map <Space> as the leader key
vim.g.mapleader = " "

-- Key binding for saving
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })

-- Key binding for quitting without saving
vim.api.nvim_set_keymap('n', '<leader>q', ':q!<CR>', { noremap = true, silent = true })

-- NERDTree toggle shortcut
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- fzf :Files shortcut
vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true, silent = true })

-- Open defition in a vertical split 
vim.api.nvim_set_keymap('n', '<C-d>', ':vsplit<CR>:lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
