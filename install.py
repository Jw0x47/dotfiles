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
emacs_package_list = ['rainbow-mode',
                      'evil',
                      'evil-matchit',
                      'solarized-theme']
homebrew_list = ['wget',
                 'fortune']

gems_list = ['puppet',
             'puppet-lint',
             'i2cssh']

pip_list = ['flake8']


# Symlinks in dotfiles
def installDotfiles():

    home = os.environ['HOME']
    files_dir = '.dotfiles'
    invalid_files_list = [".git",
                          "install.py"]
    print home+"/"+files_dir
    for each in os.listdir(home+'/'+files_dir):
        if each not in invalid_files_list:
            target = home+'/.'+each
            try:
                os.symlink(os.getcwd()+'/'+each, target)
            except OSError as e:
                print "OS error(%i): %s on file: %s" % (e.errno,
                                                        e.strerror,
                                                        target)


# install emacs packages
def installEmacsPackages(package_list):
    command_array = ["/Applications/Emacs.app/Contents/MacOS/Emacs",
                     "--batch",
                     "-l",
                     "~/.dotfiles/emacs.packages",
                     "--eval=\"(list-packages)\""]
    proc = subprocess.Popen(' '.join(command_array),
                            stdout=subprocess.PIPE,
                            shell=True)
    proc.wait()
    for each in package_list:
        print "Installing emacs package: %s" % each
        app = "/Applications/Emacs.app/Contents/MacOS/Emacs"
        flag = '--batch -l ~/.dotfiles/emacs.packages'
        expr = "--eval=\"(package-install '%s)\"" % (each)
        argsarray = [app, flag, expr]
        print ' '.join(argsarray)
        proc = subprocess.Popen(' '.join(argsarray),
                                stdout=subprocess.PIPE,
                                shell=True)
        proc.wait()


# install vim packages
def installVimPackages(sudo, python):
    proc = subprocess.Popen("vim +BundleInstall +qall",
                            stdout=subprocess.PIPE,
                            shell=True)
    proc.wait()
    home = os.environ['HOME']
    conflictDirs = ["/.vim/bundle/snipmate.vim/snippets",
                    "/vim/bundle/syntastic/syntax_checkers/puppet"]
    for directory in conflictDirs:
        if os.path.isdir(home+directory):
            shutil.rmtree(home+directory)
    # pip install is here because they are dependancies for vim
    if python:
        installPythonPackages(sudo)


def installPythonPackages(sudo):
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
    args = parser.parse_args()
    sys.exit(main())

#  tic -o ~/.terminfo \
# /Applications/Emacs.app/Contents/Resources/etc/e/eterm-color.ti
