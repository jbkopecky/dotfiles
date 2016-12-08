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
silent! call plug#begin('~/.vim/plugged')
" -----------------------------------------------------------------------------
Plug 'chriskempson/base16-vim'
Plug 'junegunn/seoul256.vim'
" -----------------------------------------------------------------------------
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'
" -----------------------------------------------------------------------------
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
" -----------------------------------------------------------------------------
Plug 'junegunn/vim-easy-align', {'on': ['<Plug>(EasyAlign)','EasyAlign']}
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
" -----------------------------------------------------------------------------
Plug 'justinmk/vim-gtfo'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'lifepillar/vim-mucomplete'
Plug 'ap/vim-buftabline'
Plug 'mbbill/undotree',      {'on': 'UndotreeToggle'}
" -----------------------------------------------------------------------------
Plug 'godlygeek/tabular', {'for': ['md', 'mkd', 'markdown']}
Plug 'plasticboy/vim-markdown', {'for': ['md', 'mkd', 'markdown']}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'chrisbra/colorizer', {'on': 'ColorHighlight'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'chrisbra/csv.vim', {'for': 'csv'}
Plug 'freitass/todo.txt-vim', {'for': 'todo'}
Plug 'junegunn/vim-journal', {'for': 'journal'}
Plug 'Pseewald/vim-anyfold'
" -----------------------------------------------------------------------------
if has('unix')
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
call plug#end()
"}}}
" Preamble **************************************************************** {{{
set nocompatible                 " Get rid of Vi compatibility
set laststatus=2                 " Always show status bar
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
set backupdir=~/.vim/backups//   " Specify backup dir
set directory=~/.vim/swaps//     " Specify swap dir
set number                       " Show line number
set textwidth=79                 " No more than 80 col
set colorcolumn=80               " Color 80 col
set formatoptions-=t             " no automatic wrap text when typing
set linebreak                    " Breaks fold at end of word
set cursorline                   " Show cursor line
set tabstop=4                    " Four spaces tabs
set shiftwidth=4                 " Four spaces shifts
set shiftround                   " Round Shifts
set expandtab smarttab           " Smart tabs
set fileformats=unix,dos,mac     " Freaking formats
set encoding=utf-8 nobomb        " Freaking formats
set noshowmode                   " dont show mode. airline does it
set clipboard=unnamed
set lazyredraw                   " Speed up things
set splitright                   " More natural split opening
if exists('+undofile')           " If possible
  set undofile                   " Set Undo file
  set undodir=~/.vim/undo//      " Specify undodir
endif
if exists('+viminfo')
  set viminfo='100,n$HOME/.vim/info/viminfo' "set viminfodir for startify
endif
"}}}
" Colors ****************************************************************** {{{
colo base16-default-light
" colo seoul256
"}}}
" Invisible Characters **************************************************** {{{
set listchars=tab:►\ ,trail:●,extends:»,precedes:«,eol:¬
let &showbreak = '→ '
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
    let foldLevelStr = repeat("+  ", v:foldlevel)
    let lineCount = line("$")
    " let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    " let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    " return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
    let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
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
        " autocmd FocusGained * call StatusLineHi()
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

        autocmd FileType *
              \ if exists("+omnifunc") && &omnifunc == "" |
              \ setlocal omnifunc=syntaxcomplete#Complete |
              \ endif

        autocmd FileType *
              \ if exists("+completefunc") && &completefunc == "" |
              \ setlocal completefunc=syntaxcomplete#Complete |
              \ endif

    augroup END " }}}
    augroup FTCheck "{{{
        autocmd!
        autocmd Bufread,BufNewFile *.journal set ft=journal
    augroup END "}}}
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
map <silent> <Leader>- <Plug>VinegarUp
map <silent> <Leader>q :ccl<CR>
map <silent> <Leader>c :cd %:p:h<CR>
map <Leader>i :set list!<CR>
nnoremap <silent> <Leader><Leader> :noh<CR>
nnoremap <silent> <Leader>N :CtrlP ~/Dropbox/Notes<CR>
nnoremap <silent> <Leader>T :tabe ~/Dropbox/todo/todo.txt<CR>

nnoremap U :UndotreeToggle<CR>

nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
nnoremap <Leader>sv :source $MYVIMRC<cr>

" F Mappings
nnoremap <F2> :if &previewwindow<Bar>pclose<Bar>elseif exists(':Gstatus')<Bar>exe 'Gstatus'<Bar>else<Bar>ls<Bar>endif<CR>

nnoremap <F5> :w<CR> :Dispatch<CR>
nnoremap <F6> :w<CR> :Make<CR>
nnoremap <F7> :w<CR> :Start<CR>

nnoremap <F8> :call <SID>rotate_colors()<cr>

nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"}}}
" Abbreviations *********************************************************** {{{
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q
" }}}
" Plugins Settings ******************************************************** {{{
" Dispatch **************************************************************** {{{

"}}}
" Anyfold ***************************************************************** {{{
autocmd Filetype python     let b:anyfold_activate=1
autocmd Filetype conf       let b:anyfold_activate=1
autocmd Filetype javascript let b:anyfold_activate=1
"}}}
" Jedi-vim **************************************************************** {{{
let g:python_highlight_all = 1
let g:jedi#popup_on_dot = 0
let g:jedi#usages_command = '<leader>u'
"}}}
" Startify **************************************************************** {{{
let g:startify_files_number = 5
"}}}
" CtrlP ******************************************************************* {{{
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['buffertag', 'line', 'mru', 'dir']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \}
"}}}
" Markdown **************************************************************** {{{
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'vim']
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_level = 2
let g:vim_markdown_toc_autofit = 1
"}}}
" journal ***************************************************************** {{{
let g:journal#dirs = ['Notes']
"}}}
" buftabline ************************************************************** {{{
let g:buftabline_show=1
"}}}
" goyo ******************************************************************** {{{
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
  call StatusLineHi()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"}}}
