#!/usr/bin/env bash

# symlink all required files
link_dotfiles() {
  DOTFILES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && pwd )"
  local overwrite_all=false backup_all=false skip_all=false
  # git
  link_dotfiles_from_folder $DOTFILES_ROOT/macos/git
  # zsh osx-specific
  link_dotfiles_from_folder $DOTFILES_ROOT/macos/zsh
  # cross-platform dotfiles
  link_dotfiles_from_folder $DOTFILES_ROOT/cross-platform
  # sandboxd script
  symlink $DOTFILES_ROOT/sandboxd/sandboxd $HOME/.sandboxd
}
# install zinit as a plugin manager for zsh, see https://github.com/zdharma/zinit
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
# go ahead
link_dotfiles
success "All dotfiles for platform macos successfully linked"
