#!/bin/sh

# Set brightness via xbrightness when redshift status changes

# Set brightness values for each status.
# Range from 1 to 100 is valid
brightness_day="70"
brightness_transition="50"
brightness_night="20"
# Set fade time for changes to one minute
fade_time=60000

case $1 in
  period-changed)
    case $3 in
      night)
        light -S $brightness_night
        ;;
      transition)
        light -S $brightness_transition
        ;;
      daytime)
        light -S $brightness_day
        ;;
    esac
    ;;
esac
