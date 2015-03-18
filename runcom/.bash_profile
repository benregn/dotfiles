# Common checks etc.
source $HOME/.common

for DOTFILE in "$DOTFILES_DIR"/system/.*.bash; do
  [ -f "$DOTFILE" ] && source "$DOTFILE"
done

source "$DOTFILES_DIR"/git/.git-completion.bash

# Clean up

unset DOTFILE
