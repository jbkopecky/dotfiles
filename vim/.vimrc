" -----------------------------------------------------------------------------
" File: vimrc
" Author: JB Kopecky <jb.kopecky@gmail.com>
" Source: https://github.com/jbkopecky/dotfiles
" -----------------------------------------------------------------------------

" Runtime Path ************************************************************ {{{
if has('win32')
    let &runtimepath = substitute(&runtimepath,'\(Documents and Settings\|Users\)[\\/][^\\/,]*[\\/]\zsvimfiles\>','.vim','g')
endif
" }}}

" Plugins ! *************************************************************** {{{

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

silent! call plug#begin('~/.vim/plugged')

Plug 'dylanaraps/wal.vim'
Plug 'junegunn/seoul256.vim'

" Plug 'jbkopecky/statusline.vim'
Plug 'mhinz/vim-signify'
Plug 'ap/vim-buftabline'
Plug 'lifepillar/vim-mucomplete'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'

Plug 'junegunn/vim-easy-align', {'on': ['<Plug>(EasyAlign)','EasyAlign']}
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}

Plug 'mbbill/undotree',      {'on': 'UndotreeToggle'}
Plug 'scrooloose/nerdtree',  {'on': 'NERDTreeToggle'}

Plug 'godlygeek/tabular', {'for': ['md', 'mkd', 'markdown']}
Plug 'plasticboy/vim-markdown', {'for': ['md', 'mkd', 'markdown']}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'chrisbra/colorizer', {'on': 'ColorHighlight'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'chrisbra/csv.vim', {'for': 'csv'}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()
"}}}

" Preamble **************************************************************** {{{
set nocompatible                 " Get rid of Vi compatibility
set noshowmode                   " dont show mode. airline does it
set mouse=a                      " Enable Mouse
set backspace=2                  " Normal backspace
set history=700                  " More cmd line history
set undolevels=700               " More undo
set wildmenu                     " Cmd completion
set wildmode=longest,full:full   " Cmd completion options
set completeopt+=longest,menuone " Start at the head of the popup menulist
set complete=.,w,b,t,kspell      " Completion scope
set incsearch                    " Show search result as I type
set hlsearch                     " Highlight search results
set ignorecase                   " Search for min and maj
set smartcase                    " If maj asked, only look for maj
set ttimeoutlen=100              " Faster Escape
set scrolloff=3                  " Leave 3 l bellow cursos when scrolling
set foldmethod=marker            " Fold on markers
set textwidth=79                 " No more than 80 col
set formatoptions-=t             " no automatic wrap text when typing
set linebreak                    " Breaks fold at end of word
set tabstop=4                    " Four spaces tabs
set shiftwidth=4                 " Four spaces shifts
set shiftround                   " Round Shifts
set expandtab smarttab           " Smart tabs
set fileformats=unix,dos,mac     " Freaking formats
set encoding=utf-8 nobomb        " Freaking formats
set clipboard=unnamed
set lazyredraw                   " Speed up things
set splitright                   " More natural split opening
set laststatus=0                " Always show status bar
set fillchars=
set noruler
set noshowcmd
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set backupdir=~/.vim/backups/
set noswapfile

if exists('+undofile')           " If possible
  set undofile                   " Set Undo file
  set undolevels=500
  set undoreload=500
  set undodir=~/.vim/undo/    " Specify undodir
endif

if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), 'p')
endif

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), 'p')
endif

silent! colo wal

"}}}

" Folding ***************************************************************** {{{
fu! CustomFoldText() "{{{
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile

    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let expansionString = " " . repeat("-", w - strwidth(foldSizeStr.line.foldLevelStr) - 1)
    return line . expansionString . foldSizeStr . foldLevelStr
endf "}}}
set foldtext=CustomFoldText()
"}}}

