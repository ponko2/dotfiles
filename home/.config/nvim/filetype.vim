scriptencoding utf-8

" My filetype file.

if exists('did_load_filetypes')
  finish
endif

augroup filetypedetect
  " Markdown
  autocmd BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md
        \ setfiletype markdown

  " mustache
  autocmd BufNewFile,BufRead *.template.html
        \ setfiletype html.mustache
augroup END
