#!/usr/bin/sh

currentOrientation=`(xrandr --listmonitors | awk '{print $3}' | sed -n '/^1080/p')`

#export DISPLAY=:0

brightness1=0.7
brightness2=1

ORIENTATION=none

rotate() {
    if [[ $currentOrientation = "1080/531x1920/299+1920+0" ]]; then
        ORIENTATION=portrait
    else
        ORIENTATION=landscape
    fi

    if [[ $ORIENTATION = portrait ]]; then
        xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate normal --brightness $brightness1 --output DP-0 --off --output DP-1 --off --output DVI-D-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --brightness $brightness2
    elif [[ $ORIENTATION = landscape ]]; then
        xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate left --brightness $brightness1 --output DP-0 --off --output DP-1 --off --output DVI-D-1 --primary --mode 1920x1080 --pos 0x387 --rotate normal --brightness $brightness2
    fi

    wallpaper-engine
}



if [[ -n $1 ]]; then
   if [[ $1 = "--toggle" ]]; then
      rotate "$ORIENTATION"
   elif [[ $1 = "--set" ]]; then
       if [[ $2 = "landscape" ]]; then
			rotate landscape
      elif [[ $2 = "portrait" ]]; then
			rotate portrait
      fi
   fi
fi