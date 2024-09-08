#!/usr/bin/env sh

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

dunst &
nitrogen --restore &
picom &
redshift &
exec xmonad
