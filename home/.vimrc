" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('win32') || has('win64')
  set shellslash
  set runtimepath^=$HOME/.vim
  set runtimepath+=$HOME/.vim/after
endif

source $HOME/.vim/vimrc
