Dotfiles
===================
These are my dotfiles.
I love them dearly. I stole almost all of them.

I have re-written the vimrc enough that it is mine now.
I cannot take credit for the zshrc (thanks ThoughBot)
The rest of the stuff are pretty standard dotfiles.



Install
-------
`ansible-playbook install.yml -i hosts`
It will detect if you are on darwin and attempt to install things with homebrew.
If you have pacman brace yourself; it will install window managers and the like.

# Mac Apps that I use (because I forget)
* [scroll reverser](https://pilotmoon.com/scrollreverser/)
* Iterm2 (terminal emulator)
* i2cssh
* Spectacle (window manager)
* Cloudapp (cloud copy paste)
* Alfred (spotlight on 'roids)
* Homebrew
* Command Line Tools (http://adcdownload.apple.com/Developer_Tools/command_line_tools_os_x_mavericks_for_xcode__late_october_2013/command_line_tools_os_x_mavericks_for_xcode__late_october_2013.dmg)
* Dropbox

The packages that I will install for arch
# ARCH - package name : command name
* xorg                : ------       : Xserver, windows'n shit
* xrandr              : xrandr       : Multihead screen manager
* xcompmgr            : xcompmgr     : Xterm Transparency
* zsh                 : zsh
* git                 : git          : git
* gvim                : vim          : comes with python installed
* cmake               : cmake        : for YouCompleteMe
* wget                : wget         : dotfiles want it
* rsync               : rsync
* i3                  : i3           : All the i3 stuff
* xorg-server         : xorg-server  : j
* xorg-xrandr         : xrandr       : multiscreens
* xorg-xinit          : startx       : gives you startx
* rxvt-unicode        : rxvt-unicode : gives you your terminal
* chromium            : chromium     : browser!
  Then pacaur from the AUR
* htop                : htop         : system health
Backgrounds
* feh                 : feh          :
Arch install process required packages
* gptfdisk            : gptfdisk     : arch install process...
* syslinux            : syslinux     : arch install process...
* grub                : grub         : arch install process...
