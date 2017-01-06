#!/usr/bin/env bash
#
# bootstrap installs things.
#
# Graciously taken from https://github.com/holman/dotfiles.
# ... and https://github.com/agross/dotfiles

# Show executed commands.
# set -x

light_red="\e[01;31m"
green="\e[0;32m"
light_green="\e[01;32m"
light_yellow="\e[01;33m"
cyan="\e[0;36m"
light_cyan="\e[01;36m"
reset_color="\e[0m"
clear_line="\e[2K"

info() {
  printf   "\r  [%b INFO %b] %b\n" $light_cyan $reset_color "$1"
}

user() {
  printf   "\r  [%b  ?   %b] %b " $light_yellow $reset_color "$1"
}

warn() {
  printf   "\r  [%b WARN %b] %b " $light_yellow $reset_color "$1"
}

success() {
  printf "\r%b  [%b  OK  %b] %b\n" $clear_line $light_green $reset_color "$1"
}

fail() {
  printf "\r%b  [%b FAIL %b] %b\n\n" $clear_line $light_red $reset_color "$1"
  exit 1
}

# easily determine the platform we're on
# use like this:
# if [[ "$(platforms)" == 'mac' ]]; then
#   ...
# fi
platforms() {
  case "$OSTYPE" in
    linux*)  printf 'linux';;
    darwin*) printf 'mac';;
    msys)    printf 'windows';;
    cygwin)  printf "cygwin";;
    *)       printf "$OSTYPE";;
  esac
}

symlink() {
  local src="${1?Need link source}"
  # If dst is not given, use src file name in $HOME, prepended with a dot.
  local dst="$2"
  if [[ -z "$dst" ]]; then
    local filename="$(basename "$src")"
    local dst="$HOME/.$filename"
  fi

  local overwrite= backup= skip=
  local action=

  if [[ -f "$dst" ]] || \
     [[ -d "$dst" ]] || \
     [[ -L "$dst" ]]; then
    if [[ "$overwrite_all" == "false" ]] && \
       [[ "$backup_all" == "false" ]] && \
       [[ "$skip_all" == "false" ]]; then
      local current_target="$(readlink "$dst")"
      echo $current_target
      echo $src
      if [[ "$current_target" == "$src" ]]; then
        skip=true;
      else
        user "$(printf "File already exists: %b%s%b (%b%s%b)
           Will be linked to: %b%s%b
           What do you want to do? (%bs%b)kip, (%bS%b)kip all, (%bo%b)verwrite, (%bO%b)verwrite all, (%bb%b)ackup, (%bB%b)ackup all?" \
           $green "$dst" $reset_color \
           $cyan "$(file --brief "$dst")" $reset_color \
           $green "$src" $reset_color \
           $light_yellow $reset_color \
           $light_yellow $reset_color \
           $light_yellow $reset_color \
           $light_yellow $reset_color \
           $light_yellow $reset_color \
           $light_yellow $reset_color)"

        while true; do
          # Read from tty, needed because we read in outer loop.
          read -n 1 action < /dev/tty

          case "$action" in
            o) overwrite=true;     break;;
            O) overwrite_all=true; break;;
            b) backup=true;        break;;
            B) backup_all=true     break;;
            s) skip=true;          break;;
            S) skip_all=true;      break ;;
            *) ;;
          esac
        done
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [[ "$overwrite" == "true" ]]; then
      rm -rf "$dst"
      success "$(printf "Removed %b%s%b" $green "$dst" $reset_color)"
    fi

    if [[ "$backup" == "true" ]]; then
      mv "$dst" "${dst}.backup"
      success "$(printf "Moved %b%s%b to %b%s%b" $green "$dst" $reset_color $green "${dst}.backup" $reset_color)"
    fi

    if [[ "$skip" == "true" ]]; then
      success "$(printf "Skipped %b%s%b == %b%s%b" $green "$src" $reset_color $green "$dst" $reset_color)"
    fi
  fi

  if [[ "$skip" != "true" ]]; then # "false" or empty.
    mkdir -p "$(dirname "$dst")"
    # Create native symlinks on Windows.
    CYGWIN=winsymlinks:nativestrict ln -s "$src" "$dst"
    if [[ $? == 0 ]]; then
      success "$(printf "Linked %b%s%b to %b%s%b" $green "$src" $reset_color $green "$dst" $reset_color)"
    else
      warn "$(printf "Failed linking %b%s%b to %b%s%b" $green "$src" $reset_color $green "$dst" $reset_color)"
    fi
  fi
}

link_dotfiles_from_folder () {
  # enable globs for dotfiles (with leading .)
  shopt -s dotglob
  # get folder
  local base_folder=$1
  if [[ -d $base_folder ]]; then
    for src in ${base_folder%/}/.*
    do
      if [[ -f $src ]]; then
        symlink $src $HOME/$(basename $src)
      fi
    done
  else
    fail "$(printf "Folder %b%s%b does not exist. No dotfiles could be linked" $green "$base_folder" $reset_color)"
  fi
  # disable globs for dotfiles (with leading .)
  shopt -u dotglob
}
