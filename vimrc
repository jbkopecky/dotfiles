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

" Runtime Path ************************************************************ {{{
if has("win32")
    let &runtimepath = substitute(&runtimepath,'\(Documents and Settings\|Users\)[\\/][^\\/,]*[\\/]\zsvimfiles\>','.vim','g')
endif
" }}}

" Plugins ! *************************************************************** {{{
silent! call plug#begin('~/.vim/plugged')

" Colors
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'

Plug 'junegunn/goyo.vim',      {'on': 'Goyo'}
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}

Plug 'bling/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'mhinz/vim-startify'

Plug 'chrisbra/colorizer', {'on': 'ColorHighlight'}

" Edit
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-characterize'
Plug 'ervandew/supertab'
Plug 'junegunn/vim-easy-align', {'on': ['<Plug>(EasyAlign)', 'EasyAlign']}
Plug 'AndrewRadev/splitjoin.vim'

" snippets (first 2 plugins are dependencies)
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'tomtom/tlib_vim'
" Plug 'garbas/vim-snipmate'


" Browsing
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'kien/ctrlp.vim'
Plug 'justinmk/vim-gtfo'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'

" Tmux
Plug 'tpope/vim-dispatch'

" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Lang
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'tpope/vim-markdown', {'for': ['mkd', 'md', 'markdown']}
" Plug 'vim-scripts/rainbow_csv.vim', {'for': 'csv'}
Plug 'junegunn/vim-journal'

call plug#end()
"}}}

" Preamble **************************************************************** {{{
set nocompatible                     " Get rid of Vi compatibility
set laststatus=2                     " Always show status bar
set mouse=a                          " Enable Mouse
set bs=2                             " Normal backspace
set history=700                      " More cmd line history
set undolevels=700                   " More undo
set wildmenu                         " Cmd completion
set wildmode=longest:full,full       " Cmd completion options
set incsearch                        " Show search result as I type
set hlsearch                         " Highlight search results
set ignorecase                       " Search for min and maj
set smartcase                        " If maj asked, only look for maj
set ttimeoutlen=100                  " Faster Escape
set scrolloff=3                      " Leave 3 l bellow cursos when scrolling
set foldmethod=marker                " Fold on markers
set backupdir=~/.vim/backups//       " Specify backup dir
set directory=~/.vim/swaps//         " Specify swap dir
set number                           " Show line number
set tw=79                            " No more than 80 col
set colorcolumn=80                   " Color 80 col
set fo-=t                            " no automatic wrap text when typing
set linebreak                        " Breaks fold at end of word
set cursorline                       " Show cursor line
set clipboard=unnamed                " Easier paste
set tabstop=4                        " Four spaces tabs
set shiftwidth=4                     " Four spaces shifts
set shiftround                       " Round Shifts
set expandtab smarttab               " Smart tabs
set fileformats=unix,dos,mac         " Freaking formats
set encoding=utf-8 nobomb            " Freaking formats
set noshowmode                       " dont show mode. airline does it
set lazyredraw                       " Speed up things
set splitright                       " More natural split opening
set tags=./tags;/                    " ctags
if exists('+undofile')               " If possible
  set undofile                       " Set Undo file
  set undodir=~/.vim/undo//          " Specify undodir
endif
"}}}

" Colors ****************************************************************** {{{
set t_Co=256
set background=dark
if has('gui_running')
  let g:airline_theme = 'seoul256'
  let g:seoul256_light_background = 255
  let g:seoul256_background = 237
  silent! colorscheme seoul256-light
else
  silent! colorscheme gruvbox
endif
"}}}

" Invisible Characters **************************************************** {{{
set listchars=tab:▸\ ,trail:⋅,eol:¬,precedes:«,extends:»
let &showbreak = '↪ '
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
    return line . ' ' . repeat("-",fillcharcount) . ' ' . foldedlinecount . ' ' . '  '
endfunction " }}}
set foldtext=MyFoldText()
"}}}

" File Type *************************************************************** {{{
let g:tex_flavor="latex" "Recognise Latex files

