let s:save_cpo = &cpo
set cpo&vim

setlocal nosmarttab
setlocal noexpandtab

setlocal tabstop=4
setlocal softtabstop=0
setlocal shiftwidth=4

let &cpo = s:save_cpo
