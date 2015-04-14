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

# Arch apps are in the variables file

# Random Notes:

- `/etc/sysctl.d/20-quiet-printk.conf` contains `kernel.printk = 3 3 3 3` to
  prevent various logs from printing to tty1 on boot.
