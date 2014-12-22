"Pathogen
call pathogen#infect()


" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %
set laststatus=2

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype on
filetype plugin on
filetype plugin indent on
syntax on
syntax enable
let g:tex_flavor='latex' "Recognise Latex files


" Font and colors Settings (For Powerline Patches)
set t_Co=256
if has("gui_running")  
  set background=light
  colorscheme pencil
  let g:airline_themes='pencil'
  set guifont=Consolas:h12
  set guioptions-=m "No Menu
  set guioptions-=T "No toolbar
  set guioptions-=r "No scrollbar
  set guioptions-=b "No scrollbar
  set guioptions-=L "No scrollbar
else
  set background=dark  
  colorscheme jellybeans
  let g:airline_themes='jellybeans'
endif

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#whitespace#enabled = 1
let g:airline_inactive_collapse=0
let g:airline_left_sep=''
let g:airline_right_sep=''


"Nerdtree remap to ctrl + n
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0   

" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again


" Rebind <Leader> key
let mapleader = "\<Space>"


" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80


" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


" Settings for ctrlp
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" ============================================================================
" Python IDE Setup
" ============================================================================

" Settings for jedi-vim
let g:jedi#popup_select_first = 0

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Python folding
set nofoldenable
