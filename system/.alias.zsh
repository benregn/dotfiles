# get autocomplete for aliases
compdef g=git

# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh
alias gs='git status'
compdef _git gst=git-status