"}}}
" Todo ******************************************************************** {{{
function! s:todo() abort "{{{
  let l:cmds =  [
             \ 'git grep -n -e TODO -e FIXME -e XXX 2> /dev/null',
             \ 'grep -rn -e TODO -e FIXME -e XXX * 2> /dev/null',
             \ ]
  let l:entries = []
  for l:cmd in l:cmds
    let l:lines = split(system(l:cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for l:line in l:lines
      let l:entry = matchlist(l:line, '^\([^:]*\):\([^:]*\):\(.*\)')
      if len(l:entry)>3
        let [l:fname, l:lno, l:text]=l:entry[1:3]
        call add(l:entries, { 'filename': l:fname, 'lnum': l:lno, 'text': l:text })
      endif
    endfor
    break
  endfor

  if !empty(l:entries)
    call setqflist(l:entries)
    copen
  endif
endfunction "}}}
command! Todo call s:todo()
" }}}
" Color Toggle ************************************************************ {{{
function! s:rotate_colors() "{{{
  if !exists('s:colors_list')
    let s:colors_list =
    \ sort(map(
    \   filter(split(globpath(&runtimepath, 'colors/*.vim'), '\n'), 'v:val !~ "^/usr/"'),
    \   "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"))
  endif
  if !exists('s:colors_index')
    let s:colors_index = index(s:colors_list, g:colors_name)
  endif
  let s:colors_index = (s:colors_index + 1) % len(s:colors_list)
  let l:name = s:colors_list[s:colors_index]
  set background=dark
  execute 'colorscheme' l:name
  call StatusLineHi()
  redraw
  echo l:name
endfunction "}}}
"}}}
" Local Vimrc ************************************************************* {{{
if filereadable(glob('~/.local.vimrc')) "{{{
  so ~/.local.vimrc
endif "}}}
"}}}
