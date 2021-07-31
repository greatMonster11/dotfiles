# The lockscreen will be the captured image from current screens
# then converted into pixels with blur effect

img=/home/npthanh/Pictures/Wallpapers/lockscreen.png

scrot -o $img
convert $img -scale 10% -scale 1000% $img

i3lock -u -i $img
