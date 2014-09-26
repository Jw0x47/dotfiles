#!/bin/bash
FILES_DIR=~/.dotfiles/ansible/roles/dotfiles/files
cd $FILES_DIR
for FILE in $(ls $FILES_DIR)
do
  rsync -avz ~/.$FILE . --delete
done
