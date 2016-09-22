function fish_user_key_bindings
    bind \cr    'peco_put_history (commandline -b)'
    bind \cx\cf 'peco_fixup_git_commit'
    bind \cx\cg 'peco_cd_ghq_repository'
    bind \cx\ci 'peco_interactive_git_rebase'
    bind \cx\cr 'peco_execute_history (commandline -b)'
end
