"=============================================================================="
"                                  JBK .vimrc                                  "
"=============================================================================="

"{{{ Plugins ! *******************************************************

call plug#begin('~/.vim/plugged')

" Colors
Plug 'nanotech/jellybeans.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'

" Edit
Plug 'scrooloose/nerdcommenter'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" snippets (first 2 plugins are dependencies)
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'

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
Plug 'lervag/vimtex', {'for': 'tex'}
"Plug 'matze/vim-tex-fold', {'for': 'tex'}
Plug 'chrisbra/csv.vim', {'for': 'csv'}

call plug#end()
"}}}

"{{{ General Settings ************************************************

set nocompatible
set laststatus=2

"{{{ Rebind <Leader> key *********************************************
let g:mapleader = "\<Space>"
let g:maplocalleader = "\<Space>"
"}}}

"{{{ Enable syntax highlighting **************************************
filetype plugin on
filetype plugin indent on
syntax on
let g:tex_flavor="latex" "Recognise Latex files
"}}}

"{{{ Split navigation ************************************************
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map <Leader>p <C-^>
"}}}

"{{{ Font and colors Settings ****************************************
set t_Co=256
set background=dark
silent! colorscheme jellybeans
let g:airline_themes='jellybeans'
let g:bufferline_echo=0
"}}}

"{{{ Mouse and backspace *********************************************
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again
"}}}

"{{{ Showing line numbers and length *********************************
set number  " show line numbers
set tw=79   " width of document (used by gd)
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
set cursorline
"}}}

"{{{ Useful settings *************************************************
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
set foldmethod=marker
set foldopen+=jump
set backupdir=~/.vim/backups//
set directory=~/.vim/swaps//
set undodir=~/.vim/undo//
set nostartofline
"}}}

"{{{ Invisible Characters ********************************************
set listchars=tab:\|\ ,trail:⋅,eol:¬
noremap <Leader>i :set list!<CR>
"}}}

"{{{ Tabs ************************************************************
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
"}}}

" End Of General Settings }}}

"{{{ Airline *********************************************************
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1
"}}}

"{{{ Nerdtree ********************************************************
map <Leader>n :NERDTreeToggle<CR>
let g:nerdtree_tab_open_on_gui_startup=0
"}}}

"{{{ Notes ***********************************************************
let g:notes_directories = ['~/Dropbox/Notes']
let g:notes_suffix = '.txt'
"}}}

"{{{ Vimux ***********************************************************
map <Leader>vp :w<CR>:VimuxPromptCommand<CR>
map <Leader>vl :w<CR>:VimuxRunLastCommand<CR>
map <leader>vx :VimuxInterruptRunner<CR>
let g:VimuxOrientation = "v"
"}}}

"{{{ Easy motion *****************************************************
let g:EasyMotion_do_mapping = 0 "Disable default mappings
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
"}}}

"{{{ Ctrlp ***********************************************************
let g:ctrlp_max_height = 30
set wildignore=*/tmp/*,*.pyc,*.swp,*.so,*.zip,*.o,.DS_Store
"}}}

"{{{ Jedi-vim ********************************************************
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
au Filetype python set nowrap
let g:python_highlight_all = 1
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
let g:jedi#usages_command = "<leader>z"
"}}}

"{{{ Snipmate ********************************************************
let g:snips_author = 'JB Kopecky' 
"}}}

"{{{ Mails ***********************************************************
au Filetype mail setl tw=76
au Filetype mail setl fo+=aw
"}}}

"{{{ Vimtex **********************************************************
au BufEnter *.tex setl tx fo+=n2a
"let g:vimtex_fold_enabled=1
"}}}

"{{{ Goyo & Limelight ************************************************
let g:limelight_paragraph_span = 1
let g:limelight_conceal_ctermfg = 'DarkGray'

function! s:goyo_enter()
    if has('gui_running')
        set fullscreen
        set linespace=7
    elseif exists('$TMUX')
        silent !tmux set status off
    endif
    Limelight
endfunction

function! s:goyo_leave()
    if has('gui_running')
        set nofullscreen
        set linespace=0
    elseif exists('$TMUX')
        silent !tmux set status on
    endif
    Limelight!
endfunction

autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd User GoyoEnter nested call <SID>goyo_enter()
autocmd User GoyoLeave nested call <SID>goyo_leave()

nnoremap <Leader>G :Goyo<CR>
"}}}

"{{{ Color Toggle ****************************************************
function! s:rotate_colors()
  if !exists('s:colors_list')
    let s:colors_list =
    \ sort(map(
    \   filter(split(globpath(&rtp, "colors/*.vim"), "\n"), 'v:val !~ "^/usr/"'),
    \   "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"))
  endif
  if !exists('s:colors_index')
    let s:colors_index = index(s:colors_list, g:colors_name)
  endif
  let s:colors_index = (s:colors_index + 1) % len(s:colors_list)
  let name = s:colors_list[s:colors_index]
  execute 'colorscheme' name
  redraw
  echo name
endfunction

nnoremap <F8> :call <SID>rotate_colors()<cr>
"}}}
