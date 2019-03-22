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
  call minpac#add('sheerun/vim-polyglot') " Syntax files for most languages
  call minpac#add('jiangmiao/auto-pairs') " Auto close brackets and ''
  call minpac#add('tpope/vim-commentary') " Toggle comments with ease

  " Autocomplete
  call minpac#add('autozimu/LanguageClient-neovim', {'do': '!sh ./install.sh', 'branch': 'next' }) " Setup language servers
  call minpac#add('Shougo/deoplete.nvim', {'do': 'call DoRemote()'}) " Autocomplete engine

  " Snippets 
  call minpac#add('SirVer/ultisnips')

  call minpac#add('ajmwagar/vim-deus') " Colorsheme

endif
" }}}
" Plugin Config: {{{
" Completion {{{

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Deoplete
let g:deoplete#enable_at_startup = 1 " Auto start
let g:deoplete#enable_smart_case = 1 " Smart case
let g:deoplete#auto_complete_start_length = 2 " Stop bothering me
let g:deoplete#enable_refresh_always = 0 " Stop the weird sorting redraw
let g:deoplete#max_abbr_width = 0 " Allow for wide menu
let g:deoplete#max_menu_width = 0 " Allow for tall menu

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
let g:deoplete#ignore_sources.java = ['look', 'm']
let g:deoplete#ignore_sources['cs'] = ['look', 'm']
let g:deoplete#ignore_sources['javascript'] = ['look', 'm']
let g:deoplete#ignore_sources['rust'] = ['look', 'm']
let g:deoplete#ignore_sources['python'] = ['look', 'm']
let g:deoplete#ignore_sources['snippets'] = ['look', 'm']
let g:deoplete#ignore_sources['sh'] = ['look', 'm']
let g:deoplete#ignore_sources['go'] = ['look', 'm']
let g:deoplete#ignore_sources['pug'] = ['look', 'm']
let g:deoplete#ignore_sources['css'] = ['look', 'm']
let g:deoplete#ignore_sources['html'] = ['look', 'm']
let g:deoplete#ignore_sources['log'] = ['look', 'm']

set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags
" }}}
" LSP {{{

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Minimal LSP configuration for JavaScript
let g:LanguageClient_serverCommands = {
      \ 'rust': ['rls'],
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'javascript.jsx': ['javascript-typescript-stdio'],
      \ 'csharp': ['node', '/home/ajmwagar/bin/omnisharp-node-client/languageserver/server.js'],
      \ 'cs': ['node', '/home/ajmwagar/bin/omnisharp-node-client/languageserver/server.js'],
      \ 'python': ['pyls'],
      \ 'java': ['jdtls']
      \ }

autocmd FileType javascript setlocal omnifunc=LanguageClient#complete

" Smarter vim features
" Documentation
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" Replaced in mappings.vim

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
autocmd FileType javascript :LanguageClientStart<CR>
autocmd FileType java :LanguageClientStart<CR>
autocmd FileType python :LanguageClientStart<CR>
autocmd FileType rust :LanguageClientStart<CR>


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
" }}}
" Packadd: {{{
" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" Godown packadd
autocmd FileType markdown packadd godown-vim

" Goyo and Limelighy
command! GoyoStart packadd goyo.vim | packadd limelight.vim | Goyo
" }}}
" }}}
" source ~/.config/nvim/config/editor.vim " Colorschemes/indentation
" Functional Config {{{
" Workflow: {{{
" set shortmess=I " Read :help shortmess for everything else.
set nocompatible
filetype off
" Turn on syntax highlighting
syntax on
"  Pick a leader key
let mapleader = ";"
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
" }}}
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

" Dir setup
" set autochdir

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

" }}}
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

command! Sterm :sp | :term
command! Vterm :vs | :term

nnoremap <C-m> :Sterm<CR>
nnoremap <C-n> :Vterm<CR>
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
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"
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
" source ~/.config/nvim/config/mappings.vim " Shortcuts/mappings
"Mappings {{{
"
command! W :w suda://%<CR> " Write in sudo

" Open docs
nnoremap <silent> K :call ZealDoc()<CR>

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

" }}}
