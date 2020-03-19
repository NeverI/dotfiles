" vim: foldmethod=marker

source ~/.vim/config.vim

" SID hack {{{
function! s:SID_PREFIX() abort
  return matchstr(expand('<sfile>'),
  \ '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
let g:sid = s:SID_PREFIX()
"}}}
" plugins {{{
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')

  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/defx.nvim')

  call dein#add('phpactor/phpactor')
  call dein#add('roxma/nvim-yarp')
  call dein#add('ncm2/ncm2')
  call dein#add('ncm2/ncm2-bufword')
  call dein#add('fgrsnau/ncm2-otherbuf')
  call dein#add('ncm2/ncm2-path')
  call dein#add('phpactor/ncm2-phpactor')
  call dein#add('ncm2/ncm2-tern', {'build': 'npm install'})
  call dein#add('ncm2/ncm2-cssomni')
  call dein#add('ncm2/ncm2-html-subscope')

  call dein#add('joshdick/onedark.vim')
  call dein#add('morhetz/gruvbox')
  call dein#add('camgunz/amber')

  call dein#add('vim-airline/vim-airline')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('tpope/vim-obsession')
  call dein#add('tpope/vim-eunuch')
  call dein#add('dyng/ctrlsf.vim')
  call dein#add('mhinz/vim-signify')
  call dein#add('tpope/vim-fugitive')
  call dein#add('junegunn/gv.vim')

  call dein#add('chrisbra/Colorizer')
  call dein#add('w0rp/ale')
  call dein#add('gkz/vim-ls')
  call dein#add('evidens/vim-twig')
  call dein#add('pangloss/vim-javascript')
  call dein#add('kchmck/vim-coffee-script')
  call dein#add('HerringtonDarkholme/yats.vim')
  call dein#add('mhartington/nvim-typescript', {'build': './install.sh'})
  call dein#add('NeverI/symfony.nvim')
  call dein#add('NeverI/denite-git-repo.nvim')

  call dein#end()
  call dein#save_state()
endif

syntax on
filetype plugin indent on
" }}}
" ncm2 {{{
autocmd BufEnter * call ncm2#enable_for_buffer()

set completeopt=noinsert,menuone,noselect
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}
" git plugins {{{
" autoclean fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

autocmd FileType gitcommit :setlocal spell

autocmd FileType GV call s:GV_settings()
function! s:GV_settings() abort
  " next / prev commit and open all the fold
  nmap sj jo<c-w>lzR<c-w>h
  nmap sk ko<c-w>lzR<c-w>h
endfunction

" }}}
" denite {{{
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> y denite#do_map('do_action', 'yank')
  nnoremap <silent><buffer><expr> a denite#do_map('choose_action')
  nnoremap <silent><buffer><expr> <C-a> denite#do_map('toggle_select_all')
  nnoremap <silent><buffer><expr> <C-r> denite#do_map('restart')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'

  if b:denite.buffer_name == 'git/repo'
    nnoremap <silent><buffer><expr> s denite#do_map('do_action', 'status')
    nnoremap <silent><buffer><expr> h denite#do_map('do_action', 'history')
    nnoremap <silent><buffer><expr> f denite#do_map('do_action', 'fetch')
    nnoremap <silent><buffer><expr> F denite#do_map('do_action', 'fetch_rebase')
    nnoremap <silent><buffer><expr> r denite#do_map('do_action', 'rebase')
    nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'push')
    nnoremap <silent><buffer><expr> g denite#do_map('do_action', 'git')
    nnoremap <silent><buffer><expr> G denite#do_map('do_action', 'git_show_output')
    nnoremap <silent><buffer><expr> c denite#do_map('do_action', 'checkout')
    nnoremap <silent><buffer><expr> C denite#do_map('do_action', 'checkout_smart_b')
  endif
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  call ncm2#disable_for_buffer()
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction

call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

call denite#custom#source('file/rec', 'matchers', ['matcher/regexp'])
call denite#custom#source('file/rec', 'sorters', ['sorter/sublime'])
call denite#custom#source('buffer', 'matchers', ['matcher/regexp'])
call denite#custom#source('buffer', 'sorters', ['sorter/sublime'])
call denite#custom#source('file', 'matchers', ['matcher/regexp'])
call denite#custom#source('file', 'sorters', ['sorter/sublime'])
call denite#custom#source('register', 'matchers', ['matcher/regexp'])
call denite#custom#source('grep', 'matchers', ['matcher/regexp'])
call denite#custom#option('_', 'highlight_mode_insert', 'CursorLine')
call denite#custom#option('_', 'highlight_matched_range', 'None')
call denite#custom#option('_', 'highlight_matched_char', 'Statement')
call denite#custom#option('_', 'statusline', v:false)

