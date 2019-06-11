" For a paranoia.
" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif
let mapleader = ";"

" Begone default plugins: {{{
"
let g:loaded_matchit = 1 " Don't need it
let g:loaded_gzip = 1 " Gzip is pointless
let g:loaded_zipPlugin = 1 " zip is also pointless
let g:loaded_logipat = 1 " No logs
let g:loaded_2html_plugin = 1 " Disable 2html
let g:loaded_rrhelper = 1 " I don't use r
let g:loaded_getscriptPlugin = 1 " Dont need it
let g:loaded_tarPlugin = 1 " Nope

" }}}
" VIMRC: {{{
" source ~/.config/nvim/config/plugins.vim 
" " Handle Plugins with minpac 
" Import Plugins: {{{
if exists('*minpac#init')
  call minpac#init()

  " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  " Fast plugin manager

  function! DoRemote()
    UpdateRemotePlugins
  endfunction

  call minpac#add('christoomey/vim-tmux-navigator')
  call minpac#add('mhinz/vim-startify')

  " Workflow plugins
  " call minpac#add('posva/vim-vue') " vue syntax
  call minpac#add('sheerun/vim-polyglot') " Syntax files for most languages
  call minpac#add('jiangmiao/auto-pairs') " Auto close brackets and ''
  call minpac#add('tpope/vim-commentary') " Toggle comments with ease
  " cal minpac#add('Shougo/defx.nvim', {'do': ':UpdateRemotePlugins' })
  " call minpac#add('ConradIrwin/vim-bracketed-paste') " Paste better into vim from terminal

  " Searching/Fuzzy Finding
  call minpac#add('junegunn/fzf', { 'do': './install --all' }) | call minpac#add('junegunn/fzf.vim') " FZF <3's Vim
  call minpac#add('mileszs/ack.vim') " Search me, baby

  " Autocomplete
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('neoclide/coc.nvim', {'do': 'call coc#util#install()'}) " Conquereer of Completions 
  " call minpac#add('w0rp/ale') " ALE
  call minpac#add('KabbAmine/zeavim.vim') " ZealDoc Support
  " Prose mode plugins
  " call minpac#add('davinche/godown-vim', {'type': 'opt'})
  call minpac#add('junegunn/goyo.vim', {'type': 'opt'})
  call minpac#add('junegunn/limelight.vim', {'type': 'opt'})
  call minpac#add('mengelbrecht/lightline-bufferline')
  " call minpac#add('reedes/vim-pencil')

  " Editor plugins/UI
  call minpac#add('ajmwagar/vim-deus') " Colorsheme
  call minpac#add('ajmwagar/lightline-deus')
  " call minpac#add('ap/vim-buftabline')
  call minpac#add('itchyny/lightline.vim') " Status bar

endif
" }}}
" Plugin Config: {{{
" COC {{{

" let g:coc_force_debug = 1
"Better display for messages
set cmdheight=1
set noshowmode
set noruler
set noshowcmd

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=100

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

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

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gn <Plug>(coc-rename)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

autocmd User CocDiagnosticChange silent call s:MaybeUpdateLightline()

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format)


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
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


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

" }}}
" ALE: {{{
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_save = 1
"" }}}
" fuzzy finder/ack Settings {{{
"Use ripgrep
let g:ackprg = 'rg --vimgrep --no-heading'
let g:rg_find_command = 'rg --files --follow -g "!{.config,etc,node_modules,.git,target}/*"'
command! -bang -nargs=* Rg call fzf#vim#files('.', {'source': g:rg_find_command}, 0) 
let g:ackprg = 'rg --vimgrep --no-heading'

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
noremap <silent> <C-b> :Buffers<cr>

noremap <C-t> :LAck<space>

" Customize fzf colors to match your color scheme

"" }}}
"Lightline {{{ 
set showtabline=2

" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'cocstatus': 'coc#status'
"       \ },
"       \ }
"
function! User()
  return system('echo -n $LOGNAME@$(/bin/hostname -s)')
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
      \   'left': [['mode', 'paste'], ['gitbranch', 'filename', 'modified']],
      \   'right': [
      \             ['linter_ok'],
      \             ['lsp', 'linter_warnings', 'linter_errors'], 
      \             ['percent','lineinfo']
      \]
      \ }
      \ }

