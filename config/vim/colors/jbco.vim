"
" Terminal setup.
"
set background=dark
if version > 580
    highlight clear
    if exists("g:syntax_on")
        syntax reset
    endif
endif
let g:colors_name="jbco"

"
" Highlighting definitions.
"

"
" Actual colours and styles.
"
highlight Comment      term=NONE cterm=NONE ctermfg=3    ctermbg=NONE
highlight Constant     term=NONE cterm=bold ctermfg=7    ctermbg=NONE
highlight Cursor       term=NONE cterm=NONE ctermfg=1    ctermbg=NONE
highlight CursorLine   term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE
highlight DiffAdd      term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE
highlight DiffChange   term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE
highlight DiffDelete   term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE
highlight Folded       term=NONE cterm=NONE ctermfg=3    ctermbg=1
highlight Function     term=NONE cterm=bold ctermfg=7    ctermbg=NONE
highlight Identifier   term=NONE cterm=bold ctermfg=1    ctermbg=NONE
highlight IncSearch    term=NONE cterm=NONE ctermfg=0    ctermbg=NONE
highlight NonText      term=NONE cterm=NONE ctermfg=2    ctermbg=NONE
highlight Normal       term=NONE cterm=NONE ctermfg=7    ctermbg=NONE
highlight PreProc      term=NONE cterm=bold ctermfg=3    ctermbg=NONE
highlight Search       term=NONE cterm=bold ctermfg=7    ctermbg=1
highlight Special      term=NONE cterm=bold ctermfg=8    ctermbg=NONE
highlight SpecialKey   term=NONE cterm=NONE ctermfg=2    ctermbg=NONE
highlight Statement    term=NONE cterm=bold ctermfg=2    ctermbg=NONE
highlight StatusLine   term=NONE cterm=NONE ctermfg=7    ctermbg=NONE
highlight StatusLine   term=NONE cterm=NONE ctermfg=7    ctermbg=NONE
highlight TabLineSel   term=NONE cterm=bold ctermfg=7    ctermbg=2
highlight TabLine      term=NONE cterm=NONE ctermfg=4    ctermbg=1
highlight TabLineFill  term=NONE cterm=NONE ctermfg=7    ctermbg=1
highlight String       term=NONE cterm=bold ctermfg=5    ctermbg=NONE
highlight StatusLineNC term=NONE cterm=NONE ctermfg=2    ctermbg=NONE
highlight Todo         term=NONE cterm=underline,bold ctermfg=7 ctermbg=NONE
highlight Type         term=NONE cterm=NONE ctermfg=3    ctermbg=NONE
highlight VertSplit    term=NONE cterm=bold ctermfg=4    ctermbg=NONE
highlight Visual       term=NONE cterm=bold ctermfg=NONE ctermbg=4
highlight WarningMsg   term=NONE cterm=bold ctermfg=7    ctermbg=NONE
highlight ErrorMsg     term=NONE cterm=bold ctermfg=7    ctermbg=NONE
highlight Error        term=NONE cterm=bold ctermfg=7    ctermbg=NONE
highlight DiffChange   term=NONE cterm=bold ctermfg=3    ctermbg=NONE
highlight DiffAdd      term=NONE cterm=bold ctermfg=5    ctermbg=NONE
highlight DiffDelete   term=NONE cterm=bold ctermfg=7    ctermbg=NONE
highlight SignColumn   term=NONE cterm=NONE ctermfg=1    ctermbg=NONE
highlight ColorColumn  term=NONE cterm=NONE ctermfg=NONE ctermbg=1
highlight Pmenu        term=NONE cterm=NONE ctermfg=5    ctermbg=1
highlight PmenuSel     term=NONE cterm=NONE ctermfg=6    ctermbg=2
highlight SpellBad     term=NONE cterm=underline,bold ctermfg=7 ctermbg=NONE
highlight MatchParen   term=NONE cterm=NONE ctermfg=NONE ctermbg=2

"
" General highlighting group links.
"
highlight! link Title           Normal
highlight! link LineNr          NonText
highlight! link VimHiGroup      VimGroup
highlight! link CSVDelimiter    Comment
highlight! link Conceal         Comment
highlight! link StartifyBracket Comment
highlight! link StartifyFooter  Comment
highlight! link StartifyHeader  Comment
highlight! link StartifyPath    Comment
highlight! link StartifySection Preproc
highlight! link StartifySlash   Statement