if has("autocmd")
    augroup FTOptions
        autocmd!
        autocmd Filetype python setl nowrap
        autocmd Filetype python setl foldmethod=indent
        autocmd Filetype mail setl tw=76
        autocmd Filetype mail setl fo+=aw
        autocmd FileType help nnoremap <silent><buffer> q :q<CR>
    augroup END

    augroup FTCheck
        autocmd!
        autocmd Bufread,BufNewFile *.csv,*.dat set ft=csv
        autocmd Bufread,BufNewFile *.journal set ft=journal
    augroup END
endif

"}}}

" Mappings **************************************************************** {{{

" Leader
let g:mapleader = "\<Space>"
let g:maplocalleader = "\<Space>"

" Escape shorcut
inoremap kj <Esc>

" Split Join
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

" Splits Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Motions
noremap H ^
noremap L g_

nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv
nmap <Up> [e
nmap <Down> ]e
vmap <Up> [egv
vmap <Down> ]egv

" Leader Mappings
map <silent> <Leader>q :ccl<CR>
map <silent> <Leader>n :NERDTreeToggle<CR>
map <silent> <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
map <silent> <Leader>c :cd %:p:h<CR>
map <Leader>i :set list!<CR>
map <Leader>h <Plug>Howdoi
nnoremap <silent> <Leader><Leader> :noh<CR>
nnoremap <silent> <Leader>N :CtrlP ~/Dropbox/Notes<CR>
nnoremap <Leader>G :Goyo<CR>
nnoremap U :UndotreeToggle<CR>
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

" F Mappings
nnoremap <F5> :w<CR> :Dispatch<CR>
nnoremap <F8> :call <SID>rotate_colors()<cr>

"}}}

" Abbreviations *********************************************************** {{{
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q
" }}}

" Plugins Settings ******************************************************** {{{

" Airline ***************************************************************** {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1
if exists('$TMUX')
    let g:airline#extensions#tmuxline#snapshot_file = "~/.tmux-statusline-colors.conf"
endif
"}}}

" Nerdtree **************************************************************** {{{
let g:nerdtree_tab_open_on_gui_startup=0
"}}}

" Dispatch **************************************************************** {{{
autocmd FileType python let b:dispatch = 'python %'
"}}}

" SuperTab **************************************************************** {{{
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = "<c-p>"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<c-x><c-o>"]

autocmd FileType *
  \ if &omnifunc != '' |
  \   call SuperTabChain(&omnifunc, "<c-p>") |
  \ endif
"}}}

" Jedi-vim **************************************************************** {{{
let g:python_highlight_all = 1
let g:jedi#popup_on_dot = 0
let g:jedi#usages_command = "<leader>u"
"}}}

" Startify **************************************************************** {{{
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

" CtrlP ******************************************************************* {{{
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \}
"}}}

" Goyo & Limelight ******************************************************** {{{
let g:limelight_paragraph_span = 1
let g:limelight_conceal_ctermfg = 'DarkGray'
let g:limelight_default_coefficient = 0.7

function! s:goyo_enter()
    if has('gui_running')
        silent !set fullscreen
        set linespace=7
    elseif exists('$TMUX')
        silent !tmux set status off
    endif
    Limelight
endfunction

function! s:goyo_leave()
    if has('gui_running')
        silent !set nofullscreen
        set linespace=0
    elseif exists('$TMUX')
        silent !tmux set status on
    endif
    Limelight!
endfunction

autocmd User GoyoEnter nested call <SID>goyo_enter()
autocmd User GoyoLeave nested call <SID>goyo_leave()
"}}}

" vimtex ****************************************************************** {{{
let g:vimtex_complete_enabled = 0
"}}}

" Markdown **************************************************************** {{{
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
"}}}

" CSV ********************************************************************* {{{
let g:rcsv_delimiters = ['	',';',',']
"}}}

" journal ***************************************************************** {{{
let g:journal#dirs = ['Notes']
"}}}

"}}}

" Color Toggle ************************************************************ {{{
function! s:rotate_colors()
  "{{{
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
  execute 'colorscheme' name
  silent! execute 'AirlineTheme' name
  redraw
  echo name
endfunction "}}}
"}}}

" Local Vimrc ************************************************************* {{{
if filereadable(glob("~/.local.vimrc"))
  so ~/.local.vimrc
endif
"}}}
