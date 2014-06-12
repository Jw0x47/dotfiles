#!/bin/bash
xrandr --output HDMI-0 --auto --output DVI-0 --auto --right-of HDMI-0
feh  --bg-scale '~/.dotfiles/backgrounds/dark_penguin_linux.png'
(xcompmgr &)
