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
    alias e="emacs -nw"
    alias ew="emacs"
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
export HISTIGNORE="l:ls:[bf]g:exit:reset:clear:htop"

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

# Attempts to correct spelling of commands in a line
setopt correct

# Doesn't attempt to correct spelling of all arguments in a line
unsetopt correctall

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

function prompt_git_info {
  emulate -LR zsh
  # Branch info
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || \
    return 0
  # Dirty info
  local dirty
  if [[ -n $(command git status --porcelain 2> /dev/null | tail -n1) ]]; then
    dirty="%{$fg[red]%}✗"
  else
    dirty="%{$fg[green]%}✓"
  fi
  # Remote info
  local remote
  if $(echo "$(command git log @{upstream}..HEAD 2> /dev/null)" | grep '^commit' &> /dev/null); then
    remote="%{$fg[yellow]%}+"
  fi
  echo "(${ref#refs/heads/}) ${dirty}${remote} "
}

PROMPT='%B%{$fg[blue]%}%~ %{$fg[yellow]%}$(prompt_git_info)%{$fg[default]%}$ %f%b'
RPROMPT='%B%{$fg[cyan]%}%n%{$fg[default]%}@%{$fg[magenta]%}%m%f%b'
