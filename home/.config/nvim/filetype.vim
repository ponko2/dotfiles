" My filetype file.

if exists('did_load_filetypes')
  finish
endif

augroup filetypedetect
  " Markdown
  autocmd BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md
        \ setfiletype markdown

  " Vue components
  autocmd BufNewFile,BufRead *.vue
        \ setfiletype html
augroup END
