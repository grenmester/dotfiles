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

# Shows the last 10 visited directories
alias ds="dirs -v | head -10"

if command -v hub &>/dev/null; then
    alias g="hub"
elif command -v git &>/dev/null; then
    alias g="git"
fi

if command -v exa &>/dev/null; then
    alias l='exa --color=always --color-scale --all --ignore-glob ".git" --long --git --header'

    function li() {
        local ignore=""
        for i in ${1+"$@"}; do
            ignore+="|$i"
        done
        exa --color=always --color-scale --all --ignore-glob ".git$ignore" --long --git --header
    }

    alias lg='exa --color=always --color-scale --grid --all --ignore-glob ".git" --long --git --header'

    function lgi() {
        local ignore=""
        for i in ${1+"$@"}; do
            ignore+="|$i"
        done
        exa --color=always --color-scale --grid --all --ignore-glob ".git$ignore" --long --git --header
    }

    alias lt='exa --color=always --color-scale --tree --all --ignore-glob ".git" --long --git --header'

    function lti() {
        local ignore=""
        for i in ${1+"$@"}; do
            ignore+="|$i"
        done
        exa --color=always --color-scale --tree --all --ignore-glob ".git$ignore" --long --git --header
    }

    function ltl() {
        exa --color=always --color-scale --tree --all --level=$1 --ignore-glob ".git" --long --git --header
    }

    function ltli() {
        local ignore=""
        for i in ${2+"$@"}; do
            ignore+="|$i"
        done
        exa --color=always --color-scale --tree --all --level=$1 --ignore-glob ".git$ignore" --long --git --header
    }
fi

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias .........="cd ../../../../../../../.."
alias ..........="cd ../../../../../../../../.."

############################################################################
#### Environmental Variables

#Environmental Variables
export PATH=/opt/perl512/bin:/usr/local/openresty/bin:/usr/local/openresty/nginx/sbin:$HOME/git/resty-cli/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/texlive/2014/bin/x86_64-darwin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:/usr/share/man:/usr/local/share/man
export PGDATA=/usr/local/pgsql/data
export TERM=xterm-256color
export CLICOLOR=1

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

function parse_git_dirty {
    if [[ -n $(git status -s 2> /dev/null |grep -v ^# | grep -v "working directory clean" ) ]]; then
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
