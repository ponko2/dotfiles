scriptencoding utf-8

"---------------------------------------------------------------------------
" deoplete.nvim
"

call deoplete#custom#option('camel_case', v:true)
call deoplete#custom#option('skip_multibyte', v:true)
call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer', 'tag', 'LanguageClient']})

call deoplete#custom#source('_', 'matchers',
      \ ['matcher_fuzzy', 'matcher_length'])
call deoplete#custom#source('tabnine', 'matchers', [])

call deoplete#custom#source('_', 'converters', [
      \ 'converter_remove_paren',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ 'converter_auto_delimiter',
      \ ])
call deoplete#custom#source('tabnine', 'converters', [
      \ 'converter_remove_overlap',
      \ ])


call deoplete#custom#source('look', 'filetypes', ['text', 'markdown', 'gitcommit'])
call deoplete#custom#source('tabnine', 'rank', 300)

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
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return (pumvisible() ? deoplete#close_popup() : "")."\<CR>"
endfunction

inoremap <expr><C-g> deoplete#undo_completion()
inoremap <expr><C-l> deoplete#refresh()
