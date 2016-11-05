let s:save_cpo = &cpo
set cpo&vim

compiler fish

setlocal smarttab
setlocal expandtab
setlocal smartindent

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

let &cpo = s:save_cpo