" FileType **************************************************************** {{{
let g:tex_flavor='latex' "Recognise Latex files
if has('autocmd')
    augroup Misc "{{{
        autocmd!
        autocmd FocusGained * if !has('win32') | silent! call fugitive#reload_status() | endif
        autocmd BufReadPost * if getline(1) =~# '^#!' | let b:dispatch = getline(1)[2:-1] . ' %' | let b:start = b:dispatch | endif
        autocmd BufReadPost ~/.Xdefaults,~/.Xresources let b:dispatch = 'xrdb -load %'
    augroup END "}}}
    augroup FTOptions "{{{
        autocmd!
        autocmd FileType gitcommit
              \ setlocal spell

        autocmd Filetype python
              \ setlocal makeprg=python\ % |
              \ let b:dispatch = 'python %'|
              \ setl efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m |
              \ setl nowrap |
              \ setl foldmethod=indent |
              \ nnoremap <silent> <buffer> <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c> |

        autocmd Filetype markdown
              \ setl conceallevel=2 |
              \ setl spell |
              \ let b:dispatch = "pandoc % --latex-engine=xelatex --highlight-style pygments -o output.pdf" |
              \ syn match comment /^\s*-\s\[x\].*$/

        autocmd Filetype mail
              \ setl tw=76 |
              \ setl spell |
              \ setl fo+=aw

        autocmd FileType help
              \ setl ai fo+=2n | silent! setlocal nospell |
              \ nnoremap <silent><buffer> q :q<CR>

        autocmd FileType netrw
              \ nnoremap <silent><buffer> <Esc> :bprevious<CR>

        autocmd FileType xml
              \ setlocal foldmethod=indent |
              \ setlocal foldlevelstart=999 |
              \ setlocal foldminlines=0 |

    augroup END " }}}
endif
"}}}

" Mappings **************************************************************** {{{

" Leader
let g:mapleader = "\<Space>"
let g:maplocalleader = "\<Space>"

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
nmap gaa ga_

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
map <silent> <Leader>c :cd %:p:h<CR>
map <silent> <Leader>1 z=
map <Leader>i :set list!<CR>
nnoremap <silent> <Leader><Leader> :noh<CR>
nnoremap <silent> <Leader>N :Files ~/Dropbox/Notes<CR>

nnoremap U :UndotreeToggle<CR>

nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

" F Mappings
map <silent> <F2> "<Esc>:silent setlocal spell! spelllang=en<CR>"
map <silent> <F3> "<Esc>:silent setlocal spell! spelllang=fr<CR>"

nnoremap <F5> :w<CR> :Dispatch<CR>
nnoremap <F6> :w<CR> :Make<CR>
nnoremap <F7> :w<CR> :Start<CR>

nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap <F11> :NERDTreeToggle<cr>
nnoremap <F12> :call ToggleHiddenAll()<cr>

" Abbreviations
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q

" Unimpaired
" Quickfix
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" Buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" Files
nnoremap <Leader>; :Files<cr>
nnoremap ; :Buffers<cr>


"Zoom
function! s:zoom()
    if winnr('$') > 1
        tab split
    elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                    \ 'index(v:val, '.bufnr('').') >= 0')) > 1
        tabclose
    endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>
"}}}

" Toggle options ********************************************************** {{{
function! s:map_change_option(...)
  let [key, opt] = a:000[0:1]
  let op = get(a:, 3, 'set '.opt.'!')
  execute printf("nnoremap co%s :%s<bar>set %s?<cr>", key, op, opt)
endfunction

call s:map_change_option('p', 'paste')
call s:map_change_option('n', 'number')
call s:map_change_option('w', 'wrap')
" }}}

" Plugins Settings ******************************************************** {{{
" Dispatch
let g:dispatch_tmux_height=20
let g:dispatch_quickfix_height=20

" Jedi-vim
let g:python_highlight_all = 1
let g:jedi#popup_on_dot = 0
let g:jedi#usages_command = '<leader>u'

" Markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'vim']
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_level = 2
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_conceal = 1

" buftabline
let g:buftabline_show=1

" goyo
let g:goyo_width = "80%"
let g:goyo_height = "90%"

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set showtabline=0
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  set showtabline=1
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"}}}

" Toggle StatusLine ******************************************************* {{{
" function! s:statusline_expr()
"   let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
"   let ro  = "%{&readonly ? '[RO] ' : ''}"
"   let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
"   let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
"   let sep = ' %= '
"   let pos = ' %-12(%l : %c%V%) '
"   let pct = ' %P'
"   return '[%n] %F %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
" endfunction

" let &statusline = s:statusline_expr()

let s:hidden_all=1
function! ToggleHiddenAll()
    if s:hidden_all == 0
        let s:hidden_all = 1
        set laststatus=0
        set noruler
        set noshowcmd
    else
        let s:hidden_all = 0
        set laststatus=2
        set ruler
        set showcmd
    endif
endfunction

"}}}

" Local Vimrc ************************************************************* {{{
if filereadable(glob('~/.local.vimrc'))
  so ~/.local.vimrc
endif
"}}}
