" Misc *********************************************************************{{{
cd ~/Documents
let &showbreak = '»'
set lines=43 columns=190
" }}}

" Startify bookmarks *******************************************************{{{
let g:startify_bookmarks = [  {'g':'~\\Documents\\Github\\dotfiles\\gvimrc'}, {'vv':'~\\Documents\\Github\\dotfiles\\vimrc'}, {'l':'~\\Documents\\GitHub\\dotfiles\\windows.vimrc'} ]
" }}}

" Gutentags ****************************************************************{{{
let g:gutentags_ctags_executable="C:\\Program\ files\\ctags58\ctags.exe"
" }}}

" Tex **********************************************************************{{{
" autocmd FileType tex let b:dispatch = 'latex -interaction=nonstopmode %' | setlocal formatoptions+=l

let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options = '-forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

let g:vimtex_latexmk_progname='gvim'

" }}}

" Airline ******************************************************************{{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" old vim-powerline symbols
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

"}}}

" Python Path **************************************************************{{{
" Using Anaconda Distro for Dispatch
" autocmd FileType python let b:dispatch = '"c:\Anaconda\python.exe" %'
"}}}
