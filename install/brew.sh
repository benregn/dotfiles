#!/bin/sh

# Update Homebrew, formulae, and packages

brew update
brew upgrade

# Install GNU packages (and override OSX version)

bash-completion
zsh-completions
coreutils
dockutil
git
gnu-sed --default-names
grep --default-names
hub
jq
mackup
node
peco
phantomjs
python
ssh-copy-id
svn
tree
vim
wget