let g:lightline.tabline = {'left': [['buffers']], 'right': [['user', 'time']]}
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#unicode_symbols = 1

" let g:lightline.separator = {
"       \   'left': '', 'right': ''
"       \}
" let g:lightline.subseparator = {
"       \   'left': '', 'right': '' 
"       \}
let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
" let g:buftabline_separators = 1
" let g:buftabline_separators_char = ''

function! LightlineBufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after]
endfunction

" function! StatusDiagnostic() abort
"   let info = get(b:, 'coc_diagnostic_info', {})
"   if empty(info) | return '' | endif
"   let msgs = []
"   if get(info, 'error', 0)
"     call add(msgs, '❌ ' . info['error'])
"   endif
"   if get(info, 'warning', 0)
"     call add(msgs, '⚡ ' . info['warning'])
"   endif
"   return join(msgs, ' ') 
" endfunction

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
    return fugitive#head() . ' '
  endif
  return ''
endfunction

" function! Filetype()
"   if expand('%:t') != ''
"     return expand('%:t') . " "  " .  WebDevIconsGetFileTypeSymbol()
"   else
"     return ''
"   endif
"   " return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol()  ''
" endfunction

" function! MyFileformat()
"   return winwidth(0) > 70 ? (&fileformat . ' ' )  " . WebDevIconsGetFileFormatSymbol()) : ''
" endfunction

function! WordCount()
  if &buftype !=# 'terminal' 
    let currentmode = mode()
    if !exists("g:lastmode_wc")
      let g:lastmode_wc = currentmode
    endif
    " if we modify file, open a new buffer, be in visual ever, or switch modes
    " since last run, we recompute.
    if &modified || !exists("b:wordcount") || currentmode =~? '\c.*v' || currentmode != g:lastmode_wc 
      let g:lastmode_wc = currentmode
      let l:old_position = getpos('.')
      let l:old_status = v:statusmsg
      execute "silent normal g\<c-g>"
      if v:statusmsg == "--No lines in buffer--"
        let b:wordcount = 0
      else
        let s:split_wc = split(v:statusmsg)
        if index(s:split_wc, "Selected") < 0
          let b:wordcount = str2nr(s:split_wc[11])
        else
          let b:wordcount = str2nr(s:split_wc[5])
        endif
        let v:statusmsg = l:old_status
      endif
      call setpos('.', l:old_position)
      return 'WC ' . b:wordcount
    else
      return 'WC '. b:wordcount
    endif
  endif
endfunction

" Coc Linter functions

function! CocWarnings() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  return printf('%d ⚠', info['warning'])
endfunction

function! CocErrors() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  return printf('%d 🔴', info['error'])
endfunction


function! CocOK() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  return empty(info) ? '✓' : ''
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
"   return l:counts.total == 0 ? '✓' : ''
" endfunction



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

" enable devicons, only support utf-8
" require <https://github.com/ryanoasis/vim-devicons>
" let g:lightline_buffer_enable_devicons = 1

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

" call ToggleCursorlineAutoGroup()

set cursorline
call ToggleCursorlineAutoGroup()

set dictionary=/usr/share/dict/words
function! s:goyo_enter()
  call ToggleCursorlineAutoGroup()

  " set nocursorline
  set showtabline=0
  " let g:buftabline_show=0
  " call buftabline#update(0)
  set spell noci nosi noai 
  " colorscheme whiteboard
  colorscheme deus
  set noshowcmd
  set scrolloff=999
  ":Limelight
  " :SignifyToggle

endfunction

function! s:goyo_leave()
  call ToggleCursorlineAutoGroup()
  " set cursorline
  set showtabline=2
  set nospell ci si ai 
  set scrolloff=5
  colorscheme deus
  " :SignifyEnable
  ":Limelight!

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

"" }}}
" Packadd: {{{
" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()

" Godown packadd
" autocmd FileType markdown packadd godown-vim
"
" Goyo and Limelighy
command! GoyoStart packadd goyo.vim | packadd limelight.vim | Goyo
" }}}
" }}}
" Functional Config {{{
" Workflow: {{{

