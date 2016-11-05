"---------------------------------------------------------------------------
" unite.vim
"

let g:unite_enable_auto_select = 0
let g:unite_ignore_source_files = []
let g:unite_source_rec_max_cache_files = -1

call unite#custom#profile('default', 'context', {
      \   'vertical': 0,
      \   'start_insert': 1,
      \   'short_source_names': 1,
      \ })
call unite#custom#profile('action', 'context', {
      \   'start_insert': 1,
      \ })

call unite#custom#source(
      \ 'buffer,file_rec,file_rec/async,file_rec/git', 'matchers',
      \ ['converter_relative_word', 'matcher_fuzzy'])
call unite#custom#source(
      \ 'file_mru', 'matchers',
      \ ['matcher_project_files', 'matcher_fuzzy',
      \  'matcher_hide_hidden_files', 'matcher_hide_current_file'])
call unite#custom#source(
      \ 'file_rec,file_rec/async,file_rec/git,file_mru', 'converters',
      \ ['converter_file_directory'])
call unite#custom#source(
      \ 'buffer', 'converters',
      \ ['converter_uniq_word', 'converter_word_abbr'])

call unite#filters#sorter_default#use(['sorter_rank'])

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--smart-case --vimgrep'
  let g:unite_source_grep_recursive_opt = ''
endif


" vim: foldmethod=marker fileencoding=utf-8
