#!/bin/sh
setx b off
xrdb -merge ~/.Xresources
urxvtd -q -f -o &
pulseaudio --start &
compton &
udiskie &
dunst &
mopidy &
exec i3
