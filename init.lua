--[[
--           __
--   .--.--.|__|.--------.
--   |  |  ||  ||        |
--    \___/ |__||__|__|__|
--
-- By: Avery Wagar (@ajmwagar)
--]]

require("ajmwagar.misc")
require("ajmwagar.options")
require("ajmwagar.plugins")
require("ajmwagar.colors")
require("ajmwagar.keybinds")
require("ajmwagar.lsp")
require("ajmwagar.cmp")
require("ajmwagar.aws")
require("ajmwagar.undo")
require("ajmwagar.statusline")

--[[
vim.cmd([[
" Plugin Config: {{{
" COC {{{
" let g:coc_force_debug = 1

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

autocmd User CocDiagnosticChange silent call s:MaybeUpdateLightline()

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
"nmap <leader>ac  <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>q  <Plug>(coc-fix-current)
"nmap <leader>qa <Plug>(coc-fix-all)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)



" }}}
" fuzzy finder/ack Settings {{{
"Use ripgrep
let g:ackprg = 'rg --vimgrep --no-heading'
let g:grepprg='rg --vimgrep'
let g:rg_find_command = 'rg --files --follow  -g "!{.config,etc,node_modules,.git,target}/*"'
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* Rg call fzf#vim#files('.', {'source': g:rg_find_command}, 0) 

let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF() " Floating FZF Windows
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(&lines - (&lines * 2 / 10))
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  let win = nvim_open_win(buf, v:true, opts)
  call setwinvar(win, '&number', 0)
  setlocal signcolumn=no
endfunction

noremap <silent> <C-p> :Rg<return>
noremap <silent> <C-t> :Find<return>
noremap <silent> <C-b> :Buffers<cr>

"" }}}
"Lightline {{{ 
set showtabline=2

"
function! User()
  return system('echo -n $LOGNAME@$(cat /etc/hostname)')
  " . "@" . echo "silent !hostname"
endfunction

" use lightline-buffer in lightline
let g:lightline = {
      \ 'colorscheme': 'deus',
      \ 'component_expand': {
      \   'linter_warnings': 'CocWarnings',
      \   'linter_errors': 'CocErrors',
      \   'linter_ok': 'CocOK',
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'readonly': 'error',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'left',
      \   'time': 'left',
      \   'user': 'left',
      \   'buffers': 'tabsel',
      \ },
      \ 'component_function': {
      \   'wordcount': 'WordCount',
      \   'lsp': 'MiniStat',
      \   'time': 'Timer',
      \   'gitbranch': 'GitBranch',
      \   'filetype': 'Filetype',
      \   'user': 'User'
      \ },
      \ 'component': {
      \   'separator': ''
      \ },
      \ 'active': {
      \   'left': [
      \ ['mode', 'paste'], ['gitbranch', 'filename', 'modified']
      \ ],
      \   'right': [
      \             ['linter_ok'],
      \             ['lsp', 'linter_warnings', 'linter_errors'], 
      \             ['percent','lineinfo']
      \]
      \ }
      \ }

let g:lightline.tabline = {'left': [
      \ ['buffers']
      \ ], 'right': [['user', 'time']
      \ ]}

let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#unicode_symbols = 0

" let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
" let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
" let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
" let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }

function! LightlineBufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after]
endfunction

function! MiniStat() abort
  return get(g:, 'coc_status', '')
endfunction

function! Timer()
  " return strftime("%H:%S")
  return strftime("%H:%M") . " PST" "Timer in status line
  " return !date
endfunction

function! GitBranch()
  if (fugitive#head() != '')
    return fugitive#head()
  endif
  return ''
endfunction


" Coc Linter functions

function! CocWarnings() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  return printf('%d !', info['warning'])
endfunction

function! CocErrors() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  return printf('%d X', info['error'])
endfunction


function! CocOK() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  return empty(info) ? '✓' : ''
endfunction



" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction
"       \ }

" lightline-buffer ui settings
" replace these symbols with ascii characters if your environment does not support unicode
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '•'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_separator_icon = '  '

" max file name length
let g:lightline_buffer_maxflen = 30


" }}}
" Goyo: {{{
" Disable cursorline in goyo
function! ToggleCursorlineAutoGroup()
  if !exists('#CursorlineAutoGroup#InsertLeave')
    set cursorline
    augroup CursorlineAutoGroup
      autocmd!
      autocmd InsertLeave,WinEnter * set cursorline
      autocmd InsertEnter,WinLeave * set nocursorline
    augroup END
  else
    set nocursorline
    augroup CursorlineAutoGroup
      autocmd!
    augroup END
  endif

endfunction

set cursorline
call ToggleCursorlineAutoGroup()

set dictionary=/usr/share/dict/words
function! s:goyo_enter()
  call ToggleCursorlineAutoGroup()
  set showtabline=0
  set spell noci nosi noai 
  colorscheme deus
  set noshowcmd
  set scrolloff=999
endfunction

function! s:goyo_leave()
  call ToggleCursorlineAutoGroup()
  set showtabline=2
  set nospell ci si ai 
  set scrolloff=5
  colorscheme deus
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" }}}
" Startify: {{{
let g:ascii = [
      \ '           __',
      \ '   .--.--.|__|.--------.',
      \ '   |  |  ||  ||        |',
      \ '    \___/ |__||__|__|__|',
      \ ''
      \]
let g:startify_custom_header = g:ascii
" Functional Config {{{
" Workflow: {{{
" define a fancy nvim clipboard provider
if has('linux')
  let g:clipboard = {
    \   'name': 'Vim Clipboard',
    \   'copy': {
    \      '+': 'xclip -i -selection clipboard',
    \      '*': 'xclip -i -selection secondary',
    \    },
    \   'paste': {
    \      '+': 'xclip -o -selection clipboard',
    \      '*': 'xclip -o -selection secondary',
    \   },
    \   'cache_enabled': 1,
    \ }
  " tell nvim to use * as its internal clipboard
  " now vim sessions can share yank buffers by using the virtually unheard of
  " secondary selection buffer!
  set clipboard=unnamed
endif


filetype off
" Turn on syntax highlighting
syntax on
" Security
set modelines=1
set dictionary+=/usr/share/dict/words "Add  a dictionary
filetype plugin indent on " Turn on indeting

nmap <space>, :Vimrc<return>
nmap <C-,> :Vimrc<return>
if has('unix') 
  command! Vimrc edit /home/$USER/.config/nvim/init.vim
endif

set backspace=indent,eol,start " Use backspace in insert mode
set pdev=Brother_HL-4570CDW_series " Print from home
set noshowcmd
"" }}}
" Netrw: {{{

