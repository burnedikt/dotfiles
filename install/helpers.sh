#!/usr/bin/env bash
#
# bootstrap installs things.
#
# Graciously taken from https://github.com/holman/dotfiles.

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
