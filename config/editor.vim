" Avery Wagar

" Functional Config {{{
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
"Show line number
set number
set relativenumber

" Whitespace
set wrap " Wrap lines
set linebreak " Wraps lines a words
set breakindent " Consistent indent of wrapped linex
" set textwidth=100 " Wrap at 100 chars
set expandtab " Use spaces instead of tan
set softtabstop=2 " Number of spaces per tab
set shiftwidth=2   " Number of auto indent spaces
set autoindent " Auto indent
set noshiftround " Indent lines by 2 not by nearest mutiple of two

" Printing
set pdev=Brother_HL-4570CDW_series

" Netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 15
let g:netrw_altv = 1
let g:netrw_preview=1           " open previews vertically
let g:netrw_browse_split = 4

" Toggle Vexplore with leader-t
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
    let expl_win_num = bufwinnr(t:expl_buf_num)
    if expl_win_num != -1
      let cur_win_nr = winnr()
      exec expl_win_num . 'wincmd w'
      close
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
  let git_dir = system("git rev-parse --show-toplevel")
  " Check output
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  if empty(is_not_git_dir)
    lcd `=git_dir`
  endif
endfunction

autocmd BufRead *
      \ call FollowSymlink() |
      \ call SetProjectRoot()

autocmd CursorMoved silent *
      \ if &filetype == 'netrw' |
      \   call FollowSymlink() | call SetProjectRoot() |
      \ endif


" Cursor motion
set backspace=indent,eol,start " Use backspace in insert mode

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

" Searching
set hlsearch "  Highlight all search results
set incsearch " Searches the string incrementaly
set smartcase " Enable smart case 
set ignorecase " Always case-insensitive
set showmatch " Highlight matching brace

set dictionary+=/usr/share/dict/words

filetype plugin indent on

"Spell checking for spefic files
autocmd FileType md,markdown,txt, setlocal spell

"Make vim more natural
set splitbelow
set splitright

" Persistent undo
if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backup files, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.config/nvim/undo') == 0
    :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.config/nvim/undo//
  set undofile
endif

" Begone swapfiles
set directory^=$HOME/.config/nvim/tmp//
set noswapfile

"Terminal settings
autocmd TermOpen term://* startinsert
autocmd TermOpen term://* setlocal nonumber norelativenumber
" Make esc work
tnoremap <Esc> <C-\><C-n>:q<CR>
"Better Focus
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

command! Sterm :sp | :term

nnoremap <C-t> :Sterm<CR>



" augroup numbertoggle
"   autocmd!

"   augroup numbertoggle
"     autocmd!
"     autocmd BufEnter,FocusGained,WinEnter * if &nu | set rnu   | endif
"     autocmd BufEnter,FocusGained,WinEnter * if &nu | :SignifyEnable | endif
"     autocmd BufLeave,FocusLost,WinLeave   * if &nu | set nornu | endif
"     autocmd BufLeave,FocusLost,WinLeave   * if &nu | :SignifyDisable | endif
"   augroup END

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
