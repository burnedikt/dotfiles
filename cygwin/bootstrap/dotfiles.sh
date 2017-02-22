#!/usr/bin/env bash

# symlink all required files
link_dotfiles() {
  local overwrite_all=false backup_all=false skip_all=false
  # git
  link_dotfiles_from_folder $DOTFILES_ROOT/cygwin/git
  # cross-platform dotfiles
  link_dotfiles_from_folder $DOTFILES_ROOT/cross-platform
  # (git-)bash
  link_dotfiles_from_folder $DOTFILES_ROOT/windows/bash
  # zsh (1) cross-platform
  link_dotfiles_from_folder $DOTFILES_ROOT/zsh
  # zsh (2) cygwin-platform
  link_dotfiles_from_folder $DOTFILES_ROOT/cygwin/zsh
  # windows specific aliases
  symlink $DOTFILES_ROOT/cygwin/.win-aliases $HOME/.win-aliases
  # zgen
  symlink $DOTFILES_ROOT/zsh/zgen $HOME/.zgen
  # sublime editor script for git
  symlink $DOTFILES_ROOT/cygwin/.git-editor.sh $HOME/.git-editor.sh
}
# go ahead
link_dotfiles
success "All dotfiles for platform cygwin successfully synced"