let g:netrw_liststyle = 3  " Show 'tree' view
let g:netrw_banner = 0 " Disable annoying banner
let g:netrw_winsize = 15 " 15 pecent of screen size
let g:netrw_altv = 1 " Auto cd
let g:netrw_preview= 1 " open previews vertically
let g:netrw_browse_split = 4 " Open in last used buffer

" Toggle Vexplore with leader-t
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
    let expl_win_num = bufwinnr(t:expl_buf_num)
    if expl_win_num != -1
      let cur_win_nr = winnr()
      exec expl_win_num . 'wincmd w'
      bd
      " exec cur_win_nr . 'wincmd w'
      unlet t:expl_buf_num
    else
      unlet t:expl_buf_num
    endif
  else
    exec '1wincmd w'
    Vexplore
    let t:expl_buf_num = bufnr("%")
  endif
endfunction

map <silent> <leader>t :call ToggleVExplorer()<CR>

" Follow symlinks
function! FollowSymlink()
  let current_file = expand('%:p')
  " Check for symlink
  if getftype(current_file) == 'link'
    " Open actual filepath
    let actual_file = resolve(current_file)
    silent! execute 'file ' . actual_file
  endif
endfunction


function! SetProjectRoot()
  " default to current
  lcd %:p:h
  let my_git_dir = system("git rev-parse --show-toplevel")
  " Check output
  let is_not_git_dir = matchstr(my_git_dir, '^fatal:.*')
  let is_not_dot_git_dir = matchstr(my_git_dir, '\n')

  if empty(is_not_git_dir)
    if empty(is_not_dot_git_dir)
      lcd my_git_dir
    endif
  endif
endfunction

autocmd BufNewFile *
      \   call SetProjectRoot()

autocmd CursorMoved silent *
      \ if &filetype == 'netrw' |
      \   call SetProjectRoot() |
      \ endif

" " }}}
"Terminal settings: {{{
autocmd TermOpen term://* startinsert
autocmd TermOpen term://* setlocal nonumber norelativenumber

" Make esc work
tnoremap <Leader><Esc> <C-\><C-n>

" Window navigation function
" Make ctrl-h/j/k/l move between windows and auto-insert in terminals
func! s:mapMoveToWindowInDirection(direction)
    func! s:maybeInsertMode(direction)
        stopinsert
        execute "wincmd" a:direction

        if &buftype == 'terminal'
            startinsert!
        endif
    endfunc

    execute "tnoremap" "<silent>" "<C-" . a:direction . ">"
                \ "<C-\\><C-n>"
                \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
    execute "nnoremap" "<silent>" "<C-" . a:direction . ">"
                \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
endfunc
for dir in ["h", "j", "l", "k"]
    call s:mapMoveToWindowInDirection(dir)
endfor

"}}}
" }}}
"Mappings {{{
vnoremap <silent> <Leader>is :<C-U>let old_reg_a=@a<CR>
 \:let old_reg=@"<CR>
 \gv"ay
 \:let @a=substitute(@a, '.\(.*\)\@=',
 \ '\=@a[strlen(submatch(1))]', 'g')<CR>
 \gvc<C-R>a<Esc>
 \:let @a=old_reg_a<CR>
 \:let @"=old_reg<CR>

"Goyo
nnoremap <silent><leader>z :GoyoStart<return>

" }}}
" Autocommands: {{{
augroup prose
  autocmd!
  autocmd FileType markdown set spell
  autocmd FileType text set spell
augroup end
" }}}
" }}}
]
])
]]--
