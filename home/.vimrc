if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

silent! call plug#begin()
Plug 'dylanaraps/wal.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-slash'
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-signify'
Plug 'ap/vim-buftabline'
Plug 'lifepillar/vim-mucomplete'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'davidhalter/jedi-vim',    {'for': 'python'}
Plug 'chrisbra/csv.vim',        {'for': 'csv'}
call plug#end()

set nocompatible
set mouse=a
set wildmenu
set wildmode=longest,full:full
set completeopt+=longest,menuone
set completeopt-=preview
set scrolloff=3
set linebreak
set lazyredraw
set splitright
set shortmess=atI
set visualbell
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set noswapfile

silent! colo wal

" FileType                                                                  {{{
let g:tex_flavor='latex' "Recognise Latex files
if has('autocmd')
    augroup Misc
        autocmd!
        autocmd BufReadPost * if getline(1) =~# '^#!' | let b:dispatch = getline(1)[2:-1] . ' %' | let b:start = b:dispatch | endif
    augroup END
    augroup FTOptions
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

        autocmd Filetype markdown
              \ setl conceallevel=2 |
              \ setl spell |
              \ let b:dispatch = "pandoc % --latex-engine=xelatex --highlight-style pygments -o output.pdf" |
              \ syn match comment /^\s*-\s\[x\].*$/ |
              \ syn match comment /^\s*-\sDONE.*$/ |
              \ syn match Todo /\v<(FIXME|TODO)/ |
              \ setl completefunc=emoji#complete

        autocmd FileType help
              \ setl ai fo+=2n | silent! setlocal nospell |
              \ nnoremap <silent><buffer> q :q<CR>

        autocmd FileType netrw
              \ nnoremap <silent><buffer> <Esc> :bprevious<CR>
    augroup END
endif

" Leader
let g:mapleader = "\<Space>"
let g:maplocalleader = "\<Space>"

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
