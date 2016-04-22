" My filetype file.

if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  " Markdown
  autocmd BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md
        \ setfiletype markdown
augroup END
