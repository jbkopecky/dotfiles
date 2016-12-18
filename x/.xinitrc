#!/bin/sh

# source .xresources
xrdb -merge ~/.Xresources

# No Bell
setx b off

# urxvt daemon
urxvtd -q -f -o &

# Pulseaudio
pulseaudio --start &

# mpd
mpd &

# Devmon
udiskie &

# bar
wal -i "$(< "${HOME}/.cache/wal/wal")"

wal-set -r



#  Start openbox
exec openbox-session

