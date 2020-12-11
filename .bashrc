#!/usr/bin/env bash

############################################################################
#### Aliases

if command -v nvim &>/dev/null; then
  alias v="nvim"
elif command -v vim &>/dev/null; then
  alias v="vim"
elif command -v vi &>/dev/null; then
  alias v="vi"
fi

if command -v emacs &>/dev/null; then
  alias e="emacs -nw"
  alias ew="emacs"
fi

if command -v tmux &>/dev/null; then
  alias t="tmux"
fi

if command -v hub &>/dev/null; then
  alias g="hub"
elif command -v git &>/dev/null; then
  alias g="git"
fi

if command -v exa &>/dev/null; then
  ignore_list=".git|node_modules"

  l() {
    exa --long --classify --color=always --color-scale --all --ignore-glob="${ignore_list}" --header --git "$@"
  }

  li() {
    l --ignore-glob="${ignore_list}|$1" "${@:2}"
  }

  lg() {
    l --grid "$@"
  }

  lgi() {
    lg --ignore-glob="${ignore_list}|$1" "${@:2}"
  }

  lt() {
    l --tree "$@"
  }

  lti() {
    lt --ignore-glob="${ignore_list}|$1" "${@:2}"
  }

  ltl() {
    lt --level="$@"
  }

  ltli() {
    ltl "$1" --ignore-glob="${ignore_list}|$2" "${@:3}"
  }
else
  alias l="ls -AFGl"
fi

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias .........="cd ../../../../../../../.."

# Shows the last 10 visited directories
alias ds="dirs -v | head -10"

############################################################################
#### Completion

# Cycle through matches for completion
bind "TAB":menu-complete

# Displays a list of the matching files
bind "set show-all-if-ambiguous on"

# First Tab only performs partial completion
bind "set menu-complete-display-prefix on"

# Makes matching case-insensitive
bind "set completion-ignore-case on"

############################################################################
#### Editor

# Allows editting commands in line editor with emacs operations
set -o emacs

# Sets default editor
if command -v nvim &>/dev/null; then
  export EDITOR="nvim"
elif command -v vim &>/dev/null; then
  export EDITOR="vim"
elif command -v vi &>/dev/null; then
  export EDITOR="vi"
fi
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

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

# Doesn’t overwrite existing files with '>' but uses '>!' instead
set -o noclobber

# Enter directory path to automatically cd into the directory
shopt -s autocd

############################################################################
#### Prompt

# Solarized colors
bold=$(tput bold)
base03=$(tput setaf 234)
base02=$(tput setaf 235)
base01=$(tput setaf 240)
base00=$(tput setaf 241)
base0=$(tput setaf 244)
base1=$(tput setaf 245)
base2=$(tput setaf 254)
base3=$(tput setaf 230)
yellow=$(tput setaf 136)
orange=$(tput setaf 166)
red=$(tput setaf 160)
magenta=$(tput setaf 125)
violet=$(tput setaf 61)
blue=$(tput setaf 33)
cyan=$(tput setaf 37)
green=$(tput setaf 64)
reset=$(tput sgr0)

prompt_git_info() {
  # Branch info
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || \
    return 0
  # Dirty info
  local dirty
  if [[ -n $(command git status --porcelain 2> /dev/null | tail -n1) ]]; then
    dirty="${red}✗"
  else
    dirty="${green}✓"
  fi
  # Remote info
  local remote
  if $(echo "$(command git log @{upstream}..HEAD 2> /dev/null)" | grep "^commit" &> /dev/null); then
    remote="${yellow}+"
  fi
  echo "(${ref#refs/heads/}) ${dirty}${remote} "
}

export PS1="${bold}${cyan}\u${reset}${bold}@${magenta}\h ${blue}\w ${yellow}\$(prompt_git_info)${reset}${bold}\$ ${reset}"
