" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin()

function! DoRemote(arg)
	UpdateRemotePlugins
endfunction
" Syntax 
Plug 'sheerun/vim-polyglot'
Plug 'equalsraf/neovim-gui-shim'
Plug 'joshdick/onedark.vim'
Plug 'dzhou121/gonvim-fuzzy'

" Auto complete
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'w0rp/ale' " Linter
" Plug 'ludovicchabant/vim-gutentags' " Tag support
Plug 'jiangmiao/auto-pairs' " Auto close pairs
Plug 'SirVer/ultisnips'

" Java Plugins
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java'}

" Python Plugins
Plug 'zchee/deoplete-jedi', { 'for': ['python', 'py'] }

" C# Plugins
Plug 'ajmwagar/deoplete-omnisharp', {'for': ['cs', 'csharp']}
Plug 'OmniSharp/omnisharp-vim', { 'for': ['cs', 'csharp']}

" Prose mode plugins
Plug 'ujihisa/neco-look', {'for': ['md', 'txt', 'markdown']}
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim' ", { 'on': 'GoyoEnter' }
Plug 'suan/vim-instant-markdown', {'for': ['markdown', 'md','mkd']}

Plug 'fszymanski/deoplete-emoji', {'for': ['md','markdown', 'txt', '']}
Plug 'junegunn/vim-emoji', {'for': ['md', 'markdown', 'txt', '']}

"Javascript Plugins
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'js', 'jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'js', 'jsx']}
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern'}

" Colorsheme
Plug 'ajmwagar/vim-deus'
Plug 'ajmwgar/vim-emoticons'

" Status bar
Plug 'ajmwagar/lightline-deus'
Plug 'taohex/lightline-buffer'
Plug 'itchyny/lightline.vim'

" Searching/Fuzzy Finding
Plug 'junegunn/fzf', { 'dir': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'

" Comments
Plug 'tpope/vim-commentary'

" File path
Plug 'scrooloose/nerdtree'

call plug#end()

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])

let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

set completeopt-=preview

"use TAB as the mapping
inoremap <silent><expr> <TAB>
      \ pumvisible() ?  "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "" {{{    
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction ""  }}} 

inoremap <silent><expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" Start Java Completer
autocmd FileType java setlocal omnifunc=javacomplete#Complete
"autocmd FileType java JCEnable

" C# Completion
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
let g:OmniSharp_selector_ui='fzf'
let g:OmniSharp_server_type = 'v1'

" let g:OmniSharp_server_type = 'roslyn'
" let g:OmniSharp_server_path = '/home/ajmwagar/.config/nvim/omni/omnisharp/OmniSharp.exe'

" Goyo {{{
set dictionary=/usr/share/dict/words
function! s:goyo_enter()
  let g:deoplete#sources._=[ 'look', 'buffer', 'ultisnips', 'file', 'dictionary']
  set spell 
  let b:deoplete_ignore_sources = []
  set noci
  set nosi 
  set noai 
  colorscheme whiteboard
  :ALEDisableBuffer
  "set noshowcmd
  set scrolloff=999
  :Limelight

endfunction

function! s:goyo_leave()
  "let b:deoplete_ignore_sources = ['look']
  set nospell ci si ai 
  set scrolloff=5
  colorscheme deus
  :ALEEnableBuffer
  :Limelight!

endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" }}}
" Devicons{{{
" loading the plugin
let g:webdevicons_enable = 1

" adding the flags to NERDTree
"let g:webdevicons_enable_nerdtree = 1

" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1

" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" }}}
"NERDTree Settings {{{
"======================================================================

"Settings

" }}}
"fuzzy finder/ack Settings {{{
set noshowmode

"Use ripgrep
let g:ackprg = 'rg --vimgrep --no-heading'

