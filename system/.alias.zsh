# get autocomplete for aliases
compdef g=git

# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh
compdef _git gst=git-status

alias reload='source ~/.zshrc && echo "zsh reloaded."'
