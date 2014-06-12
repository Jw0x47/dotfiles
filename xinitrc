exec i3 -V >> ~/.i3/i3.log 2>&1

if [ -s ~/.Xmodmap ];
then
  xmodmap ~/.Xmodmap
fi
