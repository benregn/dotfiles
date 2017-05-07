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

[ -f "$DOTFILES_DIR/lib/zsh-autoenv/autoenv.zsh" ] && source $DOTFILES_DIR/lib/zsh-autoenv/autoenv.zsh

# https://github.com/zsh-users/zsh-history-substring-search#configuration
# customize how the query should be highlighted inside a matching command
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=white,bold'

# for triggering autoenv on new terminal sessions
# from https://github.com/kennethreitz/autoenv/issues/26
cd .

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
