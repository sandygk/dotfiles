" Vundle
call plug#begin('~/.vim/plugged')

  " nerdtree
  Plug 'preservim/nerdtree'

  " syntax highlight for tsx
  Plug 'ianks/vim-tsx'

  " syntax highlight for typescript
  Plug 'leafgarland/typescript-vim'

  " syntax highlight for javascript
  Plug 'pangloss/vim-javascript'

  " syntax highlight for fish
  Plug 'dag/vim-fish'

  " intellisense
  "Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " fzf
  Plug 'junegunn/fzf.vim'

  " sneak
  Plug 'justinmk/vim-sneak'

call plug#end()

" Add labels to sneak motions
let g:sneak#label = 1

" Make sneak case insensitive
let g:sneak#use_ic_scs = 1

" Open files with fzf
map <C-p> :Files<CR>

" Open git tracked files with fzf
map <A-p> :GFiles<CR>

" Search across project
map <C-f> :Rg<space>

" set fzf layout
let g:fzf_layout = { 'down': '~25%' }

" ignore node_modules by using ag
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Toggle nerdtree
map <C-e> :NERDTreeToggle<CR>

" Coc configuration
"source $HOME/.config/nvim/coc.vim

" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
