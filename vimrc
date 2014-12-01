"Pathogen
call pathogen#infect()

" Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1

" Font Settings (For Powerline Patches)
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Anonymous\ Pro\ for\ Powerline:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

"Nerdtree remap to ctrl + n
map <C-n> :NERDTreeToggle<CR>

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again


" Rebind <Leader> key
let mapleader = "\<Space>"


" Color scheme
syntax enable
set background=dark
colorscheme solarized

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype on
filetype plugin indent on
syntax on


" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233



" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


" Settings for ctrlp
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*


"Install Promptpline
    "UnComment following settings:

    "let g:promptline_preset = {
    "        \'a' : [ promptline#slices#user() ],
    "        \'b' : [ promptline#slices#cwd() ],
    "        \'c' : [ promptline#slices#vcs_branch(), promptline#slices#git_status(),],
    "        \'warn' : [ promptline#slices#last_exit_code()]}

    "Run following command
    ":PromptlineSnapshot ~/.shell_prompt.sh airline
