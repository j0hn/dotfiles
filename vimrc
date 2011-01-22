set nocompatible                 "Use Vim settings rather VI's
set backspace=indent,eol,start   "Allow backspace over everything
set incsearch                    "Incremental search
set smartcase                    "Smartcase for search
set tabstop=4                    "Number of spaces of a <Tab>
set softtabstop=4                "Number of spaces of a <Tab> while editing
set shiftwidth=4                 "Number of spaces on indent
set textwidth=79                 "All files with text width of 79 chars
set expandtab                    "Use apropiate number of spaces when tab
set autoindent                   "Use indent from current line on a new line
set smartindent                  "Use the smart indent
set smarttab                     "Inserts apropiate number of spaces on <Tab>
set number                       "Display line numbers
set cpoptions+=$                 "Show $ char when changing a word
set wildmenu                     "Popup a menu on autocomplete commands
set directory=/tmp               "save .swp files on /tmp directory
"set virtualedit=all              "Posibility to navigate on all the screen
"set mouse=a                      "Use the mouse if you want

set pastetoggle=<F12>

"Tabs mapping keys
nmap Z :tabprevious<cr>
nmap X :tabnext<cr>
nmap T :tabnew<cr>
nmap W :tabclose<cr>

"Select all with Ctrl-A
nmap <C-a> ggVG

"Scroll with Ctrl-J and Ctrl-K
nmap <C-j> <C-E>
nmap <C-k> <C-Y>

"I preffer to use e as b
nmap e b

"Shortcut to comment lines with C style
nmap cc ^i/* <ESC>$a */<ESC>
nmap CC ^<DEL><DEL><DEL>$<DEL><DEL><DEL>

filetype plugin indent on
filetype on
augroup filetypedetect
augroup END

" Color change for menu
highlight Pmenu ctermfg=white ctermbg=NONE guibg=black
highlight PMenuSel ctermfg=black ctermbg=white

" Color columns with more than 80 cols
highlight MaxCols ctermbg=black guibg=black ctermfg=white guifg=white
match MaxCols '\%>80v.*'

" Auto updating vimrc on save
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif
