"=============================================================================="
"
"     ______/\\\\\\\\\\\___/\\\\\\\\\\\\\_____/\\\________/\\\_
"      _____\/////\\\///___\/\\\/////////\\\__\/\\\_____/\\\//__
"       _________\/\\\______\/\\\_______\/\\\__\/\\\__/\\\//_____
"        _________\/\\\______\/\\\\\\\\\\\\\\___\/\\\\\\//\\\_____
"         _________\/\\\______\/\\\/////////\\\__\/\\\//_\//\\\____
"          _________\/\\\______\/\\\_______\/\\\__\/\\\____\//\\\___
"           __/\\\___\/\\\______\/\\\_______\/\\\__\/\\\_____\//\\\__
"            _\//\\\\\\\\\_______\/\\\\\\\\\\\\\/___\/\\\______\//\\\_
"             __\/////////________\/////////////_____\///________\///__
"
"=============================================================================="

"{{{ Plugins ! *******************************************************

call plug#begin('~/.vim/plugged')

" Colors
Plug 'nanotech/jellybeans.vim'
"Plug 'reedes/vim-colors-pencil'
Plug 'junegunn/seoul256.vim'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'bling/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'mhinz/vim-startify'

" Edit
Plug 'scrooloose/nerdcommenter'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" snippets (first 2 plugins are dependencies)
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'

" Browsing
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Lokaltog/vim-easymotion'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': 'yes\| ./install'}

" Tmux
Plug 'benmills/vimux', {'on': 'VimuxPromptCommand'}

" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Lang
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'chrisbra/csv.vim', {'for': 'csv'}
Plug 'plasticboy/vim-markdown', {'for': 'mkd'}

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
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#snapshot_file = "~/.tmux-statusline-colors.conf"
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_left_sep=''
"let g:airline_right_sep=''
"}}}

"{{{ Nerdtree ********************************************************
map <Leader>n :NERDTreeToggle<CR>
let g:nerdtree_tab_open_on_gui_startup=0
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

"{{{ SuperTab ********************************************************
au Filetype python let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"}}}

"{{{ Jedi-vim ********************************************************
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
au Filetype python set nowrap
let g:python_highlight_all = 1
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
let g:jedi#usages_command = "<leader>z"
"}}}

"{{{ Startify ********************************************************
let g:startify_custom_header = [
            \ '                 __     __       ',
            \ '                /  \~~~/  \      ',
            \ '          ,----(     ..    )     ',
            \ '         /      \__     __/     << Celui qui abandonne un jour,',
            \ '        /|         (\  |(           Abandonnera toute sa vie ! >>',
            \ '       ^ \   /___\  /\ |                                         Marius',
            \ '          |__|   |__|-"           ',
            \ '',
            \ ]
"}}}

"{{{ Snipmate ********************************************************
"}}}

"{{{ Mails ***********************************************************
au Filetype mail setl tw=76
au Filetype mail setl fo+=aw
"}}}

"{{{ Vimtex **********************************************************
au BufEnter *.tex setl tx fo+=n2a
"}}}

"{{{ CtrlP ***********************************************************
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \}
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
  execute 'AirlineTheme base16'
  execute 'colorscheme' name
  redraw
  echo name
endfunction

function! s:sync_term_colors()
  let s:bg_patch = {'jellybeans': '#121212', 'seoul256': '#383838', 'seoul256-light': '#d9d9d9',}
  let s:fg_color = synIDattr(synIDtrans(hlID('Normal')), 'fg', 'gui')
  let s:bg_color = synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui')
  let s:bg_color = get(s:bg_patch, g:colors_name,  s:bg_color)
  call  system('gconftool --set --type string \/apps\/gnome-terminal\/profiles\/Default\/foreground_color '.'"'.s:fg_color.'"')
  call  system('gconftool --set --type string \/apps\/gnome-terminal\/profiles\/Default\/background_color '.'"'.s:bg_color.'"')
  redraw
endfunction

nnoremap <F8> :call <SID>rotate_colors()<cr>
if has('unix')
  nnoremap <F9> :call <SID>sync_term_colors()<cr>
endif
"}}}

