set guioptions-=m "No Menu
set guioptions-=T "No toolbar
set guioptions-=r "No scrollbar
set guioptions-=b "No scrollbar
set guioptions-=L "No scrollbar

command! -bar -nargs=0 Bigger  :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)+1','')
command! -bar -nargs=0 Smaller :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)-1','')
noremap <M-,>        :Smaller<CR>
noremap <M-.>        :Bigger<CR>
