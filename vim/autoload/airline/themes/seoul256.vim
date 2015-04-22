let g:airline#themes#seoul256#palette = {}

function! airline#themes#seoul256#refresh()

    let s:R = [ '#ff2121' , '' , 196 , '' , '' ]           " Red Accent
    let s:N = [ '#DFDEBD' , '#9A7372' , 187 , 95 ]         " Normal
    let s:Nm = [ '#ff2121' , '#9A7372' , 196 , 95 , '' ]   " Normal Modified
    let s:I = ['#DFDEBD' , '#9A7372' , 187 , 95]         " Insert
    let s:Im = ['#ff2121' , '#9A7372' , 196 , 95 ]  " Insert modified
    let s:Ip = ['#DFDEBD' , '#9A7372' , 187 , 95]  " Insert paste
    let s:WI = ['#000000' , '#df5f00' , 232 , 166]          " Warning
    let s:V = ['#DFDEBD' , '#9A7372' , 187 , 95]         " Visual
    let s:Vm = ['#ff2121' , '#9A7372' , 196 , 95]        " Visual
    let s:IA = ['#a1a1a1' , '#dddddd' , 145 , 188]  " Inactive
    let s:IAm = [ '#ff2121' , '#dddddd' , 196 , 188] " Inactive modified

    let g:airline#themes#seoul256#palette.accents = {
        \ 'red': s:R,
        \ }

    let g:airline#themes#seoul256#palette.normal = airline#themes#generate_color_map(s:N, s:N, s:N)

    let g:airline#themes#seoul256#palette.normal_modified = {
        \ 'airline_c': s:Nm ,
        \ }

    let g:airline#themes#seoul256#palette.insert = airline#themes#generate_color_map(s:I, s:I, s:I)
    let g:airline#themes#seoul256#palette.insert_modified = {
        \ 'airline_c':  s:Im,
        \ }
    let g:airline#themes#seoul256#palette.insert_paste = {
        \ 'airline_a': s:Ip,
        \ }

    let g:airline#themes#seoul256#palette.replace = copy(g:airline#themes#seoul256#palette.insert)
    let g:airline#themes#seoul256#palette.replace_modified = g:airline#themes#seoul256#palette.insert_modified

    let g:airline#themes#seoul256#palette.visual = airline#themes#generate_color_map(s:V, s:V, s:V)
    let g:airline#themes#seoul256#palette.visual_modified = {
        \ 'airline_c': s:Vm ,
        \ }

    let g:airline#themes#seoul256#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
    let g:airline#themes#seoul256#palette.inactive_modified = {
        \ 'airline_c': s:IAm ,
        \ }

    let g:airline#themes#seoul256#palette.tabline = {
        \ 'airline_tab':      ['#414141' , '#e1e1e1' , 59  , 188 , '' ],
        \ 'airline_tabsel':   ['#e1e1e1' , '#007599' , 188 , 30  , '' ],
        \ 'airline_tabtype':  ['#414141' , '#e1e1e1' , 59  , 188 , '' ],
        \ 'airline_tabfill':  ['#414141' , '#e1e1e1' , 59  , 188 , '' ],
        \ 'airline_tabmod':   ['#e1e1e1' , '#007599' , 188 , 30  , '' ],
        \ }

    let g:airline#themes#seoul256#palette.normal.airline_warning = [
        \ s:WI[0], s:WI[1], s:WI[2], s:WI[3]
        \ ]

    let g:airline#themes#seoul256#palette.normal_modified.airline_warning =
        \ g:airline#themes#seoul256#palette.normal.airline_warning

    let g:airline#themes#seoul256#palette.insert.airline_warning =
        \ g:airline#themes#seoul256#palette.normal.airline_warning

    let g:airline#themes#seoul256#palette.insert_modified.airline_warning =
        \ g:airline#themes#seoul256#palette.normal.airline_warning

    let g:airline#themes#seoul256#palette.visual.airline_warning =
        \ g:airline#themes#seoul256#palette.normal.airline_warning

    let g:airline#themes#seoul256#palette.visual_modified.airline_warning =
        \ g:airline#themes#seoul256#palette.normal.airline_warning

    let g:airline#themes#seoul256#palette.replace.airline_warning =
        \ g:airline#themes#seoul256#palette.normal.airline_warning

    let g:airline#themes#seoul256#palette.replace_modified.airline_warning =
        \ g:airline#themes#seoul256#palette.normal.airline_warning

    if !get(g:, 'loaded_ctrlp', 0)
    finish
    endif
    let g:airline#themes#seoul256#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
        \ [ '#414141' , '#e1e1e1' , 59  , 188 , ''     ] ,
        \ [ '#414141' , '#e1e1e1' , 59  , 188 , ''     ] ,
        \ [ '#e1e1e1' , '#007599' , 188 , 30  , ''     ] )

endfunction

call airline#themes#seoul256#refresh()

