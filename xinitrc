# jbk Xinitrc

# Merge Xresources
xrdb merge ~/.Xresources

# Disable caps lock
setxkbmap -option caps:none

# Start openbox
exec openbox-session

