set nocompatible
set smartcase
set incsearch
set bs=indent,eol,start
set ts=4
set sts=4
set sw=4
set et
set ai
set smartindent
set smarttab
set number

set pastetoggle=<F12>

nmap Z :tabprevious<cr>
nmap X :tabnext<cr>
nmap T :tabnew<cr>
nmap W :tabclose<cr>

nmap cc ^i/* <ESC>$a */<ESC>
nmap CC ^<DEL><DEL><DEL>$<DEL><DEL><DEL>
nmap <A-Up> <C-Y>
nmap <A-Down> <C-E>
nmap <C-a> <ESC>gg<S-V>G

filetype plugin indent on
filetype on

highlight Pmenu ctermfg=white ctermbg=none guibg=black
highlight PMenuSel ctermfg=black ctermbg=white

highlight MaxCols ctermbg=black guibg=black ctermfg=white guifg=white
match MaxCols '\%>80v.*'

augroup filetypedetect
au BufNewFile,BufRead *.cfdg setf cfdg
augroup END
