typeset -U path
path+=(
    "/bin"
    "/usr/bin"
    "/usr/local/bin"
    "$DOTFILES_DIR/bin"
    "$HOME/bin"
    "$HOME/.local/bin"
    "/sbin"
    "/usr/sbin"
    "/usr/local/sbin"
    "/Applications/Postgres.app/Contents/Versions/9.4/bin"
    "$HOME/google-cloud-sdk/bin"
    "/Users/tomas/.local/bin"
    "$GOPATH/bin"
)
if is-executable brew; then
    path+=(
        "$(brew --prefix zsh-completions)"
    )
fi
export PATH
