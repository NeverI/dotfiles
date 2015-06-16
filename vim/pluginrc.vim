filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'chriskempson/base16-vim'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'airblade/vim-gitgutter'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'

Plugin 'ctrlsf.vim'
Plugin 'terryma/vim-multiple-cursors'

Plugin 'mbbill/undotree'

Plugin 'evidens/vim-twig'
Plugin 'kchmck/vim-coffee-script'

call vundle#end()

" always show the statusbar
set laststatus=2
" add fugitive to statusline
set statusline=%<%f\ %{fugitive#head()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P
" autoclean fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" update frequently is increased so git gutter is more accurate
set updatetime=750

" PyMatcher for CtrlP
if !has('python')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

" 'a' the directory of the current file, unless it is a subdirectory of the cwd
" 'r' the nearest ancestor of the current file that contains gi
" 'w' start search from the cwd instead of the current file's directory
let g:ctrlp_working_path_mode = 'arw'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Set delay to prevent extra search
let g:ctrlp_lazy_update = 350

" Do not clear filenames cache, to improve CtrlP startup
" You can manualy clear it by <F5>
let g:ctrlp_clear_cache_on_exit = 0

" Set no file limit, we are building a big project
let g:ctrlp_max_files = 0

" If ag is available use it as filename list generator instead of 'find'
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore --hidden -g ""'
endif

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
