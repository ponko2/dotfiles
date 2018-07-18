"---------------------------------------------------------------------------
" denite.nvim
"

call denite#custom#source('file/old', 'matchers',
      \ ['matcher/fuzzy', 'matcher/project_files'])

if has('nvim')
  call denite#custom#source('file/rec,grep', 'matchers',
        \ ['matcher/cpsm'])
endif

call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
      \ ['.git/', '*.min.*'])

call denite#custom#source('file/old', 'converters',
      \ ['converter/relative_word'])

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


"---------------------------------------------------------------------------
" Plugin key-mappings:

" Move line
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('normal', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('normal', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

" Emacs-like key mappings
call denite#custom#map('insert', '<BS>', '<denite:smart_delete_char_before_caret>', 'noremap')
call denite#custom#map('insert', '<C-a>', '<denite:move_caret_to_head>', 'noremap')
call denite#custom#map('insert', '<C-b>', '<denite:move_caret_to_left>', 'noremap')
call denite#custom#map('insert', '<C-d>', '<denite:delete_char_after_caret>', 'noremap')
call denite#custom#map('insert', '<C-e>', '<denite:move_caret_to_tail>', 'noremap')
call denite#custom#map('insert', '<C-f>', '<denite:move_caret_to_right>', 'noremap')
call denite#custom#map('insert', '<C-g>', '<denite:quit>', 'noremap')
call denite#custom#map('insert', '<C-h>', '<denite:smart_delete_char_before_caret>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:delete_text_after_caret>', 'noremap')
call denite#custom#map('insert', '<C-y>', '<denite:paste_from_default_register>', 'noremap')


" vim: fileencoding=utf-8
