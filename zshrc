source ~/.zsh/zplug

source ~/.zsh/env

source ~/.zsh/functions

source ~/.zsh/aliases

source /usr/local/bin/virtualenvwrapper.sh

if is-executable fasd; then
    eval "$(fasd --init auto)"
fi

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

export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# for triggering zsh-autoenv on new iTerm2 panes
if [[ -a .autoenv.zsh ]]; then
  cd .
fi