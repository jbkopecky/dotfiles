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

" Plugins ! *************************************************************** {{{

silent! call plug#begin('~/.vim/plugged')

" Colors
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'

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
Plug 'tpope/vim-dispatch', {'on': 'Dispatch'}

" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Lang
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'chrisbra/csv.vim', {'for': 'csv'}
Plug 'plasticboy/vim-markdown', {'for': ['mkd', 'md', 'markdown']}

call plug#end()
"}}}

" General Settings ******************************************************** {{{

set nocompatible
set laststatus=2

" Rebind <Leader> key ***************************************************** {{{
let g:mapleader = "\<Space>"
let g:maplocalleader = "\<Space>"
"}}}

" Enable syntax highlighting ********************************************** {{{
filetype plugin on
filetype plugin indent on
syntax on
let g:tex_flavor="latex" "Recognise Latex files
"}}}

" Split navigation ******************************************************** {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map <Leader>p <C-^>
"}}}

" Font and colors Settings ************************************************ {{{
set t_Co=256
set background=dark
silent! colorscheme jellybeans
"}}}

" Mouse and backspace ***************************************************** {{{
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again
"}}}

" Useful settings ********************************************************* {{{
set history=700
set wildmenu
set wildmode=list:longest,full
set undolevels=700
set incsearch
set hlsearch
set ignorecase
set smartcase
set ttimeoutlen=100
set scrolloff=3
set wildmenu
set wildmode=list:longest,full
set foldmethod=marker
set foldopen+=jump
set backupdir=~/.vim/backups//
set directory=~/.vim/swaps//
set undodir=~/.vim/undo//
set number
set tw=79
set fo-=t   " don't automatically wrap text when typing
set linebreak " Breaks fold at end of word only if listchar is off
set colorcolumn=80
set cursorline
set clipboard=unnamed
"}}}

" Invisible Characters **************************************************** {{{
set listchars=tab:▸\ ,trail:⋅,eol:¬,precedes:«,extends:»
let &showbreak = '↪ '
noremap <Leader>i :set list!<CR>
"}}}

" Tabs ******************************************************************** {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
"}}}

" Folding ***************************************************************** {{{
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 5
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . ' ' . repeat("-",fillcharcount) . ' ' . foldedlinecount . '…' . '  '
endfunction " }}}
set foldtext=MyFoldText()
"}}}

" Misc ******************************************************************** {{{
"Paste toggle
map <Leader>pp :setlocal paste!<CR>
map <silent> <Leader><CR> :noh<CR>

noremap H ^
noremap L g_
"}}}

" End Of General Settings }}}

" Airline ***************************************************************** {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1
if exists('$TMUX')
    let g:airline#extensions#tmuxline#snapshot_file = "~/.tmux-statusline-colors.conf"
endif
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_left_sep=''
"let g:airline_right_sep=''
"}}}

" Nerdtree **************************************************************** {{{
map <Leader>n :NERDTreeToggle<CR>
let g:nerdtree_tab_open_on_gui_startup=0
"}}}

" Vimux ******************************************************************* {{{
map <Leader>vp :w<CR>:VimuxPromptCommand<CR>
map <Leader>vl :w<CR>:VimuxRunLastCommand<CR>
map <leader>vx :VimuxInterruptRunner<CR>
let g:VimuxOrientation = "v"
"}}}

" Easy motion ************************************************************* {{{
let g:EasyMotion_do_mapping = 0 "Disable default mappings
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
"}}}

" SuperTab **************************************************************** {{{
au Filetype python let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"}}}

" Jedi-vim **************************************************************** {{{
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
au Filetype python set nowrap

let g:python_highlight_all = 1
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
let g:jedi#usages_command = "<leader>z"
"}}}

" Startify **************************************************************** {{{
let g:startify_bookmarks = [ '~/.dotfiles/vimrc' ]
let g:startify_files_number = 5

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

" Mails ******************************************************************* {{{
au Filetype mail setl tw=76
au Filetype mail setl fo+=aw
"}}}

" CtrlP ******************************************************************* {{{
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \}
" Notes
silent! nnoremap <Leader>N :CtrlP ~/Dropbox/Notes<CR>
"}}}

" Goyo & Limelight ******************************************************** {{{
let g:limelight_paragraph_span = 1
let g:limelight_conceal_ctermfg = 'DarkGray'
let g:limelight_default_coefficient = 0.7

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

" Color Toggle ************************************************************ {{{
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
  set bg=dark
  execute 'AirlineTheme base16'
  execute 'colorscheme' name
  redraw
  echo name
endfunction


nnoremap <F8> :call <SID>rotate_colors()<cr>
"}}}

" Local Vimrc ************************************************************* {{{
if filereadable(glob("~/.local.vimrc"))
  so ~/.local.vimrc
endif
"}}}