let g:rg_find_command = 'rg --files --follow -g "!{.config,etc,bin,node_modules,.git}/*"'
command! -bang -nargs=* Rg call fzf#vim#files('.', {'source': g:rg_find_command}, 0) 
let g:ackprg = 'rg --vimgrep --no-heading'
if !has('gui_running')
  noremap <silent> <C-p> :Rg<return>
  noremap <silent> <C-b> :Buffers<cr>
endif
if has('gui_running')
  noremap <silent> <C-p> :GonvimFuzzyFiles
endif

noremap <C-t> :LAck<space>

" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" }}}
"Lightline {{{ 
set showtabline=2

" use lightline-buffer in lightline
let g:lightline = {
      \ 'colorscheme': 'deus',
      \ 'tabline': {
      \   'left': [ [ ],
      \             [ 'separator' ],
      \             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
      \   'right': [],
      \ },
      \ 'component_expand': {
      \   'linter_warnings': 'LightlineLinterWarnings',
      \   'linter_errors': 'LightlineLinterErrors',
      \   'linter_ok': 'LightlineLinterOK',
      \   'buffercurrent': 'lightline#buffer#buffercurrent',
      \   'bufferbefore': 'lightline#buffer#bufferbefore',
      \   'bufferafter': 'lightline#buffer#bufferafter'
      \ },
      \ 'component_type': {
      \   'readonly': 'error',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'buffercurrent': 'tabsel',
      \   'bufferbefore': 'raw',
      \   'bufferafter': 'raw'
      \ },
      \ 'component_function': {
      \   'time': 'Timer',
      \   'gitbranch': 'MyGit',
      \   'bufferinfo': 'lightline#buffer#bufferinfo',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat'
      \ },
      \ 'component': {
      \   'separator': ''
      \ },
      \ 'active': {
      \   'left': [['mode', 'paste'], ['gitbranch', 'filename', 'filetype', 'modified']],
      \   'right': [['time'], ['lineinfo'],  ['percent'], ['linter_warnings', 'linter_errors', 'linter_ok']]
      \ }
      \ }


function! Timer()
  " return strftime("%H%S")
  return strftime("%H:%M") . " 🕒"  "Timer in status line
  " return !date
endfunction

function! MyGit()
  if (fugitive#head() != '')
    return fugitive#head() . " "
  endif
  return ''
endfunction

function! MyFiletype()
  " return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol()  ''
  return WebDevIconsGetFileTypeSymbol()
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction


function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ⚠', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d 🔴', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction
      \ }

" lightline-buffer ui settings
" replace these symbols with ascii characters if your environment does not support unicode
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '•'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_separator_icon = '  '

" enable devicons, only support utf-8
" require <https://github.com/ryanoasis/vim-devicons>
let g:lightline_buffer_enable_devicons = 1

" max file name length
let g:lightline_buffer_maxflen = 30

" }}}
"Ale Settings {{{

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
" let g:ale_sign_error = '💥'  
let g:ale_sign_error = '🔴'  
let g:ale_sign_warning = '⚠️'
let g:ale_open_list = 0
let g:ale_loclist = 0
let g:ale_javascript_eslint_use_global = 1

" let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
" let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
" let g:gitgutter_sign_removed = emi#for('small_red_triangle')
" let g:gitgutter_sign_modified_removed = emoji#for('collision')

" }}}
" emoji {{{

" emoji replace
nnoremap <leader>em :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<cr>

set completefunc=emoji#complete


" }}}
" UltiSnips {{{

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsSnippetsDir="~/.config/nvim/UltiSnips"

" }}}
"NERDTree Settings {{{
"======================================================================

"Settings
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    if (expand("%:t") != '')
      exe ":NERDTreeFind"
    else
      exe ":NERDTreeToggle"
    endif
  endif
endfunction

let NERDTreeIgnore = ['\.meta$','\.ipa$','\.apk$','\.zip$','\.rar$', '\.class$']
" open Nerd Tree in folder of file in active buffer
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
let g:NERDTreeChDirMode = 2

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" }}}
