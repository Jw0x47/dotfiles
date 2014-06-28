#!/usr/bin/python
'''
Installs your dotfiles
'''
import argparse
import sys
import os
import subprocess
import shutil

# Global Variables and lists of crap
mac_os = ['Darwin']
linux_os = ['not Darwin']
homebrew_list = ['wget',
                 'fortune']

gems_list = ['puppet',
             'puppet-lint',
             'i2cssh']

pip_list = ['flake8']


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'


# Symlinks in dotfiles
def installDotfiles():
    home = os.environ['HOME']
    files_dir = '.dotfiles'
    invalid_files_list = [".git",
                          "install.py"]
    for each in os.listdir(home+'/'+files_dir):
        if each not in invalid_files_list:
            target = home+'/.'+each
            # First try...
            try:
                os.remove(target)
            except OSError as e:
                print bcolors.OKBLUE
                print "Error(%i): %s while removing file %s" % (e.errno,
                                                                e.strerror,
                                                                target)
                print bcolors.ENDC
            try:
                os.symlink(os.getcwd()+'/'+each, target)
            except OSError as e:
                print "OS error(%i): %s on file: %s" % (e.errno,
                                                        e.strerror,
                                                        target)


# install vim packages
def installVimPackages(sudo, python):
    print bcolors.OKBLUE + 'OKBLUE: ~/.vim is not a symlink' + bcolors.ENDC
    proc = subprocess.Popen("vim +PluginInstall +qall",
                            stdout=subprocess.PIPE,
                            shell=True)
    proc.wait()
    home = os.environ['HOME']
    conflictDirs = ["/vim/bundle/syntastic/syntax_checkers/puppet"]
    for directory in conflictDirs:
        if os.path.isdir(home+directory):
            shutil.rmtree(home+directory)


def installPythonPackages(sudo):
    if not sudo:
        message = '[ERROR] Cannont install python packages w/o sudo for pip!'
        print bcolors.FAIL + message + bcolors.ENDC
        sys.exit(1)

    for package in pip_list:
        args = ['pip',
                'install',
                package]
        if sudo:
            s = 'sudo'
            args = [s] + args
            s = s+' '
        else:
            s = ''
            print '%sInstalling %s' % (s, package)
            proc = subprocess.Popen(args)
            proc.wait()
            if proc.returncode != 0:
                print 'pip install failed what a fucking surprise'
                sys.exit(1)


# Installs gems; Only want to call this on MacOs
def installGems(sudo):
    for gem in gems_list:
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
        c = '"$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"'
        proc = subprocess.Popen('ruby',
                                '-e',
                                c)
        proc.wait()
    else:
        print 'Brew already installed'

    # Install programs
    proc = subprocess.Popen(['brew', 'install'] + homebrew_list,
                            stdout=subprocess.PIPE)
    proc.wait()
    print proc.stdout.read()


# Handles crap like figuring out which things to install/what os we're on etc.
def main():
    OS = subprocess.Popen('uname',
                          stdout=subprocess.PIPE).stdout.read().strip()
    print "OS detected as: %s" % OS
    con_text = "Do you really want to blow away your old dotfiles [y/n]? "
    confirmation = raw_input(con_text)

    if confirmation == 'y' or confirmation == 'yes':
        if OS in mac_os:
            installHomebrewCrap(homebrew_list)
        installDotfiles()
        if args.emacs:
            print "NO FUCK YOU NO EMACS HERE"
            # installEmacsPackages(emacs_package_list)
        if args.gems:
            installGems(args.sudo)
        if args.vim:
            installVimPackages(args.sudo, args.python)
        if args.python:
            installPythonPackages(args.sudo)
    else:
        print 'Exiting per user command'
        sys.exit(0)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    parser.add_argument("--sudo",
                        help="Sudo certain installs",
                        action="store_true")

    parser.add_argument("--gems",
                        help="Install gems",
                        action="store_true")

    parser.add_argument("--emacs",
                        help="Install emacs and plugins",
                        action="store_true")
    parser.add_argument("--vim",
                        help="Install vim plugins / dotfiles",
                        action="store_true")
    parser.add_argument("--python",
                        help="Install python dependencies",
                        action="store_true")
    args = parser.parse_args()
    sys.exit(main())
