#!/usr/bin/env zsh

############################################################################
#### Aliases

alias vi="vim"
alias g="git"
alias ls="ls --classify --color"

if (( $+commands[hub] )); then
    alias git="hub"
fi

if (( $+commands[exa] )); then
    alias l="exa --header --long --grid"
    alias lt="exa --header --long --tree"
    alias ltl="exa --header --long --tree --level"
fi

############################################################################
#### Editor

# Allows editting commands with vi operations
set -o vi

if (( $+commands[vim] )); then
    export EDITOR="vim"
    export USE_EDITOR=$EDITOR
    export VISUAL=$EDITOR
fi

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

# Doesn’t overwrite existing files with '>' but uses '>!' instead
setopt noclobber

# Prompts for confirmation after 'rm *'-ish commands to avoid accidentally wiping out directories
setopt rm_star_wait

############################################################################
#### Prompt

# Enable parameter expansion and other substitutions in $PROMPT
setopt prompt_subst

PROMPT="%B%F{125}%n%F{245}@%F{166}%m %F{33}%~ %F{245}$ %f%b"
