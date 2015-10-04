#!/bin/bash
#######################################
# .make.sh
#######################################

#----------------
# Variables
#----------------

dir=~/ProfilesAndCustomizations/DotFiles
olddir=~/ProfilesAndCustomizations/DotFiles_old
#list of files/folders to symlink in root
files="bash_profile bashrc prompt.sh svnColor.py vim vimrc"

#----------------
# Script
#----------------

# Create ProfilesAndCustomizations directory
echo "Creating $olddir for backup of any existing files"
mkdir -p $olddir
echo "...done"

# Change to the ProfilesAndCustomizations directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# Move existing dot files in homedir to DotFiles_old directory
echo "starting backup and placing of dot files"
for file in $files; do
    echo "Moving existing $files from ~ to $olddir"
    mv ~/.$files ~/DotFiles_old/
    echo "Creating symlink to $files in home directory"
    ln -s $dir/$files ~/.$files
    echo "...done"
echo "...done"





