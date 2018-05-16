if exists('*minpac#init')
  call minpac#init()

  " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  function! DoRemote()
    UpdateRemotePlugins
  endfunction

  " Syntax 
  call minpac#add('jiangmiao/auto-pairs') " Auto close pairs
  call minpac#add('sheerun/vim-polyglot') " Syntax
  call minpac#add('godlygeek/tabular')  " Formatting

  " Autocomplete
  call minpac#add('autozimu/LanguageClient-neovim', {'do': '!sh ./install.sh', 'branch': 'next' })

  " Documentation
  call minpac#add('Konfekt/vim-zeal')

  call minpac#add('Shougo/deoplete.nvim', {'do': 'call DoRemote()'})

  " Snippets 
  call minpac#add('SirVer/ultisnips')

  " Prose mode plugins
  call minpac#add('ujihisa/neco-look', {'for': ['md', 'txt', 'markdown']})
  call minpac#add('davinche/godown-vim', {'type': 'opt'})
  call minpac#add('junegunn/goyo.vim')
  call minpac#add('junegunn/limelight.vim')

  " Colorsheme
  call minpac#add('ajmwagar/vim-deus')
  call minpac#add('ryanoasis/vim-devicons')

  " Status bar
  call minpac#add('ajmwagar/lightline-deus') | call minpac#add('taohex/lightline-buffer') | call minpac#add('itchyny/lightline.vim')

  " Searching/Fuzzy Finding
  call minpac#add('junegunn/fzf', { 'do': './install --all' }) | call minpac#add('junegunn/fzf.vim')
  call minpac#add('mileszs/ack.vim')

  " Git support
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('mhinz/vim-signify')

  " build
  call minpac#add('skywind3000/asyncrun.vim')

  " Comments
  call minpac#add('tpope/vim-commentary')
endif

" Completion {{{
" nvim-completion-manager

"  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Deoplete
let g:deoplete#enable_at_startup = 1 " Auto start
let g:deoplete#enable_smart_case = 1 " Smart case
let g:deoplete#auto_complete_start_length = 2 " Stop bothering me
let g:deoplete#enable_refresh_always = 0

let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0

set completeopt-=preview

"use TAB as the mapping
inoremap <silent><expr> <TAB>
      \ pumvisible() ?  "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort ""     
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction ""   

inoremap <silent><expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"


" Sources:
let g:deoplete#sources = {}
let g:deoplete#ignore_sources = {}

let g:deoplete#sources.markdown = ['look']
" Ignore look in code files
let g:deoplete#ignore_sources.java = ['look']
let g:deoplete#ignore_sources['cs'] = ['look']
let g:deoplete#ignore_sources['javascript'] = ['look']
let g:deoplete#ignore_sources['rust'] = ['look']
let g:deoplete#ignore_sources['python'] = ['look']
let g:deoplete#ignore_sources['snippets'] = ['look']
let g:deoplete#ignore_sources['sh'] = ['look']
let g:deoplete#ignore_sources['go'] = ['look']
let g:deoplete#ignore_sources['pug'] = ['look']
let g:deoplete#ignore_sources['css'] = ['look']
let g:deoplete#ignore_sources['html'] = ['look']
let g:deoplete#ignore_sources['log'] = ['look']

" }}}
" LSP {{{

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Minimal LSP configuration for JavaScript
let g:LanguageClient_serverCommands = {
      \ 'rust': ['rls'],
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'javascript.jsx': ['javascript-typescript-stdio'],
      \ 'python': ['pyls'],
      \ 'java': ['jdtls']
      \ }

autocmd FileType javascript setlocal omnifunc=LanguageClient#complete

" Smarter vim features
" Documentation
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"
" GoTo def
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" Rename
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" Symbols
nnoremap <silent> <C-s> :call LanguageClient#textDocument_documentSymbol()<CR>
" Formatting 
nnoremap <silent> <C-f> :call LanguageClient#textDocument_formatting()<CR>

nnoremap <silent> <leader>r :call LanguageClient#textDocument_references()<CR>

" Auto start server
" autocmd FileType javascript :LanguageClientStart<CR>
" autocmd FileType java :LanguageClientStart<CR>
" autocmd FileType python :LanguageClientStart<CR>
" autocmd FileType rust :LanguageClientStart<CR>


