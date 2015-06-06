" i don't need vi :)
set nocompatible

" syntac highlight and auto identation
syntax on
filetype plugin indent on
set autoindent

" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" ensure the correct linewrap
set lbr
set wrap
set nolist

set ruler " show current position in file
set scrolloff=5 " show lines above and below cursor (when possible)
set noshowmode " hide mode
set backspace=indent,eol,start " allow backspacing over everything
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow O inserts
set hidden " allow auto-hiding of edited buffers
set history=8192 " more history
set nojoinspaces " suppress inserting two spaces between sentences
set lazyredraw   " make vim faster(?)
set ttyfast
set showmatch " show matching braces when text indicator is over them

" search related things
set incsearch " incremental search (as string is being typed)
set hls " highlight search
" Remove last search highlighting, when hitting return
nnoremap <CR> :set hlsearch!<cr>

" tab completion for files/bufferss
set wildmode=longest,list
set wildmenu
set mouse+=a " enable mouse mode (scrolling, selection, etc)

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" use relative numbering in normal mode
" and absolute numbering in insert mode
set nu " number lines
set rnu " relative line numbering
autocmd InsertEnter * :set norelativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" highlight current line, but only in active window
hi CursorLine term=bold cterm=bold guibg=Black
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" easy wrapped line navigation with ctrl key
vmap <C-j> gj
vmap <C-k> gk
nmap <C-j> gj
nmap <C-k> gk

" strip trailing whitespaces on all file
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif
