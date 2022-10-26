source ~/.zsh/zplug

source ~/.zsh/env

source ~/.zsh/path

source ~/.zsh/functions

source ~/.zsh/aliases

# source /usr/local/bin/virtualenvwrapper.sh

if is-executable starship; then
    eval "$(starship init zsh)"
fi

if is-executable fasd; then
    eval "$(fasd --init auto)"
fi

if is-executable asdf; then
    . "$(brew --prefix asdf)/libexec/asdf.sh"
fi

# Don't beep when auto-completing
unsetopt LIST_BEEP

# Enable interactive comments (# on the command line)
setopt interactivecomments

# ZSH history
setopt append_history         # Allow multiple terminal sessions to all append to one zsh command history
setopt inc_append_history     # Add comamnds as they are typed, don't wait until shell exit
setopt extended_history       # save timestamp of command and duration
setopt hist_lex_words         # better word splitting, but more CPU heavy
setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups       # do not write events to history that are duplicates of previous events
setopt hist_ignore_all_dups   # delete old recorded entry if new entry is a duplicate.
setopt hist_ignore_space      # remove command line from history list when first character on the line is a space
setopt hist_find_no_dups      # when searching history don't display results already cycled through twice
setopt hist_reduce_blanks     # remove extra blanks from each command line being added to history
setopt hist_verify            # don't execute, just expand history
setopt share_history          # imports new commands and appends typed commands to history

# Bind UP and DOWN arrow keys for subsstring search.
if zplug check zsh-users/zsh-history-substring-search; then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  # zmodload zsh/terminfo
  # bindkey "$terminfo[cuu1]" history-substring-search-up
  # bindkey "$terminfo[cud1]" history-substring-search-down
fi


if zplug check zsh-users/zsh-autosuggestions; then
  # Add history-substring-search-* widgets to list of widgets that clear the autosuggestion
  ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
  # Remove *-line-or-history widgets from list of widgets that clear the autosuggestion to avoid conflict with history-substring-search-* widgets
  ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
fi

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# for triggering zsh-autoenv on new iTerm2 panes
if [[ -a .autoenv.zsh ]]; then
  cd .
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if is-executable rbenv; then
  eval "$(rbenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then
  . '~/google-cloud-sdk/path.zsh.inc';
fi

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then
  . '~/google-cloud-sdk/completion.zsh.inc';
fi

if is-executable kubectl; then
  source <(kubectl completion zsh)
fi

if is-executable gh; then
  source <(gh completion --shell zsh)
fi

source ~/.config/broot/launcher/bash/br

eval "$(direnv hook zsh)"