nnoremap <A-p> :Denite -start-filter -buffer-name=files file/rec<cr>
nnoremap <A-d> :Denite -start-filter -buffer-name=files file/rec:
nnoremap <A-d>w :DeniteCursorWord -buffer-name=files file/rec<cr>
nnoremap <A-b> :Denite -buffer-name=buffers buffer<cr>
nnoremap <A-d>r :Denite -resume -buffer-name=files<cr>
nnoremap <A-d>l :Denite -buffer-name=lines line<cr>
nnoremap <A-d>g :Denite -buffer-name=grep grep
" }}}
" CtrlSF {{{
let g:ctrlsf_ackprg = 'rg'
let g:ctrlsf_case_sensitive = 'yes'
vmap     <a-f>f <Plug>CtrlSFVwordPath
nmap     <a-f>f <Plug>CtrlSFPrompt
nmap     <a-f>n <Plug>CtrlSFCwordPath
nmap     <a-f>p <Plug>CtrlSFPwordPath
nnoremap <a-f>o :CtrlSFToggle<CR>
vnoremap <a-f>o <Esc>:CtrlSFToggle<CR>
inoremap <a-f>o <Esc>:CtrlSFToggle<CR>

let g:ctrlsf_auto_focus = {
    \ "at" : "done",
    \ "duration_less_than": 1000
    \ }
" }}}
" Colorizer {{{
let g:colorizer_use_virtual_text = 1
" }}}
" typescript {{{

let g:nvim_typescript#default_mappings=1

" }}}
" PhpActor {{{
let g:phpactorPhpBin = "/usr/bin/php7.1"

autocmd FileType php call s:phpactor_settings()
function! s:phpactor_settings() abort
  nnoremap <silent><buffer><expr>
    \ <Leader>pu <SID>phpactorImportClass()
  nnoremap <silent><buffer><expr>
    \ <Leader>pc phpactor#ClassNew()
  nnoremap <silent><buffer><expr>
    \ <Leader>pm phpactor#ExtractMethod()
  nnoremap <silent><buffer><expr>
    \ <Leader>pt phpactor#Transfrom()
  nnoremap <silent><buffer><expr>
    \ <Leader>pi phpactor#Hover()
endfunction

function! s:phpactorImportClass()
  let isClass = expand('<cword>') is 'class'
  if !isClass
    call phpactor#ImportClass()
    return
  endif

  execute "normal! 2F:h:call\<space>phpactor#ImportClass()\<cr>/class/e\<cr>"
endfunction
" }}}
" defx {{{
nnoremap <C-d> :Defx `expand('%:p:h')` -search=`expand('%:p')`<cr>

let s:defx_directory_closed_icon = '▸'
let s:defx_directory_opened_icon = '▾'
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
	call defx#custom#option('_', {
	      \ 'columns': 'mark:indent:icon:filename:type:size:time'
	      \ })
	call defx#custom#column('filename', {
	      \ 'min_width': 80,
	      \ 'max_width': 80,
	      \ })
	call defx#custom#column('time', {
	      \ 'format': '%y-%m-%d %H:%M:%S',
	      \ })
	call defx#custom#column('icon', {
	      \ 'directory_icon': s:defx_directory_closed_icon,
	      \ 'opened_icon': s:defx_directory_opened_icon,
	      \ 'root_icon': ' ',
	      \ })
	call defx#custom#column('mark', {
	      \ 'readonly_icon': '✗',
	      \ 'selected_icon': '✓',
	      \ })

  nnoremap <silent><buffer><expr> h
    \ getline('.') =~ '\[in\]:' ? defx#do_action('cd', ['..']) : defx#do_action('close_tree')
  nnoremap <silent><buffer><expr> H
    \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> j
    \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> J
    \ defx#do_action('call', g:sid.'jumpToDefxNextFolder')
  nnoremap <silent><buffer><expr> k
    \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> K
    \ defx#do_action('call', g:sid.'jumpToDefxPreviousFolder')
  nnoremap <silent><buffer><expr> l
    \ defx#is_directory() ? defx#do_action('open_tree') : defx#do_action('open')
  nnoremap <silent><buffer><expr> L
    \ defx#do_action('open')
  nnoremap <silent><buffer><expr> <CR>
    \ defx#do_action('drop')
  " preview in vertical view, but the cursor stay in the defx buffer
  nnoremap <silent><buffer> p
    \ :<c-u>silent execute "normal! :call defx#call_action('drop')\r"<cr><C-w>h
  nnoremap <silent><buffer><expr> i
   \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> I
    \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> o
    \ defx#is_opened_tree() ?
      \ defx#do_action('multi', ['close_tree', 'open_tree_recursive']) :
      \ defx#do_action('open_tree_recursive')
  nnoremap <silent><buffer><expr> O
    \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> ~
    \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> cd
    \ defx#do_action('call', g:sid.'setLocalCwdFromDefx')
  nnoremap <silent><buffer><expr> cD
    \ defx#do_action('change_vim_cwd')
  nnoremap <silent><buffer><expr> .
    \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> <Space>
    \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
    \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> c
    \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> v
    \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> m
    \ defx#do_action('move')
  nnoremap <silent><buffer><expr> r
    \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> d
    \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> D
    \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> F
    \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> y
    \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> ;
    \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> !
    \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> <C-r>
    \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> q
    \ defx#do_action('quit')

  nnoremap <silent><buffer><expr> sf
    \ defx#do_action('multi', [['toggle_sort', 'filename'], 'redraw'])
  nnoremap <silent><buffer><expr> sF
    \ defx#do_action('multi', [['toggle_sort', 'Filename'], 'redraw'])
  nnoremap <silent><buffer><expr> se
    \ defx#do_action('multi', [['toggle_sort', 'extension'], 'redraw'])
  nnoremap <silent><buffer><expr> sE
    \ defx#do_action('multi', [['toggle_sort', 'Extension'], 'redraw'])
  nnoremap <silent><buffer><expr> st
    \ defx#do_action('multi', [['toggle_sort', 'Time'], 'redraw'])
  nnoremap <silent><buffer><expr> sT
    \ defx#do_action('multi', [['toggle_sort', 'time'], 'redraw'])
  nnoremap <silent><buffer><expr> ss
    \ defx#do_action('multi', [['toggle_sort', 'size'], 'redraw'])
  nnoremap <silent><buffer><expr> sS
    \ defx#do_action('multi', [['toggle_sort', 'Size'], 'redraw'])

  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:filename')
