#!/usr/bin/python
'''
Installs your dotfiles
'''
import argparse
import sys
import os
import subprocess
import time
import pdb

# Global Variables and lists of crap
mac_os = ['Darwin']
linux_os = ['not Darwin']
emacs_package_list = ['rainbow-mode',
                      'evil',
                      'evil-matchit',
                      'evil-surround']
homebrew_list = ['wget',
                 'fortune']
gems_list = ['puppet',
             'puppet-lint',
             'i2cssh']

# Symlinks in dotfiles
def installDotfiles():

    home = '..'
    files_dir = os.getcwd()
    invalid_files_list = [".git",
                          "install.py"]

    for each in os.listdir('.'):
        if each not in invalid_files_list:
            target = home+'/.'+each
            try:
                os.symlink(os.getcwd()+'/'+each, target)
            except OSError as e:
                print "OS error(%i): %s on file: %s" % (e.errno, e.strerror, target)
    
'''
install emacs packages
'''
def installEmacsPackages(package_list):
    app = installEmacs()
    for each in package_list:
        print "Installing emacs package: %s" % each
        app = "/Applications/Emacs.app/Contents/MacOS/Emacs"
        flag = '--batch -l ~/.emacs'
        expr = "--eval=\"(package-install '%s)\"" % (each)
        argsarray = [app, flag, expr]
        print ' '.join(argsarray)
        proc = subprocess.Popen(' '.join(argsarray), stdout=subprocess.PIPE, shell=True)
        proc.wait()


'''
Installs gems;
Only want to call this on MacOs
'''
def installGems(gem_list, sudo):
    for gem in gem_list:
        args = ['gem',
                'install',
                gem]
        if sudo:
            s = 'sudo'
            args = [s] + args
            s = s+' '
        else:
            s = ''

            print '%sInstalling %s ' % (s, gem)

            proc = subprocess.Popen(args)
            proc.wait()

            if proc.returncode != 0:
                print 'gem install failed'
                sys.exit(1)


def installHomebrewCrap(homebrew_list):
    # check brew
    brew = subprocess.call('brew -h &> /dev/null', shell=True)
    if brew != 0:
        print 'installing homebrew'
     # install brew
        curl = '"$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"'
        proc = subprocess.Popen('ruby',
                                '-e',
                                curl)
        proc.wait()
    else:
        print 'Brew already installed'

    # Install programs
    proc = subprocess.Popen(['brew', 'install' ] + homebrew_list,
                            stdout=subprocess.PIPE)
    proc.wait()
    print proc.stdout.read()


'''
Handles crap like figuring out which things to install/what os we're on etc.
'''
def main():
    OS = subprocess.Popen('uname',
                              stdout=subprocess.PIPE).stdout.read().strip()
    print "OS detected as: %s" % OS
    con_text = "Do you really want to blow away your old dotfiles? "
    confirmation = raw_input(con_text)

    if confirmation == 'y' or confirmation == 'yes':
        if OS in mac_os:
            installHomebrewCrap(homebrew_list)
        installDotfiles()
    if args.emacs:
         installEmacsPackages(emacs_package_list)
    if args.gems:
        installGems(gems_list, args.sudo)
    else:
        print 'Exiting per user command'
        sys.exit(0)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    parser.add_argument("--sudo",
                        help="Specify whether or not to sudo certain installs",
                        action="store_true")

    parser.add_argument("--gems",
                        help="Specify whether or not to install gems",
                        action="store_true")

    parser.add_argument("--emacs",
                        help="Specify whether or not to install emacs and plugins",
                        action="store_true")

    args = parser.parse_args()
    sys.exit(main())

#  tic -o ~/.terminfo \
        #/Applications/Emacs.app/Contents/Resources/etc/e/eterm-color.ti