" define a fancy nvim clipboard provider
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
function! OpenUrlUnderCursor()
    execute "normal BvEy"
    let url=matchstr(@0, '[a-z]*:\/\/[^ >,;"]*')
    if url != ""
        silent exec "!brave '".url."'" | redraw! 
        echo "opened ".url
    else
        echo "No URL under cursor."
    endif
endfunction
nmap <leader>o :call OpenUrlUnderCursor()<CR>


set nocompatible
filetype off
" Turn on syntax highlighting
syntax on
"  Pick a leader key
" Security
set modelines=1
" Folding
set foldmethod=marker
"set timeoutlen=200 " set amount of time for timeout
set foldlevel=0
set number " Show line number
set relativenumber " Enable 'nybrid' line numbers
set mouse=n " Disable mouse in insert mode
set dictionary+=/usr/share/dict/words "Add  a dictionary
filetype plugin indent on " Turn on indeting
"Make vim more natural
set splitbelow " Split new panes below
set splitright " Vertical split new panes to the right

nmap <space>, :Vimrc<return>
nmap <C-,> :Vimrc<return>
command! Vimrc edit /home/$USER/.config/nvim/init.vim
set backspace=indent,eol,start " Use backspace in insert mode
set pdev=Brother_HL-4570CDW_series " Print from home
set noshowcmd


" Workspace Setup
" ----------------
function! DefaultWorkspace()
    " Rough num columns to decide between laptop and big monitor screens
    let numcol = 2
    if winwidth(0) >= 220
        let numcol = 3
    endif

    if numcol == 3
        e term://zsh
        file Shell\ Two
        vnew
    endif

    vsp term://neofetch
    file Context
    sp term://zsh
    file Shell\ One
    resize 60
endfunction
command! -register DefaultWorkspace call DefaultWorkspace()
"" }}}
" Whitespace:{{{
set wrap " Wrap lines
set linebreak " Wraps lines a words
set breakindent " Consistent indent of wrapped linex
" set textwidth=100 " Wrap at 100 chars
set expandtab " Use spaces instead of tab
set softtabstop=2 " Number of spaces per tab
set shiftwidth=2   " Number of auto indent spaces
set autoindent " Auto indent
set noshiftround " Indent lines by 2 not by nearest mutiple of two
" }}}
" Netrw: {{{

" let g:netrw_liststyle = 3  " Show 'tree' view
" let g:netrw_banner = 0 " Disable annoying banner
" let g:netrw_winsize = 15 " 15 pecent of screen size
" let g:netrw_altv = 1 " Auto cd
" let g:netrw_preview= 1 " open previews vertically
" let g:netrw_browse_split = 4 " Open in last used buffer

" " Toggle Vexplore with leader-t
" function! ToggleVExplorer()
"   if exists("t:expl_buf_num")
"     let expl_win_num = bufwinnr(t:expl_buf_num)
"     if expl_win_num != -1
"       let cur_win_nr = winnr()
"       exec expl_win_num . 'wincmd w'
"       bd
"       " exec cur_win_nr . 'wincmd w'
"       unlet t:expl_buf_num
"     else
"       unlet t:expl_buf_num
"     endif
"   else
"     exec '1wincmd w'
"     Vexplore
"     let t:expl_buf_num = bufnr("%")
"   endif
" endfunction

" map <silent> <leader>t :call ToggleVExplorer()<CR>

" " Dir setup
" " set autochdir

" " Follow symlinks
" function! FollowSymlink()
"   let current_file = expand('%:p')
"   " Check for symlink
"   if getftype(current_file) == 'link'
"     " Open actual filepath
"     let actual_file = resolve(current_file)
"     silent! execute 'file ' . actual_file
"   endif
" endfunction


" function! SetProjectRoot()
"   " default to current
"   lcd %:p:h
"   let my_git_dir = system("git rev-parse --show-toplevel")
"   " Check output
"   let is_not_git_dir = matchstr(my_git_dir, '^fatal:.*')
"   let is_not_dot_git_dir = matchstr(my_git_dir, '\n')

"   if empty(is_not_git_dir)
"     if empty(is_not_dot_git_dir)
"       lcd my_git_dir
"     endif
"   endif
" endfunction

