# rename
autoload -Uz zmv

# 8bit Japanese File support
setopt print_eightbit

# OSX濁点半濁点
setopt combining_chars

convert-utf8-mac () {
  BUFFER=`iconv -f utf8 -t utf8-mac <(<<<"$BUFFER")`
  zle -M 'Convert to UTF8-MAC'
}

zle -N convert-utf8-mac

bindkey '^X"' convert-utf8-mac

# Ctrl+D -> use exit or logout
setopt ignore_eof

# Ctrl+S/Ctrl+Q No flow control
setopt no_flow_control

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# for, repeat, select, if, function support
setopt short_loops

# CTRL-s
if [ "$TERM" != "dumb" ]; then
  stty -ixon;
fi

case "${OSTYPE}" in
  darwin*)
    ## pager
    export PAGER="less"
    export LESS="-R"
    export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh  %s'
    ;;
esac
