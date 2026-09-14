source ~/.zsh/zplug

source ~/.zsh/env

source ~/.zsh/path

source ~/.zsh/functions

source ~/.zsh/aliases

fpath=("$HOME/.zsh/completions" $fpath)

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

if command -v fasd >/dev/null 2>&1; then
    eval "$(fasd --init auto)"
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


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

if command -v gh >/dev/null 2>&1; then
  source <(gh completion --shell zsh)
fi

eval "$(direnv hook zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

#compdef gt
###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: gt completion >> ~/.zshrc
#    or gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###

source /Users/tomas/projects/_clones/fzf-docker/docker-fzf

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# One-time-per-shell notification if op was updated
autoload -Uz add-zsh-hook

_opcomp_hint_once() {
  add-zsh-hook -d precmd _opcomp_hint_once
  if opcomp-check; then
    echo "op (1password-cli) updated\n refresh completions: opcomp-update"
  fi
}

add-zsh-hook precmd _opcomp_hint_once

# Added by git-ai installer on Wed May  6 09:44:16 CEST 2026
export PATH="/Users/tomas/.git-ai/bin:$PATH"

eval "$(zoxide init zsh)"

# pnpm
export PNPM_HOME="/Users/tomas/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

# kimi-code
export PATH="/Users/tomas/.kimi-code/bin:$PATH"

# mise - curl https://mise.jdx.dev/install.sh | sh
eval "$(mise activate zsh)"
