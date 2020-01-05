# Source other X settings.
xrdb ~/.Xresources

# X keyboard settings.
setxkbmap -option caps:escape
setxkbmap se
xset r rate 225 25

# Launch applets.
nm-applet &
blueman-applet &
redshift &

# Background image.
feh --bg-scale ~/config/yoga900/background.jpeg
exec i3 --shmlog-size=26214400
