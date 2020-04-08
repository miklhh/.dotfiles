#
# Source X-client resources file.
#
xrdb ~/.Xresources

#
# Keyboard settings. Swedish keyboard layout with ESC and CAPS_LOCK swaped. Also
# set a comfortable repeat delay and rate.
#
setxkbmap -option caps:escape
setxkbmap se
xset r rate 225 25

#
# Disable touchscreen on GLaDOS.
#
[ "$(hostname)" = "GLaDOS" ] && xinput disable 10

#
# Launch applets.
#
command -v "nm-applet" && nm-applet &
command -v "blueman-applet" && blueman-applet &
command -v "redshift" && redshift -t 5500:3500 &

#
# Set background image.
#
BACKGROUND_IMAGE="$HOME/.config/background.jpeg"
[ -f "$BACKGROUND_IMAGE" ] && feh --bg-scale "$BACKGROUND_IMAGE"

#
# Start i3 window manager.
#
exec i3 --shmlog-size=26214400
