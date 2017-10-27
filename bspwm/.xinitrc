#!/bin/sh

export DUNST_FONT="Artwiz Lemon 7"
export DUNST_SIZE="300x30-40+70"

xsetroot -cursor_name left_ptr
setxkbmap -option ctrl:nocaps

xrdb -merge ~/.Xresources

pulseaudio --start &
urxvtd -q -f &
mpd &
# udiskie &
# dropbox &
wa &

sxkhd &
exec bspwm
