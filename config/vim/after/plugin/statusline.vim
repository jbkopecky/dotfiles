let s:save_cpo = &cpo
set cpo&vim

function! s:gui_mode() "{{{
  return ((has('nvim') && exists('$NVIM_TUI_ENABLE_TRUE_COLOR') && !exists("+termguicolors"))
        \ || has('gui_running') || (has("termtruecolor") && &guicolors == 1) || (has("termguicolors") && &termguicolors == 1)) ?
        \ 'gui' : 'cterm'
endfunction "}}}

function! s:get_syn(group, what) "{{{
  let g:gui_mode = s:gui_mode()
  let color = synIDattr(synIDtrans(hlID(a:group)), a:what, g:gui_mode)
  if empty(color) || color == -1
    let color = synIDattr(synIDtrans(hlID('Normal')), a:what, g:gui_mode)
  endif
  if empty(color) || color == -1
    let color = 'NONE'
  endif
  return color
endfunction "}}}

function! s:get_array(fg, bg, opts) "{{{
  return g:gui_mode ==# 'gui'
        \ ? [ a:fg, a:bg, '', '', join(a:opts, ',') ]
        \ : [ '', '', a:fg, a:bg, join(a:opts, ',') ]
endfunction "}}}

function! GetHighlight(fg, bg, ...) "{{{
  let fg = s:get_syn(a:fg[0], a:fg[1])
  let bg = s:get_syn(a:bg[0], a:bg[1])
  return s:get_array(fg, bg, a:000)
endfunction "}}}

function! StatHighlight(group, colors) "{{{
  let colors=a:colors
  if len(colors) == 4
    call add(colors, '')
  endif
  let cmd = printf('hi %s %s %s %s %s %s %s %s',
      \ a:group, s:Get(colors, 0, 'guifg=', ''), s:Get(colors, 1, 'guibg=', ''),
      \ s:Get(colors, 2, 'ctermfg=', ''), s:Get(colors, 3, 'ctermbg=', ''),
      \ s:Get(colors, 4, 'gui=', ''), s:Get(colors, 4, 'cterm=', ''),
      \ s:Get(colors, 4, 'term=', ''))
  exe cmd
endfunction "}}}

function! s:Get(dict, key, prefix, default) "{{{
  if get(a:dict, a:key, a:default) isnot# a:default
    return a:prefix. get(a:dict, a:key)
  else
    return ''
  endif
endfunction "}}}

function! StatusLineHi() "{{{

    let s:base0 = 'Normal'
    let s:base1 = 'LineNr'

    let s:notext = 'Ignore' 

    let s:FG = [s:notext, 'fg']
    let s:BG0 = [s:base0, 'bg']
    let s:BG1 = [s:base1, 'bg']

    let s:N0 = GetHighlight(s:FG, s:BG0)
    let s:N1 = GetHighlight(s:FG, s:BG1)

    let s:U1 = GetHighlight(['Identifier', 'fg'], s:BG1)
    let s:U2 = GetHighlight(['String',     'fg'], s:BG1)
    let s:U3 = GetHighlight(['Statement',  'fg'], s:BG1)
    let s:U4 = GetHighlight(['Special',    'fg'], s:BG1)
    let s:U5 = GetHighlight(['Comment',    'fg'], s:BG1)
    let s:U6 = GetHighlight(['Warning',    'fg'], s:BG1)
    
    hi! clear StatusLine
    hi! clear StatusLineNC

    call StatHighlight('StatusLine', s:N1) 
    call StatHighlight('StatusLineNC', s:N0)

    call StatHighlight('User1', s:U1)
    call StatHighlight('User2', s:U2)
    call StatHighlight('User3', s:U3)
    call StatHighlight('User4', s:U4)
    call StatHighlight('User5', s:U5)
    call StatHighlight('User6', s:U6)
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

augroup statline_trail "{{{
  " recalculate when idle, and after saving
  autocmd!
  autocmd cursorhold,bufwritepost * unlet! b:statline_trailing_space_warning
augroup END "}}}

set statusline=
set statusline+=%6*%m%r%*                        " modified, readonly
set statusline+=\ %5*%{expand('%:h')}/%*         " relative path to file's directory
set statusline+=%1*%t%*                          " file name
set statusline+=\ %2*%{Fugitive()}%*             " fugitive
set statusline+=\ %5*%{Signify()}%*              " fugitive
set statusline+=%=                               " switch to RHS
set statusline+=\ %3*%{TrailingSpaceWarning()}%* " trailing whitespace
set statusline+=\ %2*%y%*
set statusline+=\ %5*%L\ %*                      " number of lines

call StatusLineHi() 

command! STH call StatusLineHi()

let &cpo = s:save_cpo
