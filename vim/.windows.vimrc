" Misc *********************************************************************{{{
" set guifont=Consolas_for_Powerline_FixedD:h11
" set printfont=Consolas_for_Powerline_FixedD:h11
" set guifont=Dina:h11
set guifont=Tamsyn8x16
set printfont=Dina:h11

set lines=58 columns=112

cd ~/Documents

colo seoul256

" }}}


" Tex **********************************************************************{{{
" autocmd FileType tex let b:dispatch = 'latex -interaction=nonstopmode %' | setlocal formatoptions+=l

let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

let g:vimtex_latexmk_progname='GVIM'

" }}}

" Python Path **************************************************************{{{
" Using Anaconda Distro for Dispatch
" autocmd FileType python let b:dispatch = '"c:\Anaconda\python.exe" %'
"}}}
