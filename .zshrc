#!/usr/bin/env zsh

############################################################################
#### Zplug

export ZPLUG_HOME=/usr/local/opt/zplug

if [[ -f $ZPLUG_HOME/init.zsh ]]; then
    source $ZPLUG_HOME/init.zsh

    zplug "zplug/zplug", hook-build:"zplug --self-manage"

    if ! zplug check; then
        zplug install
    fi

    zplug load
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
    alias e="emacs"
fi

# Shows the last 10 visited directories
alias ds="dirs -v | head -10"

if (( $+commands[hub] )); then
    alias g="hub"
elif (( $+commands[git] )); then
    alias g="git"
fi

if (( $+commands[exa] )); then
    alias l='exa --classify --color=always --color-scale --all --ignore-glob ".git" --long --git --header'

    function li() {
        local ignore=""
        for i in ${1+"$@"}; do
            ignore+="|$i"
        done
        exa --classify --color=always --color-scale --all --ignore-glob ".git$ignore" --long --git --header
    }

    alias lg='exa --classify --color=always --color-scale --grid --all --ignore-glob ".git" --long --git --header'

    function lgi() {
        local ignore=""
        for i in ${1+"$@"}; do
            ignore+="|$i"
        done
        exa --classify --color=always --color-scale --grid --all --ignore-glob ".git$ignore" --long --git --header
    }

    alias lt='exa --classify --color=always --color-scale --tree --ignore-glob ".git" --long --git --header'

    function lti() {
        local ignore=""
        for i in ${1+"$@"}; do
            ignore+="|$i"
        done
        exa --classify --color=always --color-scale --tree --ignore-glob ".git$ignore" --long --git --header
    }

    function ltl() {
        exa --classify --color=always --color-scale --tree --level=$1 --ignore-glob ".git" --long --git --header
    }

    function ltli() {
        local ignore=""
        for i in ${2+"$@"}; do
            ignore+="|$i"
        done
        exa --classify --color=always --color-scale --tree --level=$1 --ignore-glob ".git$ignore" --long --git --header
    }
else
    alias l='ls -FGA'
fi

alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
alias -g ......="../../../../.."
alias -g .......="../../../../../.."
alias -g ........="../../../../../../.."
alias -g .........="../../../../../../../.."
alias -g ..........="../../../../../../../../.."

############################################################################
#### Editor

# Allows editting commands in zle with emacs operations
set -o emacs

# Sets default editor
if (( $+commands[emacs] )); then
    export EDITOR="emacs"
fi
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

############################################################################
#### Environmental Variables

path=(
    "/opt/perl512/bin"
    "/usr/local/openresty/bin"
    "/usr/local/openresty/nginx/sbin"
    "$HOME/git/resty-cli/bin"
    "/Library/TeX/texbin"
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
    "/usr/sbin"
    "/sbin"
)
export PATH

export PGDATA="/usr/local/pgsql/data"

############################################################################
#### Glob

# Makes globs case-insensitive
unsetopt case_glob

# Makes globbing regexes case-insensitive
unsetopt case_match

# Allows globs to match dotfiles
setopt glob_dots

# Sorts numeric filenames numerically instead of lexicographically
setopt numeric_glob_sort

############################################################################
#### History

# History file location
export HISTFILE=~/.zsh_history

# Removes the specified commands from the history
export HISTIGNORE="ls:[bf]g:exit:reset:clear:htop"

# Number of lines saved in a session
export HISTSIZE=25000

# Number of lines saved in the history file
export SAVEHIST=10000

# Uses OS-provided locking mechanisms for the history file if available to possibly improve performance and decrease the chance of corruption
setopt hist_fcntl_lock

# Prevents the current line from being saved in the history if it is the same as the previous one
setopt hist_ignore_dups

# Removes superfluous blanks from the history
setopt hist_reduce_blanks

# Expands command instead of immediately executing it when using history expansion
setopt hist_verify

# Incrementally append new history lines to history file rather than waiting until the shell exits
setopt inc_append_history

# Disables sharing history between different zsh sessions
unsetopt share_history

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
#### Miscellaneous

# Uses commas in ls, du, df file size output
export BLOCK_SIZE="'1"

# Colored output on macOS
export CLICOLOR=1

# Prints command execution time if command takes longer than 10 seconds
export REPORTTIME=10

# Background processes aren't killed on exit of shell
setopt auto_continue

# Enter directory path to automatically cd into the directory
setopt autocd

# Makes cd push the old directory onto the directory stack
setopt autopushd

# Attempts to correct spelling of all arguments in a line
setopt correct_all

# Allows comments in the interactive shell
setopt interactive_comments

# Doesn’t overwrite existing files with '>' but uses '>!' instead
setopt noclobber

# Swaps the meaning of '-' and '+' when used as arguments to cd so '-' means reading from the top of the stack when accessing an entry from the directory stack
setopt pushdminus

# Prompts for confirmation after 'rm *'-ish commands to avoid accidentally wiping out directories
setopt rm_star_wait

############################################################################
#### Prompt

# Enable parameter expansion and other substitutions in $PROMPT
setopt prompt_subst

GIT_THEME_PROMPT_DIRTY='✗'
GIT_THEME_PROMPT_UNPUSHED='+'
GIT_THEME_PROMPT_CLEAN='✓'

function parse_git_dirty() {
   if [[ -n $(git status -s 2> /dev/null |grep -v ^\# | grep -v "working directory clean" ) ]]; then
       echo -ne "%F{160}${GIT_THEME_PROMPT_DIRTY}"
   else
       echo -ne "%F{64}${GIT_THEME_PROMPT_CLEAN}"
   fi
   GIT_CURRENT_BRANCH=$(git name-rev --name-only HEAD 2> /dev/null)
   GIT_ORIGIN_UNPUSHED=$(git log origin/$GIT_CURRENT_BRANCH..$GIT_CURRENT_BRANCH --oneline 2>&1 | awk '{ print $1 }')
   if [[ $GIT_ORIGIN_UNPUSHED != "" ]]; then
       echo -e "%F{136}${GIT_THEME_PROMPT_UNPUSHED}"
   fi
}

function parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1) $(parse_git_dirty) /"
}

PROMPT='%B%F{33}%~ %F{61}$(parse_git_branch)%F{245}$ %f%b'
if (( $+commands[battery] )); then
    RPROMPT='%B%F{125}%n%F{245}@%F{166}%m $(battery -zp)%f%b'
else
    RPROMPT='%B%F{125}%n%F{245}@%F{166}%m%f%b'
fi
