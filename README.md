# .files

These are my dotfiles. Take anything you want, but at your own risk.

It targets OS X systems, but since it has some defensive checks it should work on *nix as well (tested on a few Linux boxes).

## Install

On a sparkling fresh installation of OS X:

    sudo softwareupdate -i -a
    xcode-select --install

Install the dotfiles with either Git or curl:

### Clone with Git

    git clone https://github.com/bernegn/dotfiles.git
    source dotfiles/install.sh

### Remotely install using curl

Alternatively, you can install this into `~/.dotfiles` from remote without Git using curl:

    sh -c "`curl -fsSL https://raw.github.com/bernegn/dotfiles/master/remote-install.sh`"

## iTerm2 keybindings

Set alt+left to Send Escape Sequence [1;5C
Set alt+right to Send Escape Sequence [1;5D

## Custom settings

You can put your custom settings, such as Git credentials in the `system/.custom` file which will be sourced from `.bash_profile` automatically. This file is in `.gitignore`.

## Some installed packages

* [dockutil](https://github.com/kcrawford/dockutil)
* [hub](http://hub.github.com/)
* [Mjolnir](https://github.com/sdegutis/mjolnir)
* [jq](http://stedolan.github.io/jq/)
* [lunchy](https://github.com/eddiezane/lunchy)
* [peco](http://peco.github.io/)
* [Quick Look plugins](https://github.com/sindresorhus/quick-look-plugins)
* [spot](https://github.com/guille/spot)
* [tldr](https://github.com/tldr-pages/tldr)
* [vtop](https://github.com/MrRio/vtop)


## Credits

Inspired (and stolen) from [webpro/dotfiles](https://github.com/webpro/dotfiles).

Many thanks to the [dotfiles community](http://dotfiles.github.io/) and the creators of the incredibly useful tools.
