" ~/.vimrc ~/.config/nvim/init.vim

" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'tomasiser/vim-code-dark'
Plugin 'joshdick/onedark.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin '907th/vim-auto-save'
Plugin 'ap/vim-buftabline'

call vundle#end()
filetype plugin indent on

" change the mapleader from \ to space
" NOTE: This has to be set before <leader> is used.
let mapleader=" "

" Show hidden files in NERDTree
let g:NERDTreeShowHidden=1

" Set the size of NERDTree
let g:NERDTreeWinSize=25

" Set theme
syntax on
color onedark

" Enable mouse
set mouse=a

" Disable continuation of comments to the next line
autocmd BufReadPost * set fo-=c fo-=r fo-=o

" Insert and delete empty lines in Normal mode
" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
" source: https://vim.fandom.com/wiki/Quickly_adding_and_deleting_empty_lines
nnoremap <silent><A-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Hide welcome message
set shortmess=I

" Autosave
let g:auto_save       =1
let g:auto_save_silent=1
let g:auto_save_events=["InsertLeave", "TextChanged", "FocusLost"]

" Navigate to another buffer without saving the current one
set hidden

" Set airline theme
let g:airline_theme='minimalist'

" Remove separators for empty sections
let g:airline_skip_empty_sections=1

" Search hidden files with ctrlp
let g:ctrlp_show_hidden=1

" With this option set, v will match both v and V, but V will match V only.
let g:EasyMotion_smartcase=1

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