" signText": "⚠️ ⛔️",
" better diagnotics
let g:LanguageClient_diagnosticsDisplay =  {
      \ 1: {
      \ "name": "Error",
      \ "texthl": "ALEError",
      \ "signText": "✘",
      \ "signTexthl": "ALEErrorSign",
      \ },
      \ 2: {
      \ "name": "Warning",
      \ "texthl": "ALEWarning",
      \ "signText": "⚠",
      \ "signTexthl": "ALEWarningSign",
      \ },
      \ 3: {
      \ "name": "Information",
      \ "texthl": "ALEInfo",
      \ "signText": "ℹ",
      \ "signTexthl": "ALEInfoSign",
      \ },
      \ 4: {
      \ "name": "Hint",
      \ "texthl": "ALEInfo",
      \ "signText": "➤",
      \ "signTexthl": "ALEInfoSign",
      \ },
      \ }



" " Map renaming in python
" autocmd FileType python nnoremap <buffer>
"   \ <leader>lr :call LanguageClient_textDocument_rename()<cr>
" }}}
" Snippets {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" Unmap these
inoremap <c-n> <NOP>
inoremap <c-p> <NOP>

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>" 
let g:UltiSnipsSnippetDirectories=["/home/ajmwagar/.config/nvim/UltiSnips"] " Setup dir


" imap <c-j>     <Plug>(neosnippet_expand_or_jump)
" vmap <c-j>     <Plug>(neosnippet_expand_or_jump)
" inoremap <silent> <c-u> <c-r>=cm#sources#neosnippet#trigger_or_popup("\<Plug>(neosnippet_expand_or_jump)")<cr>
" vmap <c-u>     <Plug>(neosnippet_expand_target)
" " expand parameters
" let g:neosnippet#enable_completed_snippet=1
" }}}
" Signify {{{
let g:signify_vcs_list = ['git']
let g:signify_realtime = 1
" }}}
" Prose: {{{
" Goyo {{{
set dictionary=/usr/share/dict/words
function! s:goyo_enter()
  set spell 
  set noci
  set nosi 
  set noai 
  colorscheme whiteboard
  set noshowcmd
  set scrolloff=999
  :Limelight
  " :SignifyToggle

endfunction

function! s:goyo_leave()
  set nospell ci si ai 
  set scrolloff=5
  colorscheme deus
  " :SignifyEnable
  :Limelight!

endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" }}}
" }}}
"fuzzy finder/ack Settings {{{
"Use ripgrep
let g:ackprg = 'rg --vimgrep --no-heading'

let g:rg_find_command = 'rg --files --follow -g "!{.config,etc,bin,node_modules,.git}/*"'
command! -bang -nargs=* Rg call fzf#vim#files('.', {'source': g:rg_find_command}, 0) 
let g:ackprg = 'rg --vimgrep --no-heading'
noremap <silent> <C-p> :Rg<return>
noremap <silent> <C-b> :Buffers<cr>

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
      \   'left': [['mode', 'paste'], ['gitbranch', 'filetype', 'modified']],
      \   'right': [['time'], ['lineinfo'],  ['percent']]
      \ }
      \ }


function! Timer()
  " return strftime("%H:%S")
  return strftime("%H:%M") . " PST" "Timer in status line
  " return !date
endfunction

function! MyGit()
  if (fugitive#head() != '')
    return fugitive#head() . " "
  endif
  return ''
endfunction

function! MyFiletype()
  if expand('%:t') != ''
    return expand('%:t') . " " .  WebDevIconsGetFileTypeSymbol()
  else
    return ''
  endif
  " return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol()  ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction



" function! LightlineLinterWarnings() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"   return l:counts.total == 0 ? '' : printf('%d ⚠', all_non_errors)
" endfunction

" function! LightlineLinterErrors() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"   return l:counts.total == 0 ? '' : printf('%d 🔴', all_errors)
" endfunction

" function! LightlineLinterOK() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"   return l:counts.total == 0 ? '✓ ' : ''
" endfunction

" autocmd User ALELint call s:MaybeUpdateLightline()

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
" Pointbreak: {{{
" let g:pointbreak_char = "🔴"
" let g:pointbreak_autostart = 1

" nnoremap <leader>b :PointbreakAdd<CR>
" nnoremap <leader>br :PointbreakRemove<CR>
" }}}
" AsyncRun: {{{
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

autocmd User AsyncRunPre :copen
" }}}
" Packadd: {{{
" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" Godown packadd
autocmd FileType markdown packadd godown-vim
" }}}
