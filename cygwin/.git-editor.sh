#!/bin/sh

# Script to setup your prefered editor in git.
# Script is designed for Windows while using Cygwin

# I had problems setting up the editor because using "$*" would open the
# COMMIT_EDITMSG file of an emulated drive. Using the windows version of the cygpath fixes this!

# USAGE:
# Save this script in a location (Preferably without spaces)
# Pass the script to git like this:
# git config --global core.editor PathTo/GitEditor.sh

"C:/Program Files/Sublime Text 3/subl.exe" --wait --multiInstance "$(cygpath --windows "${1}")"
