#!/bin/sh

export DUNST_FONT="Artwiz Lemon 7"
export DUNST_SIZE="300x30-40+70"

xsetroot -cursor_name left_ptr

pulseaudio --start &
dunst -fn "$DUNST_FONT" -geometry "$DUNST_SIZE" &
urxvtd -q -f &
mpd &
udiskie &
dropbox &

xrdb -merge ~/.Xresources

wal -R -o wal-set

sxkhd &
exec bspwm