" autocmd BufNewFile *
"       \   call SetProjectRoot()

" autocmd CursorMoved silent *
"       \ if &filetype == 'netrw' |
"       \   call SetProjectRoot() |
"       \ endif

" " }}}
" Performance: {{{
" Different Cursor shape in tmux 
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set hidden " Allow hidden buffers
set ttyfast " Rendering
" }}}
" Searching: {{{
set hlsearch "  Highlight all search results
set incsearch " Searches the string incrementaly
set smartcase " Enable smart case 
set ignorecase " Always case-insensitive
set showmatch " Highlight matching brace
" }}}
" Persistent undo: {{{
"
if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backup files, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.config/nvim/undo') == 0
    :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo// " Set undodir
  set undodir+=~/.config/nvim/undo//
  set undofile " Create undofiles
endif

" Begone swapfiles
set directory^=$HOME/.config/nvim/tmp// " Disable swapfiles
set noswapfile " Begone
" }}}
"Terminal settings: {{{
"
autocmd TermOpen term://* startinsert
autocmd TermOpen term://* setlocal nonumber norelativenumber
" Make esc work
" tnoremap <Esc> <C-\><C-n>

" Window split settings
highlight TermCursor ctermfg=red guifg=red
set splitbelow
set splitright

" Terminal settings
tnoremap <Leader><Esc> <C-\><C-n>

" au BufEnter * if &buftype == 'terminal' | :startinsert | endif

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


" Workspace Setup
" ----------------
function! DefaultWorkspace()
    " Rough num columns to decide between laptop and big monitor screens
    let numcol = 2
    if winwidth(0) >= 220
        let numcol = 3
    endif

    if numcol == 3
        e term://zsh
        file Shell\ Two
        vnew
    endif

    vsp term://zsh
    file Shell\ One
    " wincmd k
    " resize 4
    " wincmd h
endfunction
command! -register DefaultWorkspace call DefaultWorkspace()

"}}}
" }}}
" Colors {{{
" Fix colors in tmux
if !has('gui_running')
  " Font
  set guifont ="Knack Nerd Font"
  " Colors
  set termguicolors
  set t_Co=256
  " let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  " let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  " let &t_ZH="\e[3m"
  " let &t_ZR="\e[23m"
  let g:deus_termcolors=256
  let NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

set background=dark    " Setting dark mode
let g:deus_italics = 1
"set background=light    " Setting light mode
set fillchars+=vert:\ 
colorscheme deus

if has("gui_running")
  set guifont ="DejaVuSansMono Nerd Font Complete Mono:h11"
endif

" }}}
"Mappings {{{
"
" Open docs
" nnoremap <silent> K :call ZealDoc()<CR>
imap jj <Esc>
function! ZealDoc()
  echo 'Opening Zeal...'
  if expand('%:e') == 'js'
    execute "silent !zeal \"nodejs: " . expand('<cword>') . "\" > /dev/null \n\n"
  elseif expand('%:e') == 'cs'
    execute "silent !zeal \"unity3d: " . expand('<cword>') . "\" > /dev/null \n\n"
  else
    execute "silent !zeal \"" . &filetype . ": " . expand('<cword>') . "\" > /dev/null \n\n"
  endif
endfunction

"Better Focus
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Don't lose selection when shifting sidewards
xnoremap <  <gv
xnoremap >  >gv

" Switching Buffers
noremap <leader>[ :bp<return>
noremap <leader>] :bn<return>

"Find and replace
map <leader>fr :%s///g<left><left>
map <leader>frl :s///g<left><left>
map <silent><leader><space> :let @/=''<cr> " clear search

" Move up/down editor lines
nnoremap <silent> j gj
nnoremap <silent> k gk

"Goyo
nnoremap <silent><leader>z :GoyoStart<return>

" Disable ex-mode 
nnoremap Q <nop> 


" }}}
" Autocommands: {{{
augroup prose
  autocmd!
  autocmd FileType markdown set spell
augroup end
" }}}
" Workflow: {{{
" }}}
" Gui:: {{{
let s:fontsize = 12
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "GuiFont! Fira Code:h" . s:fontsize
endfunction

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a
" }}}
" }}}
"
