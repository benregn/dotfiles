# Start with system path
# Retrieve it from getconf, otherwise it's just current $PATH

is-executable getconf && PATH=$(command -v getconf PATH)

# Prepend new items to path (if directory exists)

prepend() {
    [ -d $1 ] && PATH="$1:${PATH}"
}

prepend "/bin"
prepend "/usr/bin"
prepend "/usr/local/bin"
prepend "$DOTFILES_DIR/bin"
prepend "$HOME/bin"
prepend "$HOME/.local/bin"
prepend "/sbin"
prepend "/usr/sbin"
prepend "/usr/local/sbin"
prepend "$GOPATH/bin"

# Remove duplicates (preserving prepended items)
# Source: http://unix.stackexchange.com/a/40755

PATH=`echo -n $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}'`

# Wrap up

unset prepend
export PATH
