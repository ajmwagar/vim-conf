# vim-conf
📓 My (neo)vim files...

## Plugins
- `coc.nvim`: LSP integration and autocomplete
- [`vim-deus`](https://github.com/ajmwagar/vim-deus): my custom colorscheme
- `ALE`: Async. Linting Engine
- `lightline`: A nice looking statusline and bufferline
- `vim-polyglot`: The best syntax pack in the west
- `vim-fugitive`: Git integration
- `ack` and `fzf` + `ripgrep` = Very fast fuzzy searching

## Installation

### Neovim
1. `git clone https://github.com/ajmwagar/vim-conf.git ~/.config/nvim`
2. `nvim`
3. `:PackUpdate`
### Vim 8
1. `git clone https://github.com/ajmwagar/vim-conf.git ~/.vim`
2. `mv ~/.vim/init.vim ~/.vimrc`
3. `vim`
4. `:PackUpdate`

## Lisp

`lua/ajmwagar/lisp.lua` wires up syntax (bundled `lisp` syntax, plus the
tree-sitter `commonlisp` parser when it is installed) and a small REPL/runner
with no plugin dependencies. It probes `sbcl`, `clisp`, `ecl`, `ccl`, `ros`,
`guile`, `racket`, `csi` and `gosh`, and picks the one matching the buffer's
filetype.

```
:Lisp              toggle the REPL
:Lisp repl [impl]  open the REPL (force an implementation, e.g. `:Lisp repl ecl`)
:Lisp eval         send the enclosing top-level form, or the visual range
:Lisp buffer       load the current file into the REPL
:Lisp run [file]   run the file as a script, output in a scratch split
:Lisp stop         kill the REPL
:Lisp info         show detected/installed implementations
```

Buffer-local maps in `lisp`, `scheme`, `racket` files: `<leader>lr` REPL,
`<leader>le` eval form/selection, `<leader>lb` load buffer, `<leader>lf` run
file, `<leader>ls` stop REPL.

Run `:Lisp info` if it cannot find an implementation; on macOS the quickest
fix is `brew install sbcl`.
