# Common checks etc.
source $HOME/.common

for DOTFILE in "$DOTFILES_DIR"/system/.{path,completion,alias,env,key-bindings}.zsh; do
    [ -f "$DOTFILE" ] && source "$DOTFILE"
done

if is-executable fasd; then
    eval "$(fasd --init auto)"
    alias j='fasd_cd -d'
fi

# Clean up

unset DOTFILE

if is-executable brew; then
    source $(brew --prefix zsh-syntax-highlighting)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source $(brew --prefix zsh-history-substring-search)/zsh-history-substring-search.zsh
fi

# https://github.com/zsh-users/zsh-history-substring-search#configuration
# customize how the query should be highlighted inside a matching command
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=white,bold'
