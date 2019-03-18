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
" source ~/.config/nvim/config/plugins.vim " Handle Plugins with minpac
" Import Plugins: {{{
if exists('*minpac#init')
  call minpac#init()

  " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  " Fast plugin manager

  function! DoRemote()
    UpdateRemotePlugins
  endfunction

  " Workflow plugins
  " call minpac#add('posva/vim-vue') " vue syntax
  call minpac#add('sheerun/vim-polyglot') " Syntax files for most languages
  call minpac#add('jiangmiao/auto-pairs') " Auto close brackets and ''
  call minpac#add('tpope/vim-commentary') " Toggle comments with ease
  " call minpac#add('ConradIrwin/vim-bracketed-paste') " Paste better into vim from terminal

  " Searching/Fuzzy Finding
  call minpac#add('junegunn/fzf', { 'do': './install --all' }) | call minpac#add('junegunn/fzf.vim') " FZF <3's Vim
  call minpac#add('mileszs/ack.vim') " Search me, baby

  " Autocomplete
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('neoclide/coc.nvim', {'do': coc#util#install()}) " Conquereer of Completions 
  call minpac#add('w0rp/ale') " ALE
  call minpac#add('KabbAmine/zeavim.vim') " ZealDoc Support
  " Prose mode plugins
  " call minpac#add('ujihisa/neco-look', {'for': ['md', 'txt', 'markdown']})
  " call minpac#add('davinche/godown-vim', {'type': 'opt'})
  " call minpac#add('junegunn/goyo.vim', {'type': 'opt'})
  " call minpac#add('junegunn/limelight.vim', {'type': 'opt'})
  " call minpac#add('reedes/vim-pencil')

  " Editor plugins/UI
  call minpac#add('ajmwagar/vim-deus') " Colorsheme
  call minpac#add('ajmwagar/lightline-deus')
  " call minpac#add('taohexxx/lightline-buffer')
  call minpac#add('ap/vim-buftabline')
  call minpac#add('itchyny/lightline.vim') " Status bar

endif
" }}}
" Plugin Config: {{{
" COC {{{

let g:coc_force_debug = 1
"Better display for messages
set cmdheight=1
set noshowmode
set noruler
set noshowcmd

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
" set signcolumn=yes

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
nmap <silent> gy <Plug>(coc-type-definition)
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

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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
" fuzzy finder/ack Settings {{{
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
      \   'left': [ [ 'bufferline' ]],
      \   'right': [],
      \ },
      \ 'component_expand': {
      \   'linter_warnings': 'LightlineLinterWarnings',
      \   'linter_errors': 'LightlineLinterErrors',
      \   'linter_ok': 'LightlineLinterOK',
      \   'bufferline': 'LightlineBufferline'
      \ },
      \ 'component_type': {
      \   'readonly': 'error',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'bufferline': 'tabsel',
      \ },
      \ 'component_function': {
      \   'time': 'Timer',
      \   'gitbranch': 'MyGit',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \   'cocstatus': 'coc#status'
      \ },
      \ 'component': {
      \   'separator': ''
      \ },
      \ 'active': {
      \   'left': [['mode', 'paste'], ['cocstatus','gitbranch', 'filetype', 'modified']],
      \   'right': [['time'], ['lineinfo'],  ['percent']]
      \ }
      \ }


function! LightlineBufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after]
endfunction

function! Timer()
  " return strftime("%H:%S")
  return strftime("%H:%M") . " PST" "Timer in status line
  " return !date
endfunction

function! MyGit()
  if (fugitive#head() != '')
    return fugitive#head() " 
  endif
  return ''
endfunction

function! MyFiletype()
  if expand('%:t') != ''
    return expand('%:t') . " "  " .  WebDevIconsGetFileTypeSymbol()
  else
    return ''
  endif
  " return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol()  ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' )  " . WebDevIconsGetFileFormatSymbol()) : ''
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
"" Workflow: {{{
set nocompatible
filetype off
" Turn on syntax highlighting
syntax on
"  Pick a leader key
" Security
set modelines=1
" Folding
set foldmethod=marker
set foldlevel=0
set number " Show line number
set relativenumber " Enable 'nybrid' line numbers
set mouse=n " Disable mouse in insert mode
set dictionary+=/usr/share/dict/words "Add  a dictionary
filetype plugin indent on " Turn on indeting
"Make vim more natural
set splitbelow " Split new panes below
set splitright " Vertical split new panes to the right
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
" " Netrw: {{{

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
" Workflow: {{{
set backspace=indent,eol,start " Use backspace in insert mode
set pdev=Brother_HL-4570CDW_series " Print from home
set noshowcmd
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
tnoremap <Esc> <C-\><C-n>:bd!<CR>
" :bd!<CR>
"Better Focus
" tnoremap <C-h> <C-\><C-N><C-w>h
" tnoremap <C-j> <C-\><C-N><C-w>j
" tnoremap <C-k> <C-\><C-N><C-w>k
" tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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
