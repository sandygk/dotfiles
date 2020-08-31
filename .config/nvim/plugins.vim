" Vundle
call plug#begin('~/.vim/plugged')

  " nerdtree
  Plug 'preservim/nerdtree'

  " quickly move around
  Plug 'easymotion/vim-easymotion'

  " syntax highlight for typescript
  Plug 'leafgarland/typescript-vim'

  " syntax highlight for tsx
  Plug 'ianks/vim-tsx'

  " syntax highlight for fish
  Plug 'dag/vim-fish'

  " intellisense
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " fzf
  Plug 'junegunn/fzf.vim'
call plug#end()

" With this option set, v will match both v and V, but V will match V only.
let g:EasyMotion_smartcase=1

" Toggle nerdtree
map <C-n> :NERDTreeToggle<CR>

" Coc configuration
source $HOME/.config/nvim/coc.vim

" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
