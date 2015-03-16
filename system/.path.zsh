typeset -U path
path+=(
    "/bin"
    "/usr/bin"
    "/usr/local/bin"
    "$DOTFILES_DIR/bin"
    "$HOME/bin"
    "/sbin"
    "/usr/sbin"
    "/usr/local/sbin"
)
if is-executable brew; then
    path+=(
        "$(brew --prefix zsh-completions)"
    )
fi
export PATH
