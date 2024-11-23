scriptencoding utf-8

"---------------------------------------------------------------------------
" vimrc functions:
"

function! vimrc#source_rc(path, ...) abort
  let l:abspath = resolve(expand('$XDG_CONFIG_HOME/nvim/rc/' .. a:path))
  execute 'source' fnameescape(l:abspath)
endfunction
