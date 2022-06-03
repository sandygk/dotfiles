" change the mapleader from \ to space
" NOTE: This has to be set before <leader> is used.
let mapleader=" "

" Set my custom theme
colorscheme theme

" Autosave
:au FocusLost * :w

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Keep selection after indentation
vmap < <gv
vmap > >gv

" Alternate way to save
nnoremap <C-s> :w<CR>

" Alternate way to quit
nnoremap <C-Q> :wq!<CR>

" Shortcutting split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Escape insert mode with jj
inoremap jj <Esc>

" hide highlight
map <Leader>/ :nohl<CR>

" enable true colors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Enable mouse
set mouse=a

" Disable continuation of comments to the next line
autocmd BufReadPost * set fo-=c fo-=r fo-=o

" Insert and delete empty lines
map <silent><A-n> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
map <silent><A-m> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
map <silent><C-n> :set paste<CR>m`o<Esc>``:set nopaste<CR>
map <silent><C-m> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Hide welcome message
set shortmess=I

" Navigate to another buffer without saving the current one
set hidden

" Save 1,000 items in history
set history=1000

" enable indentation
set breakindent

" prefix indent with |
set showbreak=\|

" Navigate to next wrapped line
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

" Copy from and to clipboard
set clipboard=unnamedplus

" Toggle spell checker
:map <F6> :setlocal spell! spelllang=en_us<CR>
:highlight clear SpellCap
:highlight clear SpellRare
:highlight clear SpellLocal

" Display the incomplete commands in the bottom right-hand side of your screen.
set showcmd

" Show the line and column number of the cursor position
set ruler

" Display completion matches on your status line
set wildmenu

" Show a few lines of context around the cursor
set scrolloff=3

" Highlight search matches
set hlsearch

" Enable incremental searching
set incsearch

" Ignore case when searching
set ignorecase

" Override the 'ignorecase' option if the search pattern contains upper case characters.
set smartcase

" Turn on line numbering and relative number
set number
set relativenumber

" Turn on file backups
set backup

" Don't line wrap mid-word.
set lbr

" Copy the indentation from the current line.
set autoindent

" Enable smart autoindenting.
set smartindent

" Use spaces instead of tabs
set expandtab

" Enable smart tabs
set smarttab

" Make a tab equal to 2 spaces
set shiftwidth=2
set tabstop=2

" Map Y to act like D and C, i.e. yank until EOL, rather than act like yy
map Y y$

" Navigate buffers
nnoremap <tab>   :bn<cr>
nnoremap <s-tab> :bp<cr>

" Open file manager
map <leader>e :NERDTreeToggle<CR>

" Close buffer
map <leader>x :bd<cr>

" Save
map <leader>w :w<cr>

" Quit
map <leader>q :q<cr>

" Disable backups
set nobackup
set nowritebackup
