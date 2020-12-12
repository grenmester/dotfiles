#!/usr/bin/env zsh

############################################################################
#### Plugins

if [[ -f $HOME/.zinit/bin/zinit.zsh ]]; then
  source $HOME/.zinit/bin/zinit.zsh
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit

  zinit light-mode lucid wait for \
    atload"zicompinit; zicdreplay" blockf zsh-users/zsh-completions \
    zdharma/history-search-multi-word \
    zsh-users/zsh-syntax-highlighting

  zstyle ":history-search-multi-word" highlight-color "fg=black,bg=yellow"
fi

############################################################################
#### Aliases

if (( $+commands[nvim] )); then
  alias v="nvim"
elif (( $+commands[vim] )); then
  alias v="vim"
elif (( $+commands[vi] )); then
  alias v="vi"
fi

if (( $+commands[emacs] )); then
  alias e="emacs -nw"
  alias ew="emacs"
fi

if (( $+commands[tmux] )); then
  alias t="tmux"
fi

if (( $+commands[hub] )); then
  alias g="hub"
elif (( $+commands[git] )); then
  alias g="git"
fi

if (( $+commands[exa] )); then
  local ignore_list=".git|node_modules"

  l() {
    emulate -LR zsh
    exa --long --classify --color=always --color-scale --all --ignore-glob="${ignore_list}" --header --git "$@"
  }

  li() {
    emulate -LR zsh
    l --ignore-glob="${ignore_list}|$1" "${@:2}"
  }

  lg() {
    emulate -LR zsh
    l --grid "$@"
  }

  lgi() {
    emulate -LR zsh
    lg --ignore-glob="${ignore_list}|$1" "${@:2}"
  }

  lt() {
    emulate -LR zsh
    l --tree "$@"
  }

  lti() {
    emulate -LR zsh
    lt --ignore-glob="${ignore_list}|$1" "${@:2}"
  }

  ltl() {
    emulate -LR zsh
    lt --level="$@"
  }

  ltli() {
    emulate -LR zsh
    ltl "$1" --ignore-glob="${ignore_list}|$2" "${@:3}"
  }
else
  alias l="ls -AFGl"
fi

alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
alias -g ......="../../../../.."
alias -g .......="../../../../../.."
alias -g ........="../../../../../../.."
alias -g .........="../../../../../../../.."
alias -g ..........="../../../../../../../../.."

# Shows the last 10 visited directories
alias ds="dirs -v | head -10"

################################################################################
#### Completion

# Use interactive menu for ambiguous completions
zstyle ":completion:*" menu select

# Use S-Tab to go backward in the completion menu
bindkey "^[[Z" reverse-menu-complete

# Don't tab complete certain filetypes [1]
zstyle ":completion:*:*:(emacs|gvim|nvim|vim):*" file-patterns \
  "^*.(aux|dvi|fdb_latexmk|fls|log|pdf|synctex.gz|xdv):source-files"

# Support substring completion [2]
zstyle ":completion:*" matcher-list "" \
  "m:{a-z\-}={A-Z\_}" \
  "r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}" \
  "r:|?=** m:{a-z\-}={A-Z\_}"

############################################################################
#### Editor

# Allow editting commands in zle with emacs operations
bindkey -e

# Set default editor
if (( $+commands[nvim] )); then
  export EDITOR="nvim"
elif (( $+commands[vim] )); then
  export EDITOR="vim"
elif (( $+commands[vi] )); then
  export EDITOR="vi"
fi
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

############################################################################
#### Glob

# Make globs case-insensitive
unsetopt case_glob

# Make globbing regexes case-insensitive
unsetopt case_match

# Allow globs to match dotfiles
setopt glob_dots

# Sort numeric filenames numerically instead of lexicographically
setopt numeric_glob_sort

############################################################################
#### History

# History file location
export HISTFILE=~/.zsh_history

# Remove the specified commands from the history
export HISTIGNORE="l:ls:[bf]g:exit:reset:clear:htop"

# Number of lines saved in a session
export HISTSIZE=25000

# Number of lines saved in the history file
export SAVEHIST=10000

# Use OS-provided locking mechanisms for the history file if available to possibly improve performance and decrease the chance of corruption
setopt hist_fcntl_lock

# Prevent the current line from being saved in the history if it is the same as the previous one
setopt hist_ignore_dups

# Remove superfluous blanks from the history
setopt hist_reduce_blanks

# Expand command instead of immediately executing it when using history expansion
setopt hist_verify

# Incrementally append new history lines to history file rather than waiting until the shell exits
setopt inc_append_history

# Disable sharing history between different zsh sessions
unsetopt share_history

############################################################################
#### Man

# Colored man pages
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;32m") \
    LESS_TERMCAP_md=$(printf "\e[1;34m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[30;48;5;244m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[4;33m") \
    man "$@"
}

############################################################################
#### Miscellaneous

# Use commas in ls, du, df file size output
export BLOCK_SIZE="'1"

# Colored output on macOS
export CLICOLOR=1

# Print command execution time if command takes longer than 10 seconds
export REPORTTIME=10

# Background processes aren't killed on exit of shell
setopt auto_continue

# Enter directory path to automatically cd into the directory
setopt autocd

# Make cd push the old directory onto the directory stack
setopt autopushd

# Attempt to correct spelling of commands in a line
setopt correct

# Don't attempt to correct spelling of all arguments in a line
unsetopt correctall

# Allow comments in the interactive shell
setopt interactive_comments

# Don’t overwrite existing files with '>' but uses '>!' instead
setopt noclobber

# Swap the meaning of '-' and '+' when used as arguments to cd so '-' means reading from the top of the stack when accessing an entry from the directory stack
setopt pushdminus

# Prompt for confirmation after 'rm *'-ish commands to avoid accidentally wiping out directories
setopt rm_star_wait

############################################################################
#### Prompt

# Enable parameter expansion and other substitutions in prompt sequences
setopt prompt_subst

prompt_git_info() {
  emulate -LR zsh
  # Branch info
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || \
    return 0
  # Dirty info
  local dirty
  if [[ -n $(command git status --porcelain 2> /dev/null | tail -n1) ]]; then
    dirty="%F{red}✗"
  else
    dirty="%F{green}✓"
  fi
  # Remote info
  local remote
  if $(echo "$(command git log @{upstream}..HEAD 2> /dev/null)" | grep "^commit" &> /dev/null); then
    remote="%F{yellow}+"
  fi
  echo "(${ref#refs/heads/}) ${dirty}${remote} "
}

PROMPT='%B%F{blue}%~ %F{yellow}$(prompt_git_info)%F{default}$ %f%b'
RPROMPT='%B%F{cyan}%n%F{default}@%F{magenta}%m %(?.%F{green}.%F{red})[%?]%f%b'

# [1]: https://www.reddit.com/r/zsh/comments/5ghouo/is_there_a_way_to_have_zsh_ignore_certain_file
# [2]: https://superuser.com/questions/415650/does-a-fuzzy-matching-mode-exist-for-the-zsh-shell
