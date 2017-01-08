#!/bin/sh

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first

[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Create required dirs

[ -d $HOME/.cider ] || mkdir $HOME/.cider

[ -d $HOME/.cache ] || mkdir $HOME/.cache
[ -d $HOME/.cache/pip ] || mkdir $HOME/.cache/pip
[ -d $HOME/.cache/pip/wheelhouse ] || mkdir $HOME/.cache/pip/wheelhouse

# Bunch of symlinks

ln -sfv "$DOTFILES_DIR/runcom/.bash_profile" $HOME
ln -sfv "$DOTFILES_DIR/runcom/.zlogin" $HOME
ln -sfv "$DOTFILES_DIR/runcom/.zshrc" $HOME
[ -n "$ZSH_VERSION" ] && ln -sfv "$DOTFILES_DIR/system/.function" $HOME/.zshenv
ln -sfv "$DOTFILES_DIR/runcom/.common" $HOME
ln -sfv "$DOTFILES_DIR/runcom/.inputrc" $HOME
ln -sfv "$DOTFILES_DIR/git/.gitconfig" $HOME
ln -sfv "$DOTFILES_DIR/git/.gitignore_global" $HOME
ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" $HOME
ln -sfv "$DOTFILES_DIR/etc/cider/bootstrap.yaml" $HOME/.cider/bootstrap.yaml
ln -sfv "$DOTFILES_DIR/etc/editorconfig/.editorconfig" $HOME

if [ "$(uname)" '==' "Darwin" -a -f "$DOTFILES_DIR/install/osx.sh" ]; then
    source "$DOTFILES_DIR/install/osx.sh"
fi
