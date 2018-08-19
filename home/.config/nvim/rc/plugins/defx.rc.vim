scriptencoding utf-8

"---------------------------------------------------------------------------
" defx.nvim
"

autocmd MyAutoCmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  set timeout timeoutlen=0
  autocmd MyAutoCmd BufEnter <buffer> set timeout timeoutlen=0
  autocmd MyAutoCmd BufLeave <buffer> set notimeout timeoutlen&

  " Define mappings
  nnoremap <silent><buffer><expr> <CR> defx#do_action('open')
  nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N defx#do_action('new_file')
  nnoremap <silent><buffer><expr> d defx#do_action('remove')
  nnoremap <silent><buffer><expr> r defx#do_action('rename')
  nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> l defx#do_action('open')
  nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
endfunction
