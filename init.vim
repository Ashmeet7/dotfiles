
call plug#begin()
Plug 'nvim-lua/plenary.nvim',
Plug 'MunifTanjim/nui.nvim',
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sainnhe/sonokai'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

let $FZF_DEFAULT_COMMAND = 'find . -type f ! -executable'
let g:python3_host_prog = '~/.venvs/nvim/bin/python'
let g:sonokai_transparent_background=1
colorscheme sonokai

syntax on
set termguicolors
set noswapfile
set noerrorbells
set belloff=all
set tabstop=2 softtabstop=2
set smartindent
set smarttab
set autoindent
set cindent
set shiftwidth=2
set expandtab
set relativenumber
set number
autocmd InsertEnter * set norelativenumber
autocmd InsertLeave * set relativenumber
set ruler
set backspace=indent,eol,start
set clipboard+=unnamedplus

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

let mapleader=" "
nnoremap <c-f> :<c-f>
vnoremap <C-c> ::w !clip.exe<CR><CR>
inoremap jk <ESC>
nnoremap <leader>; :vertical resize -5<CR>
nnoremap <leader>' :vertical resize +5<CR>
nnoremap <leader>e :Explore<CR>
nnoremap <leader>w :w!<CR>
nnoremap <leader>q :q!<CR> 
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>
nnoremap <c-k> <C-w>k
nnoremap <c-j> <C-w>j
nnoremap <c-h> <C-w>h
nnoremap <c-l> <C-w>l
nnoremap <leader>- _;
vnoremap <leader>- _;
nnoremap J H
nnoremap K L
nnoremap <s-l> :tabnext<CR>
nnoremap <s-h> :tabprevious<CR>

" c++
"autocmd filetype cpp nnoremap <leader>g :w <bar> !g++ -std=c++17 -O2 -Wall % -o %:r && %:r.exe<CR>
autocmd filetype cpp nnoremap <leader>d :w <bar> !g++ -std=c++17 -O2 -Wall % -o %:r<CR>
autocmd filetype cpp nnoremap <leader>f :!./%:r < input.txt <CR>
autocmd filetype python nnoremap <leader>f :!python3 %:r.py < input.txt<CR>
"autocmd filetype cpp nnoremap <leader>g :!./%:r<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetDirectories=["~/UltiSnips"]


"nerdtree
nnoremap <leader>e :Neotree<CR>
nnoremap <C-e> :Neotree toggle<CR>

"conqueror of completion
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nnoremap <silent> gh :call ShowDocumentation()<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('gh', 'in')
  endif
endfunction

"fuzzy finder
" Search files with <Leader>f
nnoremap <leader>g :Files<CR>

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- List of languages you want to enable
  ensure_installed = { "python", "lua", "cpp"},

  -- Automatically install missing parsers when entering a buffer
  auto_install = true,

  highlight = {
    enable = true,                -- Enable Tree-sitter-based syntax highlighting
    additional_vim_regex_highlighting = false, -- Disable Vim's regex-based highlighting
  },
  indent = {
    enable = true,                -- Enable Tree-sitter-based indentation
  },
  -- Optional: rainbow parentheses
  rainbow = {
    enable = true,
    extended_mode = true,          -- Highlight non-bracket delimiters like html tags
    max_file_lines = nil,          -- Do not limit by file length
  }
}

require("neo-tree").setup({
    -- Add your desired configuration here
    window = {
        position = "left", -- or "right", "top", "bottom"
        width = 30,        -- set width of the Neo-tree window
    },
})

EOF

