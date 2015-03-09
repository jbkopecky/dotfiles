"==============================================================================
" JBK Dotfiles
"==============================================================================

call plug#begin('~/.vim/plugged')

" Colors
Plug 'nanotech/jellybeans.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'bling/vim-airline'

" Edit
Plug 'scrooloose/nerdcommenter'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'msanders/snipmate.vim'

" Notes
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'

" Browsing
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'kien/ctrlp.vim'
Plug 'Lokaltog/vim-easymotion'

" Tmux
Plug 'benmills/vimux', {'on': 'VimuxPromptCommand'}

" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Lang
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'LaTeX-Box-Team/LaTeX-Box', {'for': 'latex'}
Plug 'chrisbra/csv.vim', {'for': 'csv'}

call plug#end()

set nocompatible
set laststatus=2

" Rebind <Leader> key *********************************************************
let g:mapleader = "\<Space>"

" Enable syntax highlighting **************************************************
filetype plugin on
filetype plugin indent on
syntax on
let g:tex_flavor="latex" "Recognise Latex files

" Split navigation ************************************************************
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map <Leader>p <C-^>

" Font and colors Settings ****************************************************
set t_Co=256
set background=dark
silent! colorscheme jellybeans
let g:airline_themes='jellybeans'

" Mouse and backspace *********************************************************
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again

" Showing line numbers and length *********************************************
set number  " show line numbers
set tw=79   " width of document (used by gd)
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
set cursorline

" Useful settings *************************************************************
set history=700
set wildmenu
set wildmode=list:longest,full
set undolevels=700
set incsearch "show search as I type
set hlsearch
set ignorecase
set smartcase
set ttimeoutlen=100 "shorter exit time
set scrolloff=3
set wildmenu
set wildmode=list:longest,full
set nofoldenable
set backupdir=~/.vim/backups//
set directory=~/.vim/swaps//
set undodir=~/.vim/undo//
set nostartofline

" Invisible Characters ********************************************************
set listchars=tab:\|\ ,trail:⋅,eol:¬
noremap <Leader>i :set list!<CR>

" Tabs ************************************************************************
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Airline *********************************************************************
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1

" Nerdtree settings ***********************************************************
map <Leader>n :NERDTreeToggle<CR>
let g:nerdtree_tab_open_on_gui_startup=0
"let g:NERDTreeDirArrows=0

" Notes Settings
let g:notes_directories = ['~/Dropbox/Notes']

" Vimux Settings **************************************************************
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <leader>vx :VimuxInterruptRunner<CR>
let g:VimuxOrientation = "v"

" Easy motion settings: *******************************************************
let g:EasyMotion_do_mapping = 0 "Disable default mappings
nmap s <Plug>(easymotion-s)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Settings for ctrlp **********************************************************
let g:ctrlp_max_height = 30
set wildignore=*/tmp/*,*.pyc,*.swp,*.so,*.zip,*.o,.DS_Store

" Settings for jedi-vim *******************************************************
au Filetype python let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
au Filetype python set nowrap
let g:python_highlight_all = 1
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
let g:jedi#usages_command = "<leader>z"
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
