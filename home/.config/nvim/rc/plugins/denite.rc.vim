"---------------------------------------------------------------------------
" denite.nvim
"

call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('normal', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('normal', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

call denite#custom#source('file/old', 'matchers',
      \ ['matcher_fuzzy', 'matcher_project_files'])

if has('nvim')
  call denite#custom#source('file/rec,grep', 'matchers',
        \ ['matcher_cpsm'])
endif

call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ ['.git/', '*.min.*'])

call denite#custom#source('file/old', 'converters',
      \ ['converter_relative_word'])

call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#option('default', {
      \ 'auto_accel': v:true,
      \ 'prompt': '>'
      \ })

if executable('rg')
  call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--glob', '!.git/*'])

  call denite#custom#var('grep', 'command', ['rg'])
  call denite#custom#var('grep', 'default_opts',
        \ ['--vimgrep', '--no-heading', '--smart-case', '--hidden', '--glob', '!.git/*'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
  call denite#custom#var('grep', 'final_opts', [])
elseif executable('ag')
  call denite#custom#var('file/rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'default_opts',
        \  ['--vimgrep', '--follow', '--nocolor', '--nogroup',
        \ '--smart-case', '--hidden'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'final_opts', [])
endif


" vim: foldmethod=marker fileencoding=utf-8
