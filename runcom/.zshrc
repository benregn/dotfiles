# Common checks etc.
source $HOME/.common

for DOTFILE in "$DOTFILES_DIR"/system/.{path,completion,alias,env,key-bindings}.zsh; do
    [ -f "$DOTFILE" ] && source "$DOTFILE"
done

# Clean up

unset DOTFILE
