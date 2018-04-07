"---------------------------------------------------------------------------
" vimfiler.vim
"

let g:vimfiler_enable_clipboard = 0

call vimfiler#custom#profile('default', 'context', {
      \   'safe' : 0,
      \   'auto_expand' : 1,
      \   'parent' : 0,
      \ })

let g:vimfiler_as_default_explorer = 1

if IsWindows()
  let g:vimfiler_detect_drives = [
        \ 'C:/', 'D:/', 'E:/', 'F:/', 'G:/', 'H:/',
        \ 'I:/', 'J:/', 'K:/', 'L:/', 'M:/', 'N:/']

  " Use trashbox.
  let g:unite_kind_file_use_trashbox = 1
endif


" vim: fileencoding=utf-8
