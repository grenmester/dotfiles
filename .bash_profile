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
#### Environmental Variables

export PATH=/opt/perl512/bin:/usr/local/openresty/bin:/usr/local/openresty/nginx/sbin:$HOME/git/resty-cli/bin:/usr/local/texlive/2014/bin/x86_64-darwin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PGDATA=/usr/local/pgsql/data

############################################################################
#### Man

function man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;32m") \
    LESS_TERMCAP_md=$(printf "\e[1;34m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[30;48;5;244m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[4;33m") \
    man $@
}

############################################################################
#### Prompt

# Solarized Colors
BASE03=$(tput setaf 234)
BASE02=$(tput setaf 235)
BASE01=$(tput setaf 240)
BASE00=$(tput setaf 241)
BASE0=$(tput setaf 244)
BASE1=$(tput setaf 245)
BASE2=$(tput setaf 254)
BASE3=$(tput setaf 230)
YELLOW=$(tput setaf 136)
ORANGE=$(tput setaf 166)
RED=$(tput setaf 160)
MAGENTA=$(tput setaf 125)
VIOLET=$(tput setaf 61)
BLUE=$(tput setaf 33)
CYAN=$(tput setaf 37)
GREEN=$(tput setaf 64)
BOLD=$(tput bold)
RESET=$(tput sgr0)

GIT_THEME_PROMPT_DIRTY='✗'
GIT_THEME_PROMPT_UNPUSHED='+'
GIT_THEME_PROMPT_CLEAN='✓'

function parse_git_dirty() {
  if [[ -n $(git status -s 2> /dev/null |grep -v ^\# | grep -v "working directory clean" ) ]]; then
    echo -ne "${RED}${GIT_THEME_PROMPT_DIRTY}"
  else
    echo -ne "${GREEN}${GIT_THEME_PROMPT_CLEAN}"
  fi
  GIT_CURRENT_BRANCH=$(git name-rev --name-only HEAD 2> /dev/null)
  GIT_ORIGIN_UNPUSHED=$(git log origin/$GIT_CURRENT_BRANCH..$GIT_CURRENT_BRANCH --oneline 2>&1 | awk '{ print $1 }')
  if [[ $GIT_ORIGIN_UNPUSHED != "" ]]; then
    echo -e "${YELLOW}${GIT_THEME_PROMPT_UNPUSHED}"
  fi
}

function parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1) $(parse_git_dirty) /"
}

export PS1="\[${BOLD}${MAGENTA}\]\u\[$BASE1\]@\[$ORANGE\]\h \[$BLUE\]\w\[$WHITE\] \$([[ -n \$(git branch 2> /dev/null) ]])\[$VIOLET\]\$(parse_git_branch)\[$BASE1\]\$ \[$RESET\]"
export PS2="\[${BOLD}${MAGENTA}\]→ \[$RESET\]"
