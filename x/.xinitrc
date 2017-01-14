#!/bin/sh

xrdb -merge ~/.Xresources
setx b off
urxvtd -q -f -o &
pulseaudio --start &
udiskie &
dunst &
mopidy &
wal -i "$(< "${HOME}/.cache/wal/wal")"
wal-set -r
exec openbox-session

