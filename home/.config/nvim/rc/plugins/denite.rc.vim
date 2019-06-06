"---------------------------------------------------------------------------
" denite.nvim
"

call denite#custom#source('file/old', 'matchers',
      \ ['matcher/fruzzy', 'matcher/project_files'])

call denite#custom#source('file/rec', 'matchers',
      \ ['matcher/fruzzy'])

call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
      \ ['.git/', '*.min.*'])

call denite#custom#source('file/old', 'converters',
      \ ['converter/relative_word'])

call denite#custom#source('buffer', 'matchers',
      \ ['matcher/fuzzy', 'matcher/ignore_current_buffer'])

call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#option('default', {
      \   'highlight_filter_background': 'CursorLine',
      \   'source_names': 'short',
      \   'split': 'floating',
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
