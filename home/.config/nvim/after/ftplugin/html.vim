scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

syntax sync minlines=1000 maxlines=2000

setlocal iskeyword& iskeyword+=-

let &cpo = s:save_cpo
