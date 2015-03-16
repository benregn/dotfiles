# Common checks etc.
source $HOME/.common

for DOTFILE in "$DOTFILES_DIR"/system/.*.bash; do
  [ -f "$DOTFILE" ] && source "$DOTFILE"
done


# Clean up

unset DOTFILE
