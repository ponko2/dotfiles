scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

setlocal iskeyword& iskeyword+=-

let &cpo = s:save_cpo
