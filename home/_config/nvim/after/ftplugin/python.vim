scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

setlocal foldmethod=indent
setlocal nofoldenable

setlocal smarttab
setlocal expandtab
setlocal nosmartindent

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

let &cpo = s:save_cpo
