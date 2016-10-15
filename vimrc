"=============================================================================="
"                                JBK's  VIMRC
"=============================================================================="

" Runtime Path ************************************************************ {{{
if has('win32')
    let &runtimepath = substitute(&runtimepath,'\(Documents and Settings\|Users\)[\\/][^\\/,]*[\\/]\zsvimfiles\>','.vim','g')
endif
" }}}
" Plugins ! *************************************************************** {{{
silent! call plug#begin('~/.vim/plugged')
" -----------------------------------------------------------------------------
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'cocopon/iceberg.vim'
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
" -----------------------------------------------------------------------------
Plug 'justinmk/vim-gtfo'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ajh17/VimCompletesMe'
Plug 'mbbill/undotree',      {'on': 'UndotreeToggle'}
Plug 'ap/vim-buftabline'
Plug 'w0rp/Ale', {'for': ['python', 'vim', 'bash', 'html', 'json']}
" -----------------------------------------------------------------------------
Plug 'reedes/vim-wordy', {'for': ['journal', 'md', 'tex', 'txt', 'yml']}
Plug 'tpope/vim-markdown',   {'for': ['md', 'mkd', 'markdown']}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'chrisbra/colorizer'
Plug 'lervag/vimtex'
Plug 'chrisbra/csv.vim'
Plug 'junegunn/vim-journal'
" -----------------------------------------------------------------------------
if has('unix')
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
call plug#end()
"}}}
" Preamble **************************************************************** {{{
" set nocompatible                     " Get rid of Vi compatibility
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
set t_Co=256
set background=dark
colo jbco
"}}}
" Invisible Characters **************************************************** {{{
set listchars=tab:★\ ,trail:●,extends:»,precedes:«,eol:¬
let &showbreak = '→ '
"}}}
" Folding ***************************************************************** {{{
function! MyFoldText() " {{{
    let l:line = getline(v:foldstart)

    let l:nucolwidth = &foldcolumn + &number * &numberwidth
    let l:windowwidth = winwidth(0) - l:nucolwidth - 5
    let l:foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let l:onetab = strpart('          ', 0, &tabstop)
    let l:line = substitute(l:line, '\t', l:onetab, 'g')

    let l:line = strpart(l:line, 0, l:windowwidth - 2 -len(l:foldedlinecount))
    let l:fillcharcount = l:windowwidth - len(l:line) - len(l:foldedlinecount)
    return l:line . ' ' . repeat('-',l:fillcharcount) . ' ' . l:foldedlinecount . ' ' . '  '
endfunction " }}}
set foldtext=MyFoldText()
"}}}
" StatusLine  ************************************************************* {{{
function! g:StatusLineHi() "{{{
    hi clear StatusLine
    hi clear StatusLineNC
    hi! def link StatusLine NonText
    hi! def link StatusLineNC Comment
    hi def link User1 Identifier
    hi def link User2 Statement
    hi def link User3 Error
    hi def link User4 Special
    hi def link User5 Comment
    hi def link User6 WarningMsg
endfunction "}}}
function! TrailingSpaceWarning() "{{{
  if !exists('b:statline_trailing_space_warning')
    let l:lineno = search('\s$', 'nw')
    if l:lineno != 0
      let b:statline_trailing_space_warning = '∙ '.l:lineno.' '
    else
      let b:statline_trailing_space_warning = ''
    endif
  endif
  return b:statline_trailing_space_warning
endfunction "}}}
function! Fugitive() "{{{
    if !exists('g:loaded_fugitive')
        return ''
    endif
    let l:head = fugitive#head()
    return l:head
endfunction "}}}
function! Signify() "{{{
    if !get(g:, 'loaded_signify', 0)
        return ''
    else
        let l:symbols = ['+', '-', '~']
        let [l:added, l:modified, l:removed] = sy#repo#get_stats()
        let l:stats = [l:added, l:removed, l:modified]  " reorder
        let l:hunkline = ''

        for i in range(3)
        if stats[i] > 0
            let hunkline .= printf('%s%s ', l:symbols[i], l:stats[i])
        endif
        endfor

        if !empty(l:hunkline)
        let l:hunkline = printf('[%s]', l:hunkline[:-2])
        endif

        return l:hunkline
    endif
endfunction "}}}
function! Ale() "{{{
    if !get(g:, 'loaded_ale', 0)
        return ''
    else
        return ALEGetStatusLine()
    endif
endfunction "}}}
augroup statline_trail "{{{
  " recalculate when idle, and after saving
  autocmd!
  autocmd cursorhold,bufwritepost * unlet! b:statline_trailing_space_warning
augroup END "}}}
let g:filetype_overrides = ['gundo', 'startify', 'vim-plug']

call g:StatusLineHi()

set statusline=
if (index(g:filetype_overrides, &filetype) <= 0)
    set statusline+=%6*%m%r%*                        " modified, readonly
    set statusline+=\ %5*%{expand('%:h')}/           " relative path to file's directory
    set statusline+=%1*%t%*                          " file name
    set statusline+=\ %2*%{Fugitive()}               " fugitive
    set statusline+=\ %5*%{Signify()}                " fugitive
    set statusline+=%=                               " switch to RHS
    set statusline+=\ %3*%{Ale()}%*                  " Linting
    set statusline+=\ %3*%{TrailingSpaceWarning()}%* " trailing whitespace
    set statusline+=\ %2*%y%*
    set statusline+=\ %5*%L\ %*                      " number of lines
else
    set statusline+=%=
endif

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

        autocmd FileType text
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
" VimCompletesMe ********************************************************** {{{
set dictionary=/usr/share/dict/words
augroup VimCompletesMe
    autocmd FileType journal         let b:vcm_tab_complete = 'dict'
    autocmd FileType vim             let b:vcm_tab_complete = 'tags'
    autocmd FileType md,markdown     let b:vcm_tab_complete = 'omni'
    autocmd FileType vimwiki,*.wiki  let b:vcm_tab_complete = 'omni'
    autocmd FileType python          let b:vcm_tab_complete = 'omni'
    autocmd FileType tex             let b:vcm_tab_complete = 'omni'
augroup END
" }}}
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
"}}}
" journal ***************************************************************** {{{
let g:journal#dirs = ['Notes']
"}}}
" buftabline ************************************************************** {{{
let g:buftabline_show = 1
"}}}
" Ale ********************************************************************* {{{
let g:ale_sign_column_always = 1
" ✿
let g:ale_statusline_format = ['★ %d', '☆ %d', '✔']
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
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
