"---------------------------------------------------------------------------
" denite.nvim
"

call denite#custom#map('insert', '<C-n>', 'move_to_next_line')
call denite#custom#map('insert', '<C-p>', 'move_to_prev_line')

call denite#custom#source('file_mru', 'matchers',
      \ ['matcher_fuzzy', 'matcher_project_files'])
call denite#custom#source('file_rec,grep', 'matchers',
      \ ['matcher_cpsm'])
call denite#custom#source('grep', 'matchers',
      \ ['matcher_ignore_globs', 'matcher_cpsm'])

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ ['.git/', '*.min.*'])

call denite#custom#source('file_mru', 'converters',
      \ ['converter_relative_word'])

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#option('default', 'prompt', '>')

if executable('ag')
  call denite#custom#var('file_rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'separator', [])
  call denite#custom#var('grep', 'default_opts',
        \  ['--follow', '--nocolor', '--nogroup',
        \ '--smart-case', '--vimgrep'])
endif


" vim: foldmethod=marker fileencoding=utf-8
