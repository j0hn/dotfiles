set nocompatible                 "Use Vim settings rather VI's
set backspace=indent,eol,start   "Allow backspace over everything
set incsearch                    "Incremental search
set ignorecase                   "Along with smartcase makes a cool search
set smartcase                    "Smartcase for search
set tabstop=4                    "Number of spaces of a <Tab>
set softtabstop=4                "Number of spaces of a <Tab> while editing
set shiftwidth=4                 "Number of spaces on indent
"set textwidth=79                 "All files with text width of 79 chars
set expandtab                    "Use apropiate number of spaces when tab
set autoindent                   "Use indent from current line on a new line
set smartindent                  "Use the smart indent
set smarttab                     "Inserts apropiate number of spaces on <Tab>
set number                       "Display line numbers
set cpoptions+=$                 "Show $ char when changing a word
"set wildmenu                     "Popup a menu on autocomplete commands
set wildignore=*.o,*.pyc,*~      "Ignoring unnecessary files
set directory=/tmp               "save .swp files on /tmp directory
set linebreak                    "Wrap long lines at words
"set showmatch                    "Highlight matching brace
"set showbreak=...                "Show ... when the line breaks
"set virtualedit=all              "Posibility to navigate on all the screen
"set mouse=a                      "Use the mouse if you want

set pastetoggle=<F12>

let mapleader=','

"Shortcut to open files in the same
"that the current one
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

nmap j gj
nmap k gk

"Tabs mapping keys
nmap Z :tabprevious<cr>
nmap X :tabnext<cr>
nmap T :tabnew<cr>
nmap W :tabclose<cr>

"Select all with Ctrl-A
"nmap <C-a> ggVG

"Auto indent all file
nmap <C-i> mlgg=G'l

"More easily move between windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

"I preffer to use e as b
nmap e b

"Shortcut to comment lines with C style
nmap cc ^i/* <ESC>$a */<ESC>
nmap CC ^<DEL><DEL><DEL>$<DEL><DEL><DEL>

filetype plugin indent on
filetype on
syntax on
augroup filetypedetect
augroup END

"Color change for menu
highlight Pmenu ctermfg=white ctermbg=NONE guibg=black
highlight PMenuSel ctermfg=black ctermbg=white

"Color columns with more than 80 cols
highlight MaxCols ctermbg=black guibg=black ctermfg=white guifg=white
match MaxCols '\%>80v.*'

"Showing tabs with ▸
set list
set listchars=tab:▸\ 
"Black color for tab keys
hi SpecialKey ctermfg=0

if has("autocmd")
    "Auto updating vimrc on save
    autocmd bufwritepost *.vimrc source $MYVIMRC
    "Strip white spaces at end of the line
    autocmd! BufWritePre *.py,*.js,*.c,*.h :call <SID>StripTrailingWhitespaces()
    "Don't undent python comments
    autocmd! BufEnter *.py setl nosmartindent
endif

function! <SID>StripTrailingWhitespaces()
    "Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    "Do the business:
    %s/\s\+$//e
    "Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

"pylint, pychecker and pep8 integrated
function! <SID>PythonGrep(tool)
  set lazyredraw
  " Close any existing cwindows.
  cclose
  let l:grepformat_save = &grepformat
  let l:grepprogram_save = &grepprg
  set grepformat&vim
  set grepformat&vim
  let &grepformat = '%f:%l:%m'
  if a:tool == "pylint"
    let &grepprg = 'pylint --output-format=parseable --reports=n --include-ids=y'
  elseif a:tool == "pychecker"
    let &grepprg = 'pychecker --quiet -q'
  elseif a:tool == "pep8"
    let &grepprg = 'pep8 -r'
  else
    echohl WarningMsg
    echo "PythonGrep Error: Unknown Tool"
    echohl none
  endif
  if &readonly == 0 | update | endif
  silent! grep! %
  let &grepformat = l:grepformat_save
  let &grepprg = l:grepprogram_save
  let l:mod_total = 0
  let l:win_count = 1
  " Determine correct window height
  windo let l:win_count = l:win_count + 1
  if l:win_count <= 2 | let l:win_count = 4 | endif
  windo let l:mod_total = l:mod_total + winheight(0)/l:win_count |
        \ execute 'resize +'.l:mod_total
  " Open cwindow
  execute 'belowright copen '.l:mod_total
  nnoremap <buffer> <silent> c :cclose<CR>
  set nolazyredraw
  redraw!
endfunction

autocmd FileType python map <F3> :call <SID>PythonGrep('pep8')<CR>
autocmd FileType python map <F4> :call <SID>PythonGrep('pylint')<CR>
