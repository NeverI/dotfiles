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
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
Plugin 'SirVer/ultisnips'

Plugin 'ctrlsf.vim'
Plugin 'terryma/vim-multiple-cursors'

Plugin 'scrooloose/syntastic'
Plugin 'rhysd/clever-f.vim'
Plugin 'mbbill/undotree'

Plugin 'gkz/vim-ls'
Plugin 'evidens/vim-twig'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mtscout6/vim-cjsx'

call vundle#end()

" always show the statusbar
set laststatus=2
" add syntastic and fugitive to statusline
set statusline=%<%f\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %{fugitive#head()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" autoclean fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" update frequently is increased so git gutter is more accurate
set updatetime=750

let g:ctrlsf_ackprg = 'ag'
let g:ctrlsf_case_sensitive = 'yes'
vmap     <C-F>f <Plug>CtrlSFVwordPath
nmap     <C-F>f <Plug>CtrlSFPrompt
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFToggle<CR>
vnoremap <C-F>o <Esc>:CtrlSFToggle<CR>
inoremap <C-F>o <Esc>:CtrlSFToggle<CR>

" If ag is available use it as filename list generator instead of 'find'
if executable("ag")
    let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor -S -C4'
    let g:unite_source_grep_recursive_opt = ''
endif

let g:unite_prompt='» '
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_rec_max_cache_files = 3000
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <C-b> :Unite -buffer-name=buffers -no-start-insert buffer<cr>
nnoremap <C-x> :Unite -buffer-name=yank history/yank<cr>
nnoremap <C-p> :Unite -buffer-name=files buffer file_rec/async:!<cr>
nnoremap <C-U>u :Unite
nnoremap <C-U>r :UniteResume<cr>
nnoremap <C-U>f :Unite -buffer-name=files file_rec/async:
nnoremap <C-U>g :Unite -buffer-name=grep grep:
nnoremap <C-U>l :Unite -buffer-name=lines line

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-s-tab>"
