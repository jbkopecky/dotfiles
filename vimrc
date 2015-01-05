set nocompatible

"Pathogen
call pathogen#infect()
call pathogen#helptags()

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

" No Arrow Keys !
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

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
map <C-n> <Plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tab_open_on_gui_startup=0
let g:NERDTreeDirArrows=0

" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" Rebind <Leader> key
let g:mapleader = ","

" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
set cursorline

" Useful settings
set history=700
set wildmenu
set wildmode=list:longest,full
set undolevels=700
set incsearch "show search as I type
set hlsearch
set ignorecase
set smartcase
set ttimeoutlen=100 "shorter exit time
set vb "enable visual bell and disable sound bell
set scrolloff=3
set wildmenu
set wildmode=list:longest,full
set nofoldenable

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Easy motion settings:
let g:EasyMotion_do_mapping = 0 "Disable default mappings
nmap s <Plug>(easymotion-s)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Settings for ctrlp
let g:ctrlp_max_height = 30
set wildignore=*/tmp/*,*.pyc,*.swp,*.so,*.zip,*.o,.DS_Store

" Settings for jedi-vim
let g:jedi#popup_select_first = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
