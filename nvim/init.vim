vnoremap <LeftRelease> "*ygv

set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')

  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/defx.nvim')

  "call dein#add('Shougo/deoplete.nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('ncm2/ncm2')
  call dein#add('ncm2/ncm2-bufword')
  call dein#add('fgrsnau/ncm2-otherbuf')
  call dein#add('ncm2/ncm2-path')
  call dein#add('phpactor/ncm2-phpactor')
  call dein#add('ncm2/ncm2-tern', {'build': 'npm install'})
  call dein#add('ncm2/ncm2-cssomni')
  call dein#add('ncm2/ncm2-html-subscope')

	call dein#add('vim-airline/vim-airline')
  "call dein#add('chriskempson/base16-vim')
  call dein#add('joshdick/onedark.vim')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('tpope/vim-obsession')
  call dein#add('tpope/vim-eunuch')
  call dein#add('dyng/ctrlsf.vim')
	call dein#add('mhinz/vim-signify')
	call dein#add('tpope/vim-fugitive')

  call dein#add('w0rp/ale')
  call dein#add('gkz/vim-ls')
  call dein#add('evidens/vim-twig')
  call dein#add('pangloss/vim-javascript')
  call dein#add('kchmck/vim-coffee-script')
  call dein#add('HerringtonDarkholme/yats.vim')
	call dein#add('mhartington/nvim-typescript', {'build': './install.sh'})
  call dein#add('phpactor/phpactor')
  "call dein#add('kristijanhusak/deoplete-phpactor')
	"call dein#add('shawncplus/phpcomplete.vim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

"let g:deoplete#enable_at_startup = 1
"call deoplete#custom#option('max_list', 20)
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

" autoclean fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
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

nnoremap <C-p> :Denite -buffer-name=files file/rec<cr>
nnoremap <C-p>p :Denite -buffer-name=files file/rec:
nnoremap <C-p>c :DeniteCursorWord -buffer-name=files file/rec<cr>
nnoremap <C-b> :Denite -buffer-name=buffers buffer<cr>
nnoremap <C-p>r :Denite -resume -buffer-name=files<cr>
nnoremap <C-p>l :Denite -buffer-name=lines line<cr>
nnoremap <C-p>g :Denite -buffer-name=grep grep
nnoremap <C-p>m :Denite file_mru<cr>

let g:nvim_typescript#default_mappings=1

let g:ctrlsf_ackprg = 'rg'
let g:ctrlsf_case_sensitive = 'yes'
vmap     <C-F>f <Plug>CtrlSFVwordPath
nmap     <C-F>f <Plug>CtrlSFPrompt
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFToggle<CR>
vnoremap <C-F>o <Esc>:CtrlSFToggle<CR>
inoremap <C-F>o <Esc>:CtrlSFToggle<CR>

source ~/.vim/config.vim
source ~/.nvim_local.vim

colorscheme onedark
let g:airline_theme='onedark'

hi! Normal ctermbg=NONE guibg=NONE
hi! LineNr ctermfg=darkgrey

" leave the terminal insert mode
:tnoremap <Esc> <C-\><C-n>

let g:phpactorPhpBin = "/usr/bin/php7.1"
autocmd FileType php nmap <C-]> :call phpactor#GotoDefinition()<CR>


autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'Time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction
