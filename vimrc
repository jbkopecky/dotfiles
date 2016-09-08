"=============================================================================="
"                                JBK's  VIMRC
"=============================================================================="

" Runtime Path ************************************************************ {{{
if has("win32")
    let &runtimepath = substitute(&runtimepath,'\(Documents and Settings\|Users\)[\\/][^\\/,]*[\\/]\zsvimfiles\>','.vim','g')
endif
" }}}

" Plugins ! *************************************************************** {{{
silent! call plug#begin('~/.vim/plugged')
" -----------------------------------------------------------------------------
Plug 'morhetz/gruvbox'
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
" -----------------------------------------------------------------------------
Plug 'justinmk/vim-gtfo'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ajh17/VimCompletesMe'
Plug 'mbbill/undotree',      {'on': 'UndotreeToggle'}
" -----------------------------------------------------------------------------
Plug 'chrisbra/unicode.vim', {'for': ['journal', 'md', 'tex', 'vimwiki']}
Plug 'chrisbra/colorizer'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'tpope/vim-markdown',   {'for': ['md', 'mkd']}
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
set nocompatible                     " Get rid of Vi compatibility
set laststatus=2                     " Always show status bar
set mouse=a                          " Enable Mouse
set bs=2                             " Normal backspace
set history=700                      " More cmd line history
set undolevels=700                   " More undo
set wildmenu                         " Cmd completion
set wildmode=longest:full,full       " Cmd completion options
set completeopt+=longest,menuone     " Start at the head of the popup menulist
set complete=.,w,b,t,kspell          " Completion scope
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
set tabstop=4                        " Four spaces tabs
set shiftwidth=4                     " Four spaces shifts
set shiftround                       " Round Shifts
set expandtab smarttab               " Smart tabs
set fileformats=unix,dos,mac         " Freaking formats
set encoding=utf-8 nobomb            " Freaking formats
set noshowmode                       " dont show mode. airline does it
set clipboard=unnamed
set lazyredraw                       " Speed up things
set splitright                       " More natural split opening
if exists('+undofile')               " If possible
  set undofile                       " Set Undo file
  set undodir=~/.vim/undo//          " Specify undodir
endif
if exists('+viminfo')
  set viminfo='100,n$HOME/.vim/info/viminfo' "set viminfodir for startify
endif
"}}}

" Colors ****************************************************************** {{{
set t_Co=256
set bg=dark
colo jbco
"}}}

" Invisible Characters **************************************************** {{{
" ․ ‣ · ∘ ∙ • ⁕ ↓ → ∆ ∇〈〉《》
set listchars=tab:‣\ ,trail:∙,eol:¬,precedes:«,extends:»
let &showbreak = '→ '
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

" StatusLine  ************************************************************* {{{
function! StatusLineHi() "{{{
    " hi clear StatusLine
    " hi clear StatusLineNC
    " hi! def link StatusLine NonText
    " hi! def link StatusLineNC SpecialKey
    hi def link User1 Identifier
    hi def link User2 Statement
    hi def link User3 Error
    hi def link User4 Special
    hi def link User5 Comment
    hi def link User6 WarningMsg
endfunction "}}}
function! TrailingSpaceWarning() "{{{
  if !exists("b:statline_trailing_space_warning")
    let lineno = search('\s$', 'nw')
    if lineno != 0
      let b:statline_trailing_space_warning = '∙ '.lineno.' '
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
    let head = fugitive#head()
    return head
endfunction "}}}
function! Signify() "{{{
    let symbols = ['+', '-', '~']
    let [added, modified, removed] = sy#repo#get_stats()
    let stats = [added, removed, modified]  " reorder
    let hunkline = ''

    for i in range(3)
    if stats[i] > 0
        let hunkline .= printf('%s%s ', symbols[i], stats[i])
    endif
    endfor

    if !empty(hunkline)
    let hunkline = printf('[%s]', hunkline[:-2])
    endif

    return hunkline
endfunction "}}}
augroup statline_trail "{{{
  " recalculate when idle, and after saving
  autocmd!
  autocmd cursorhold,bufwritepost * unlet! b:statline_trailing_space_warning
augroup END "}}}

call StatusLineHi()

set statusline=
set statusline+=%6*%m%r%*                        " modified, readonly
set statusline+=\ %5*%{expand('%:h')}/           " relative path to file's directory
set statusline+=%1*%t%*                          " file name
set statusline+=\ %2*%{Fugitive()}               " fugitive
set statusline+=\ %4*%{Signify()}                " fugitive
set statusline+=%=                               " switch to RHS
set statusline+=\ %3*%{TrailingSpaceWarning()}%* " trailing whitespace
set statusline+=\ %2*%y%*
set statusline+=\ %5*%L\ %*                      " number of lines

"}}}

" File Type *************************************************************** {{{
let g:tex_flavor="latex" "Recognise Latex files
if has("autocmd")
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
              \ setl efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m |
              \ setl nowrap |
              \ setl foldmethod=indent |
              \ nnoremap <silent> <buffer> <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c> |

        autocmd Filetype mail
              \ setl tw=76 |
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
        autocmd Bufread,BufNewFile *.wiki set ft=vimwiki
    augroup END "}}}
endif
"}}}

" Mappings **************************************************************** {{{

" Leader
let g:mapleader = "\<Space>"
let g:maplocalleader = "\<Space>"

" Escape shorcut
inoremap kj <Esc>

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
autocmd FileType python let b:dispatch = 'python %'
"}}}
" VimCompletesMe ********************************************************** {{{
set dictionary=/usr/share/dict/words

autocmd FileType journal         let b:vcm_tab_complete = 'dict'

autocmd FileType vim             let b:vcm_tab_complete = 'tags'

autocmd FileType md,markdown     let b:vcm_tab_complete = 'omni'
autocmd FileType vimwiki,*.wiki  let b:vcm_tab_complete = 'omni'
autocmd FileType python          let b:vcm_tab_complete = 'omni'
autocmd FileType tex             let b:vcm_tab_complete = 'omni'
" }}}
" Jedi-vim **************************************************************** {{{
let g:python_highlight_all = 1
let g:jedi#popup_on_dot = 0
let g:jedi#usages_command = "<leader>u"
"}}}
" Startify **************************************************************** {{{
let g:startify_files_number = 5

" Titles {{{
let g:startify_list_order = [
    \ ['   ---'],
    \ 'files',
    \ ['   ---'],
    \ 'dir',
    \ ['   ---'],
    \ 'sessions',
    \ ['   ---'],
    \ ] "}}}

" Header {{{
let g:startify_custom_header = [
\ '',
\ '                               ~ 吃得苦中苦,方为人上人 ~ ',
\ '',
\ '',
\ ] "}}}

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
"}}}

" Todo ******************************************************************** {{{
function! s:todo() abort "{{{
  let cmds =  [
             \ 'git grep -n -e TODO -e FIXME -e XXX 2> /dev/null',
             \ 'grep -rn -e TODO -e FIXME -e XXX * 2> /dev/null',
             \ ]
  let entries = []
  for cmd in cmds
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let entry = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')
      if len(entry)>3
        let [fname, lno, text]=entry[1:3]
        call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
      endif
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
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
  call StatusLineHi()
  redraw
  echo name
endfunction "}}}
"}}}

" Local Vimrc ************************************************************* {{{
if filereadable(glob("~/.local.vimrc")) "{{{
  so ~/.local.vimrc
endif "}}}
"}}}
