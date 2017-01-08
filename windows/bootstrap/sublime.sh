#!/usr/bin/env bash
# this is the directory in which this file resides
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. & pwd )"
# convert windows to Unix path
SUBLIMEDIR=$(echo "/$APPDATA" | sed 's/\\/\//g' | sed 's/://')
SUBLIMEDIR=$SUBLIMEDIR/Sublime\ Text\ 3/Packages/User
# symlink the prefs folder
sync_sublime () {
  local overwrite_all=false backup_all=false skip_all=false
  symlink $DOTFILES_DIR/sublime/Packages/User "$SUBLIMEDIR"
}

sync_sublime
