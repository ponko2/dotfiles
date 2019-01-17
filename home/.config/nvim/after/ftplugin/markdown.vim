let s:save_cpo = &cpo
set cpo&vim

setlocal smarttab
setlocal expandtab

setlocal tabstop=3
setlocal softtabstop=3
setlocal shiftwidth=3

let &cpo = s:save_cpo
