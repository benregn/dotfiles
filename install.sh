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

[ -d $HOME/.git-templates ] || mkdir $HOME/.git-templates
[ -d $HOME/.git-templates/hooks ] || mkdir $HOME/.git-templates/hooks

# Bunch of symlinks

ln -sfv "$DOTFILES_DIR/runcom/.bash_profile" $HOME
ln -sfv "$DOTFILES_DIR/runcom/.zlogin" $HOME
ln -sfv "$DOTFILES_DIR/runcom/.zshrc" $HOME
[ -n "$ZSH_VERSION" ] && ln -sfv "$DOTFILES_DIR/system/.function" $HOME/.zshenv
ln -sfv "$DOTFILES_DIR/runcom/.common" $HOME
ln -sfv "$DOTFILES_DIR/runcom/.inputrc" $HOME
ln -sfv "$DOTFILES_DIR/git/.gitconfig" $HOME
ln -sfv "$DOTFILES_DIR/git/.gitignore_global" $HOME
ln -sfv "$DOTFILES_DIR/git/.git_commit_msg.txt" $HOME
ln -sfv "$DOTFILES_DIR/git/.git-alias-email-guess.sh" $HOME/.git-alias-email-guess.sh
ln -sfv "$DOTFILES_DIR/git/hooks/post-checkout" $HOME/.git-templates/hooks/post-checkout
ln -sfv "$DOTFILES_DIR/git/hooks/prepare-commit-msg" $HOME/.git-templates/hooks/prepare-commit-msg
ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" $HOME
ln -sfv "$DOTFILES_DIR/etc/cider/bootstrap.yaml" $HOME/.cider/bootstrap.yaml
ln -sfv "$DOTFILES_DIR/etc/editorconfig/.editorconfig" $HOME

if [ "$(uname)" '==' "Darwin" -a -f "$DOTFILES_DIR/install/osx.sh" ]; then
    source "$DOTFILES_DIR/install/osx.sh"
fi
