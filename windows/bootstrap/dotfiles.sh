#!/usr/bin/env bash

# symlink all required files
link_dotfiles() {
  # this is the path to the parent folder to the one in which this file resides
  local BASE_SYMLINK_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
  local overwrite_all=false backup_all=false skip_all=false
  # git
  link_dotfiles_from_folder $BASE_SYMLINK_DIR/git
  # bash
  link_dotfiles_from_folder $BASE_SYMLINK_DIR/bash
}
# go ahead
link_dotfiles
success "All dotfiles for platform windows successfully synced"
