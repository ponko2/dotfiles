let s:save_cpo = &cpo
set cpo&vim

setlocal smarttab
setlocal expandtab

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

let &cpo = s:save_cpo
