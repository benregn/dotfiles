#!/bin/sh

# Install Homebrew & brew-cask

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Install cider to install brew & brew-cask packages
source "$DOTFILES_DIR/install/cider.sh"

# Install bash & zsh

source "$DOTFILES_DIR/install/bash.sh"
source "$DOTFILES_DIR/install/zsh.sh"

# Install mjolnir

source "$DOTFILES_DIR/install/mjolnir.sh"


# Globally install with npm

npm install -g bower
npm install -g grunt
npm install -g gulp
npm install -g spot
npm install -g vtop

# http://www.sublimetext.com/docs/3/osx_command_line.html
[ -f ~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl ] && ln -sfv ~/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl "$DOTFILES_DIR/bin/subl"
