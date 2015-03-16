# Bash

is-executable brew && [ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion

# Dotfiles

_dotfiles_completions() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W '`dotfiles completion`' -- $cur ) );
}

complete -o default -F _dotfiles_completions dotfiles

# Grunt

is-executable grunt && eval "$(grunt --completion=bash)"

# killall

complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal" killall;

# Homebrew

is-executable brew && [ -f $(brew --prefix)/Library/Contributions/brew_bash_completion.sh ] && . `brew --prefix`/Library/Contributions/brew_bash_completion.sh
