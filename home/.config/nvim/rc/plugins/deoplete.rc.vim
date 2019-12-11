scriptencoding utf-8

"---------------------------------------------------------------------------
" deoplete.nvim
"

call deoplete#custom#option({
      \   'auto_preview': v:true,
      \   'auto_refresh_delay': 10,
      \   'camel_case': v:true,
      \   'ignore_sources': {'_': ['buffer', 'LanguageClient']},
      \   'keyword_patterns': { '_': '[a-zA-Z_]\k*\(?' },
      \   'omni_patterns': { 'go': '[^. *\t]\.\w*' },
      \   'prev_completion_mode': 'length',
      \   'skip_multibyte': v:true,
      \ })

call deoplete#custom#source('_', {
      \   'converters': [
      \     'converter_case',
      \     'converter_remove_overlap',
      \     'converter_truncate_abbr',
      \     'converter_truncate_info',
      \     'converter_truncate_menu',
      \   ],
      \   'matchers': [
      \     'matcher_fuzzy',
      \     'matcher_length',
      \   ],
      \ })

call deoplete#custom#source('tabnine', {
      \   'converters': [
      \     'converter_remove_overlap',
      \     'converter_truncate_info',
      \   ],
      \   'line_limit': 300,
      \   'markers': ['.git/'],
      \   'max_num_results': 5,
      \   'min_pattern_length': 2,
      \   'rank': 300,
      \ })

call deoplete#custom#source('denite', {
      \   'matchers': ['matcher_full_fuzzy', 'matcher_length']
      \ })

call deoplete#custom#filter('attrs_order', {
      \   'javascript': {
      \     'kind': [
      \       'Function',
      \       'Property'
      \     ]
      \   },
      \ })

call deoplete#custom#var('tabnine', {
      \   'line_limit': 500,
      \   'max_num_results': 20,
      \ })

call deoplete#enable()


"---------------------------------------------------------------------------
" Plugin key-mappings:

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1] =~? '\s'
endfunction

" <S-TAB>: completion back.
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return (pumvisible() ? deoplete#close_popup() : '')."\<CR>"
endfunction

inoremap <expr> <C-g> pumvisible() ? deoplete#undo_completion() : "\<C-g>"
inoremap <expr> <C-l> pumvisible() ? deoplete#refresh() : "\<C-l>"
