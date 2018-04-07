scriptencoding utf-8

if !IsMac() | finish | endif

"---------------------------------------------------------------------------
" macOS:
"

" MacVim
if has('gui_running')
  let g:macvim_skip_colorscheme = 1
  let g:macvim_skip_cmd_opt_movement = 1
  let g:macvim_hig_shift_movement = 0

  " Vimを透けさせる
  set transparency=5
endif

if exists('+macmeta')
  " MacVimでMETAキーを使えるようにする
  set macmeta
endif


" vim: fileencoding=utf-8