endfunction
" mapping functions {{{
function! s:jumpToDefxPreviousFolder(_) abort
  call s:jumpToDefxFolderInDirection('up')
endfunction

function! s:jumpToDefxFolderInDirection(direction) abort
  let targetLine = a:direction == 'up' ? 1 : line('$')
  let result = s:jumpToDefxFolderInOneDirection(a:direction, line('.'), targetLine)

  if result is v:false
    let startLine = a:direction == 'up' ? line('$') : 1
    call s:jumpToDefxFolderInOneDirection(a:direction, startLine, line('.'))
  endif
endfunction

function! s:jumpToDefxFolderInOneDirection(direction, startLine, targetLine) abort
  let linenumb = a:startLine
  while linenumb != a:targetLine
    let linenumb += a:direction == 'up' ? -1 : 1
    if getline(linenumb) =~ '['.s:defx_directory_closed_icon.s:defx_directory_opened_icon.']'
      silent execute 'normal! :' . linenumb . "\r"
      return v:true
    endif
  endwhile

  return v:false
endfunction

function! s:jumpToDefxNextFolder(_) abort
  call s:jumpToDefxFolderInDirection('down')
endfunction

function! s:setLocalCwdFromDefx(context)
  let candidate = defx#get_candidate()
  let dir = candidate.action__path
  if !candidate.is_directory
    let dir = fnamemodify(dir, ':h')
  endif

  execute 'lcd ' . dir
endfunction
"}}}
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
autocmd BufEnter * call s:open_defx_if_directory()
function! s:open_defx_if_directory()
  if isdirectory(expand('%:p'))
    Defx `expand('%:p')`
  endif
endfunction
" }}}
" keymappings {{{
" close and jump to the next or prev file on the log view
nnoremap zw zckzo
nnoremap zs zcjzo
" leave the terminal insert mode
:tnoremap <Esc> <C-\><C-n>
" yank the selected text via mouse
vnoremap <LeftRelease> "*ygv

nnoremap <silent> <Leader><Leader>se :setlocal spell! spelllang=en_us<CR>
nnoremap <silent> <Leader><Leader>sh :setlocal spell! spelllang=hu<CR>
" }}}
" symfony {{{
let g:symfonyNvimCamelCaseServiceNames = v:true

autocmd VimEnter * :call symfony#startHere()
autocmd FileType yamlSFconfig nnoremap <silent> <buffer>
  \ <C-]> :call symfony#goto#inYamlSFconfig('inplace')<CR>
autocmd FileType php nnoremap <silent> <buffer>
  \ <C-]> :call symfony#goto#inPhp('inplace')<CR>
autocmd FileType *twig nnoremap <silent> <buffer>
  \ <C-]> :call symfony#goto#inTwig('inplace')<CR>

nnoremap <C-p>s :Denite -start-filter -source-names=hide -buffer-name=symfony
  \ symfony/service symfony/parameter symfony/entity<CR>
" }}}
" misc {{{
let $LOCALFILE=expand("~/.nvim_local.vim")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

let g:airline_theme='gruvbox'
let g:gruvbox_italic=1
colorscheme gruvbox
hi! Normal ctermbg=NONE guibg=NONE
highlight! SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
highlight! CursorLine term=bold cterm=bold guibg=NONE ctermbg=NONE
" }}}
