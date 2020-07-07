#!/bin/bash
# xinitrc

userresources=$XDG_CONFIG_HOME/Xresources
usermodmap=$XDG_CONFIG_HOME/Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    # shellcheck source=/dev/null
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset r rate 170 50 &
setxkbmap -layout se -variant nodeadkeys
setxkbmap -option caps:escape

exec i3 -V >> "$XDG_CACHE_HOME/i3/i3log-$(date +'%F-%k-%M-%S')" 2>&1
