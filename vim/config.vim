syntax on
filetype plugin indent on
set autoindent

" whitespace handling
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

au FileType php setl tabstop=4 shiftwidth=4 softtabstop=4
au FileType python setl tabstop=4 shiftwidth=4 softtabstop=4

" ensure the correct linewrap
set linebreak
set wrap
set nolist

set nrformats=
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

" set tmp dirs
set backupdir=~/.vim/backup/
set directory=~/.vim/swap/
set undodir=~/.vim/undo/
set backupcopy=yes

" search related things
set incsearch " incremental search (as string is being typed)
set hlsearch " highlight search
" Remove last search highlighting, when hitting return
nnoremap <CR> :set hlsearch!<cr>

" tab completion for files/bufferss
set wildmode=longest,list
set wildmenu
set wildignore+=*/cache/*,*/tmp/*,*.so,*.swp,*.zip

" enable mouse mode (scrolling, selection, etc)
set mouse+=a


" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" use relative numbering in normal mode
" and absolute numbering in insert mode
set number " number lines
set relativenumber " relative line numbering
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

" Visually select the text that was last edited/pasted
nmap gV `[v`]
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" strip trailing whitespaces on all file
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" easy tab size changer
func TabSize(size)
    let &tabstop=a:size
    let &shiftwidth=a:size
    let &softtabstop=a:size
endfun

" create none existing directories on buff save
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif