DEFAULT_WALL="$HOME/Pictures/Wallpapers/sea_sunrise.jpg"
WALL="/home/jb/Pictures/Wallpapers/sea_sunrise.jpg"

if [[ -f $WALL ]]; then
    feh --bg-fill "$WALL"
else
    feh --bg-fill "$DEFAULT_WALL"
fi