" -----------------------------------------------------------------------------
" File: vimrc
" Author: JB Kopecky <jb.kopecky@gmail.com>
" Source: https://github.com/jbkopecky/dotfiles
" -----------------------------------------------------------------------------

" Runtime Path                                                              {{{
if has('win32')
    let &runtimepath = substitute(&runtimepath,'\(Documents and Settings\|Users\)[\\/][^\\/,]*[\\/]\zsvimfiles\>','.vim','g')
endif
" }}}

" Plugins !                                                                 {{{

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

let s:darwin = has('mac')

silent! call plug#begin()

Plug 'dylanaraps/wal.vim'
Plug 'junegunn/seoul256.vim'
Plug 'vim-airline/vim-airline'
Plug 'psliwka/vim-smoothie'
Plug 'ryanoasis/vim-devicons'

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
Plug 'junegunn/vim-emoji'

Plug 'mbbill/undotree',      {'on': 'UndotreeToggle'}

Plug 'davidhalter/jedi-vim',    {'for': 'python'}
Plug 'python/black',            {'for': 'python'}
Plug 'chrisbra/colorizer',      {'on': 'ColorHighlight'}
Plug 'chrisbra/csv.vim',        {'for': 'csv'}
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': ['md', 'mkd', 'markdown']}
Plug 'JuliaEditorSupport/julia-vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

if s:darwin
  Plug 'junegunn/vim-xmark'
endif

call plug#end()
"}}}

" Preamble                                                                  {{{
set nocompatible                 " Get rid of Vi compatibility
set noshowmode                   " dont show mode. airline does it
set mouse=a                      " Enable Mouse
set backspace=2                  " Normal backspace
set history=700                  " More cmd line history
set undolevels=700               " More undo
set wildmenu                     " Cmd completion
set wildmode=longest,full:full   " Cmd completion options
set completeopt+=longest,menuone " Start at the head of the popup menulist
set completeopt-=preview
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
set encoding=UTF-8               " Freaking formats
set clipboard+=unnamed
set lazyredraw                   " Speed up things
set splitright                   " More natural split opening
set laststatus=0                 " Always show status bar
set shortmess=atI
set fillchars=
set noruler
set noshowcmd
set visualbell
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

command! Col80  match WarningMsg '\%>80v.\+'
command! Col100 match WarningMsg '\%>100v.\+'

hi! link Folded Ignore
hi! link StatusLine Ignore

"}}}

" FileType                                                                  {{{
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
              \ setl spell |
              \ setl completefunc=emoji#complete

        autocmd Filetype python
              \ setlocal makeprg=python\ % |
              \ let b:dispatch = 'python %'|
              \ setl efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m |
              \ setl nowrap |
              \ setl foldmethod=indent |
              \ syn match WarningMsg /\v#\sBREAKPOINT$/ |
              \ nnoremap <silent> <buffer> <Leader>b Oimport IPython; IPython.embed() # BREAKPOINT<C-c> |

        autocmd Filetype latex
              \ let b:dispatch = "pdflatex %" |

        autocmd Filetype markdown
              \ setl conceallevel=2 |
              \ setl spell |
              \ let b:dispatch = "pandoc % --latex-engine=xelatex --highlight-style pygments -o output.pdf" |
              \ syn match comment /^\s*-\s\[x\].*$/ |
              \ syn match comment /^\s*-\sDONE.*$/ |
              \ syn match Todo /\v<(FIXME|TODO)/ |
              \ setl completefunc=emoji#complete
              " \ syn region yamlFrontmatter start=/\%^---$/ end=/^---$/ keepend |
              " \ hi link yamlFrontmatter Comment

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

" Mappings                                                                  {{{

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

" kj | Escaping!
inoremap kj <Esc>
xnoremap kj <Esc>
cnoremap kj <C-c>

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
nnoremap [l :lprev<cr>zz
nnoremap [e ddkkp
nnoremap ]e ddp

" Surround
nmap ss ysiw
vmap s S

" Buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" Zoom
function! s:zoom()
    if winnr('$') > 1
        tab split
    elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                    \ 'index(v:val, '.bufnr('').') >= 0')) > 1
        tabclose
    endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" Toogle
function! s:map_change_option(...)
  let [key, opt] = a:000[0:1]
  let op = get(a:, 3, 'set '.opt.'!')
  execute printf("nnoremap co%s :%s<bar>set %s?<cr>", key, op, opt)
endfunction

call s:map_change_option('p', 'paste')
call s:map_change_option('n', 'number')
call s:map_change_option('w', 'wrap')

" }}}

" Plugins Settings                                                          {{{
" Airline
let g:airline_theme='wal'

" Dispatch
let g:dispatch_tmux_height=20
let g:dispatch_quickfix_height=20

" Jedi-vim
let g:jedi#force_py_version=3
let g:python_highlight_all = 1
let g:jedi#popup_on_dot = 0
let g:jedi#usages_command = '<leader>u'
let @w = 'o"""Parameters----------Returns-------"""'

" Markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'vim']
let g:markdown_syntax_conceal = 4

" buftabline
let g:buftabline_show = 1

" mucomplete
let g:mucomplete#chains = {
    \ 'default' : ['path', 'omni', 'keyn', 'dict', 'uspl'],
    \ 'python'  : ['omni', 'path', 'keyn', 'ulti'],
    \ 'vim'     : ['path', 'cmd', 'keyn'],
    \ 'markdown': ['path', 'dict', 'user']
    \ }

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

" Todo                                                                      {{{
function! s:todo() abort "{{{
  let entries = []
  for cmd in ['git grep -niI -e TODO -e FIXME 2> /dev/null',
            \ 'grep -rniI -e TODO -e FIXME * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction "}}}

command! Todo call s:todo()

"}}}

set showtabline=2
set laststatus=2

"}}}

" Local Vimrc                                                               {{{
if filereadable(glob('~/.local.vimrc'))
  so ~/.local.vimrc
endif
"}}}
